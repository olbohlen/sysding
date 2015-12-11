ipspkg:
	rm -rf proto_install
	mkdir -p proto_install/usr/share/man/man1m
	mkdir -p proto_install/lib/svc/manifest/system
	mkdir -p proto_install/lib/svc/method
	mkdir -p proto_install/etc
	ln sysding.1m proto_install/usr/share/man/man1m/sysding.1m
	ln sysding.conf proto_install/etc/sysding.conf
	ln sysding.xml proto_install/lib/svc/manifest/system/sysding.xml
	ln sysding proto_install/lib/svc/method/sysding
	pkgsend generate proto_install | pkgfmt >sysding.p5m.1
	pkgmogrify sysding.p5m.1 sysding.mog | pkgfmt >sysding.p5m.2
	pkgdepend generate -md proto_install sysding.p5m.2 | pkgfmt >sysding.p5m.3
	pkgdepend resolve -m sysding.p5m.3
	rm -rf ips_repo
	mkdir -p ips_repo
	pkgrepo create ips_repo
	pkgrepo set -s ips_repo publisher/prefix=openindiana.org
	pkgsend publish -s $(PWD)/ips_repo -d proto_install sysding.p5m.3.res
