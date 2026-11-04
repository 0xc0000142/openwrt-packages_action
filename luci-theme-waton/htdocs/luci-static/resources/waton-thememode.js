var themeModeSwitcher = document.querySelector("#topbar > #topbar-right #themeModeSwitcher"),
dynamicStyle = document.querySelector("#dynamicstylesheet");

function initThemeModeSwitch() {
	if ((typeof(Storage) !== "undefined")) {
		themeModeSwitcher.addEventListener('click',changeThemeMode);
		if (localStorage.currentTheme) {
			if ((localStorage.getItem("currentTheme") === "light")) {
				changeNight();
			} else {
				changeDay();
			}
		} else {
			localStorage.currentTheme = "light";
			changeNight();
		}
	} else {
		themeModeSwitcher.classList.add("hidden");
	}
}
function changeThemeMode() {
	if ((localStorage.getItem("currentTheme") === "light")) {
		localStorage.setItem("currentTheme","dark");
		changeNight();
	} else {
		localStorage.setItem("currentTheme","light");
		changeDay();
	}
}
function changeNight() {
	themeModeSwitcher.classList.remove('themeModeSwitchNight');
	themeModeSwitcher.classList.add('themeModeSwitchDay');
	dynamicStyle.href = "/luci-static/waton/stylesheets/night.css";
}
function changeDay() {
	themeModeSwitcher.classList.remove('themeModeSwitchDay');
	themeModeSwitcher.classList.add('themeModeSwitchNight');
	dynamicStyle.href = "/luci-static/waton/stylesheets/day.css";
}
function stylizeLoginPage() {
	let UsrNameInput = document.querySelector('[data-page=""] input[name="luci_username"]');
	let PassInput=document.querySelector('[data-page=""] input[type="password"]');
	if (UsrNameInput != null) {
		UsrNameInput.placeholder="USERNAME";
	}
	if (PassInput != null) {
		PassInput.placeholder="PASSWORD";
	}
}
document.addEventListener('DOMContentLoaded', function() {
	stylizeLoginPage();
	initThemeModeSwitch();
})