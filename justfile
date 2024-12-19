pkg := "keyd_2.5.0_amd64"

build:
  make clean
  CC="zig cc -target x86_64-linux-musl" make
  rm -rf {{pkg}}
  mkdir -p {{pkg}}/usr/lib/systemd/
  DESTDIR={{pkg}} make install
  cp dpkg/config {{pkg}}/etc/keyd/default.conf
  mkdir {{pkg}}/DEBIAN
  cp dpkg/control {{pkg}}/DEBIAN/
  dpkg-deb --build --root-owner-group {{pkg}}
  @echo "Built {{pkg}}.deb"

clean:
  make clean
  rm -rf {{pkg}}/
  rm -f {{pkg}}.deb
