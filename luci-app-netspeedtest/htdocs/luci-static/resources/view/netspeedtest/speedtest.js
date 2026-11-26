'use strict';
'require view';
'require poll';
'require dom';
'require fs';
'require rpc';
'require uci';
'require ui';
'require form';

const TestTimeout = 240 * 1000; // 4 Minutes
const ResultFile = '/tmp/speedtest_result';

var callDownloadOokla = rpc.declare({
	object: 'luci.netspeedtest',
	method: 'download_ookla',
	params: ['arch'],
	expect: { '': {} }
});

var callOoklaVerify = rpc.declare({
	object: 'luci.netspeedtest',
	method: 'ookla_verify',
	expect: { '': {} }
});

var callListServers = rpc.declare({
	object: 'luci.netspeedtest',
	method: 'list_servers',
	expect: { '': {} }
});

var callSpeedtest = rpc.declare({
	object: 'luci.netspeedtest',
	method: 'speedtest',
	params: ['server_id'],
	expect: { '': {} }
});

function getServerList() {
	if (!this.serverList) {
		this.serverList = callListServers().then((reply) => {
			if (!reply || !reply.result || !Array.isArray(reply.servers))
				throw new Error(reply && reply.error || _('Unable to retrieve the server list'));

			const servers = reply.servers.filter((server) =>
				server && /^[1-9][0-9]*$/.test(String(server.id))
			);
			if (!servers.length)
				throw new Error(_('No available servers'));

			return servers;
		}).catch((err) => {
			this.serverList = null;
			throw err;
		});
	}

	return this.serverList;
}

function setOptionValue(section_id, value) {
	const widget = this.getUIElement(section_id);
	if (!widget)
		return false;

	widget.setValue(value);
	const input = widget.node.querySelector('input');
	if (input)
		input.dispatchEvent(new Event('change', { bubbles: true }));

	return !!input;
}

function chooseServer(section_id) {
	return getServerList.call(this).then((servers) => {
		const rows = servers.slice(0, 30).map((server) => {
			const id = String(server.id);
			const provider = server.sponsor || _('Unknown provider');
			const location = [server.name, server.country].filter(Boolean).join(', ');

			return E('tr', {}, [
				E('td', {}, [provider]),
				E('td', {}, [location || '—']),
				E('td', {}, [id]),
				E('td', {}, [E('button', {
					'class': 'btn cbi-button cbi-button-action',
					'click': ui.createHandlerFn(this, (section_id, id) => {
						if (setOptionValue.call(this, section_id, id))
							ui.hideModal();
					}, section_id, id)
				}, [_('Select')])])
			]);
		});

		if (!rows.length)
			throw new Error(_('No available servers'));

		ui.showModal(_('Select a Speedtest server'), [
			E('p', {}, [_('Showing the first 30 servers returned by Ookla.')]),
			E('div', { 'style': 'max-height: 60vh; overflow:auto' }, [
				E('table', { 'class': 'table' }, [
					E('thead', {}, [E('tr', {}, [
						E('th', {}, [_('Provider')]),
						E('th', {}, [_('Location')]),
						E('th', {}, [_('ID')]),
						E('th', {}, [''])
					])]),
					E('tbody', {}, rows)
				])
			]),
			E('div', { 'class': 'right' }, [E('button', {
				'class': 'btn',
				'click': function() { ui.hideModal(); }
			}, [_('Close')])])
		]);
	}).catch((err) => {
		ui.addNotification(null, E('p', _('Unable to load servers: %s').format(err.message || err)), 'error');
	});
}

return view.extend({
//	handleSaveApply: null,
//	handleSave: null,
//	handleReset: null,

	load() {
	return Promise.all([
		callOoklaVerify(),
		L.resolveDefault(fs.read(ResultFile), null),
		L.resolveDefault(fs.stat(ResultFile), {}),
		uci.load('netspeedtest')
	]);
	},

	render(data) {
		const has_ookla = data[0].result;
		const result_content = data[1] ? data[1].trim().split("\n") : [];
		const result_mtime = data[2] ? data[2].mtime * 1000 : 0;
		const preferred_server_id = uci.get(data[3], 'config', 'preferred_server_id') || '';

		let m, s, o;

		m = new form.Map('netspeedtest', _('Ookla SpeedTest'));

		s = m.section(form.TypedSection, '_result');
		s.anonymous = true;
		s.render = function(section_id) {
			const El = E('div', { 'id': 'speedtest_result' }, []);
			const Testing = E('span', { 'class': 'spinning', 'style': 'color:yellow;font-weight:bold' }, [
				_('Testing in progress...')
			]);
			const TestS = function(content) {
				return E('div', { 'style': 'max-width:500px' }, [
					E('a', { 'href': content, 'target': '_blank' }, [
						E('img', { 'src': content + '.png', 'style': 'max-width:100%;max-height:100%;	vertical-align:middle' }, [])
					])
				])
			}
			const NoSer = E('span', { 'style': 'color:red;font-weight:bold' }, [ _('No available servers.') ]);
			const TestF = E('span', { 'style': 'color:red;font-weight:bold' }, [ _('Test failed.') ]);
			const TestN = E('span', { 'style': 'color:red;font-weight:bold;display:none' }, [ _('No result.') ]);

			poll.add(function() {
				return L.resolveDefault(fs.read(ResultFile), null).then((res) => {
					const result_content = res ? res.trim().split("\n") : [];
					const result_stat = document.querySelector('#speedtest_result');

					if (result_content.length) {
						if (result_content[0] == 'Testing')
							dom.content(result_stat, [ Testing ]);
						else if (result_content[0].match(/https?:\S+/))
							dom.content(result_stat, [ TestS(result_content[0]) ]);
						else if (result_content[0] == 'No available servers')
							dom.content(result_stat, [ NoSer ]);
						else if (result_content[0] == 'Test failed')
							dom.content(result_stat, [ TestF ]);
					} else
						dom.content(result_stat, [ TestN ]);
				});
			});

			if (result_content.length) {
				if (result_content[0] == 'Testing')
					El.appendChild(Testing);
				else if (result_content[0].match(/https?:\S+/))
					El.appendChild(TestS(result_content[0]));
				else if (result_content[0] == 'No available servers')
					El.appendChild(NoSer);
				else if (result_content[0] == 'Test failed')
					El.appendChild(TestF);
			} else
				El.appendChild(TestN);

			return El;
		}

		s = m.section(form.NamedSection, 'config', 'netspeedtest');
		s.anonymous = true;

		o = s.option(form.ListValue, '_server_mode', _('Server selection'));
		o.default = /^[1-9][0-9]*$/.test(preferred_server_id) ? 'preferred' : 'auto';
		o.value('auto', _('Automatic (Ookla)'));
		o.value('manual', _('Manually specify a server ID'));
		o.value('preferred', _('Use preferred server'));
		o.onchange = function(ev, section_id, value) {
			this.default = value;
		}
		o.write = function() {};

		o = s.option(form.Value, '_server_id', _('Server ID'));
		o.renderWidget = function(section_id, option_index, cfgvalue) {
			const node = form.Value.prototype.renderWidget.apply(this, arguments);

			if (!this.password)
				node.classList.add('control-group');

			(node.querySelector('.control-group') || node).appendChild(E('button', {
				class: 'cbi-button cbi-button-add',
				title: _('Choose server'),
				click: ui.createHandlerFn(this, chooseServer, section_id)
			}, [ _('Choose server') ]));

			return node;
		}
		o.datatype = 'uinteger';
		o.placeholder = _('Valid positive server ID');
		o.validate = function(section_id, value) {
			return value === '' || /^[1-9][0-9]*$/.test(value) || _('Enter or select a valid positive server ID.');
		}
		o.write = function() {};
		o.depends('_server_mode', 'manual');

		o = s.option(form.Value, 'preferred_server_id', _('Preferred server ID'),
			_('This ID is saved in UCI and becomes the default server for subsequent tests.'));
		o.datatype = 'uinteger';
		o.placeholder = _('Enter a server ID');
		o.validate = function(section_id, value) {
			return value === '' || /^[1-9][0-9]*$/.test(value) || _('Valid positive server ID');
		}
		o.depends('_server_mode', 'preferred');

		o = s.option(form.Button, '_start', _('Start Test'));
		o.inputtitle = _('Start Test');
		o.inputstyle = 'apply';
		if (result_content.length && result_content[0] == 'Testing' && (Date.now() - result_mtime) < TestTimeout)
			o.readonly = true;
		o.onclick = function(ev, section_id) {
			const mode = this.section.getOption('_server_mode').formvalue(section_id);

			let serverId = '';

			switch (mode) {
			case 'manual':
				serverId = this.section.getOption('_server_id').formvalue(section_id);
				break;
			case 'preferred':
				serverId = this.section.getOption('preferred_server_id').formvalue(section_id);
				break;
			}

			if (mode !== 'auto' && !/^[1-9][0-9]*$/.test(serverId || '')) {
				ui.addNotification(null, E('p', _('Select or enter a valid server ID first.')), 'error');
				return Promise.resolve();
			}

			//L.env.rpctimeout = 180; // 3 minutes
			window.setTimeout(function() {
				window.location = window.location.href.split('#')[0];
			}, L.env.apply_display * 500);

			return callSpeedtest(serverId).then((res) => {
				if (!res.result)
					ui.addNotification(null, E('p', _('Test failed: %s').format(res.error)), 'error');
			});
		};

		o = s.option(form.DummyValue, '_ookla_status', _('Ookla® SpeedTest-CLI Status'));
		o.rawhtml = true;
		o.cfgvalue = function() {
			return E('span', {
				id: 'ookla_status',
				style: `color:${has_ookla ? 'green' : 'red'};font-weight:bold`
			}, [ has_ookla ? _('Installed') : _('Not Installed') ]);
		};
		poll.add(function() {
			return callOoklaVerify().then((res) => {
				const has_ookla = res.result;
				const ookla_stat = document.querySelector('#ookla_status');

				if (ookla_stat) {
					ookla_stat.style.color = has_ookla ? 'green' : 'red';
					dom.content(ookla_stat, [ has_ookla ? _('Installed') : _('Not Installed') ]);
				}
			});
		})

		o = s.option(form.Flag, 'proxy_enabled', _('Enable proxy for downloader and test'));
		o.rmempty = false;

		o = s.option(form.ListValue, 'proxy_protocol', _('Proxy Protocol'));
		o.value('http', 'HTTP');
		o.value('https', 'HTTPS');
		o.value('socks5', 'SOCKS5');
		o.value('socks5h', 'SOCKS5H');
		o.default = 'socks5';
		o.rmempty = false;
		o.retain = true;
		o.depends('proxy_enabled', '1');

		o = s.option(form.Value, 'proxy_server', _('Proxy Server'));
		o.placeholder = '[username[:password]@]address:port';
		o.rmempty = false;
		o.retain = true;
		o.depends('proxy_enabled', '1');

		o = s.option(form.ListValue, '_arch', _('System Arch'));
		o.value('i386');
		o.value('x86_64');
		o.value('armel');
		o.value('armhf');
		o.value('aarch64');
		o.default = 'x86_64';
		o.write = function() {};

		o = s.option(form.Button, '_download', _('Download Ookla® SpeedTest-CLI'));
		o.inputtitle = _('Download');
		o.inputstyle = 'apply';
		o.onclick = function(ev, section_id) {
			const arch=this.section.getOption('_arch').formvalue(section_id);
			//console.log(arch);
			return callDownloadOokla(arch).then((res) => {
					if (res.result === true)
						ui.addNotification(null, E('p', _('Successfully download.')));
					else
						ui.addNotification(null, E('p', _('Download failed: %s').format(res.error)), 'error');
				});
		}

		return m.render();
	}
});
