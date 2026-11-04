#!/bin/sh
# Copyright 2025-2026 Rafał Wabik (IceG) - From eko.one.pl forum
# Licensed MIT

chmod +x /usr/libexec/rpcd/minidiskmanager >/dev/null 2>&1 &

rm -rf /tmp/luci-indexcache >/dev/null 2>&1 &
rm -rf /tmp/luci-* >/dev/null 2>&1 &
rm -rf /tmp/luci-modulecache/ >/dev/null 2>&1 &

exit 0
