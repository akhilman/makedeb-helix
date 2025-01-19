# Maintainer: Ildar Akhmetgaleev <akhilmak@gmail.com>
# vim: set sw=2 expandtab:
pkgname=helix
pkgver=25.01
pkgrel=2
pkgdesc='A post-modern modal text editor.'
arch=('amd64')
provides=('hx')
conflicts=('helix-bin')
license=('Mozilla Public License Version 2.0')
url='https://helix-editor.com/'
makedepends=('git')
# extensions=('zipman')

source=("$pkgname-$pkgver.tar.gz::https://github.com/helix-editor/helix/archive/$pkgver.tar.gz")
b2sums=('fbac61630c923d8dd99200d4b99ff8adca284c70ba9676fe9306ee3f9ec617ad6895715fc48166685d64c5b1009fc3979f85965fb409be04f87920421b3bc2fc')

prepare() {
  # WARN: Rustup will be installde from official script
  if ! command cargo 2> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -qy
    . ~/.cargo/env
  fi

  cd "$pkgname-$pkgver"
  # NOTE: we are renaming hx to helix so there is no conflict with hex (providing hx)
  sed -i "s|hx|helix|g" contrib/completion/hx.*
  sed -i 's|hx|helix|g' contrib/Helix.desktop
  cargo fetch --locked --target "$(rustc -vV | sed -n 's/host: //p')"
}

build() {
  [ -f ~/.cargo/env ] && . ~/.cargo/env
  cd "$pkgname-$pkgver"
  cargo build --frozen --release
}

check() {
  [ -f ~/.cargo/env ] && . ~/.cargo/env
  cd "$pkgname-$pkgver"
  cargo test --frozen
}

package() {
  cd "$pkgname-$pkgver"
  install -Dm 755 "target/release/hx" "$pkgdir/usr/lib/$pkgname/hx"
  install -vdm 755 "$pkgdir/usr/bin"
  ln -sv /usr/lib/$pkgname/hx "$pkgdir/usr/bin/$pkgname"
  install -Dm 644 README.md -t "$pkgdir/usr/share/doc/$pkgname"

  local runtime_dir="$pkgdir/usr/lib/$pkgname/runtime"
  mkdir -p "$runtime_dir/grammars"
  cp -r "runtime/queries" "$runtime_dir"
  cp -r "runtime/themes" "$runtime_dir"
  find "runtime/grammars" -type f -name '*.so' -exec \
  install -Dm 755 {} -t "$runtime_dir/grammars" \;
  install -Dm 644 runtime/tutor -t "$runtime_dir"

  install -Dm 644 "contrib/completion/hx.bash" "$pkgdir/usr/share/bash-completion/completions/$pkgname"
  install -Dm 644 "contrib/completion/hx.fish" "$pkgdir/usr/share/fish/vendor_completions.d/$pkgname.fish"
  install -Dm 644 "contrib/completion/hx.zsh" "$pkgdir/usr/share/zsh/site-functions/_$pkgname"
  install -Dm 644 "contrib/Helix.desktop" "$pkgdir/usr/share/applications/$pkgname.desktop"
  install -Dm 644 "contrib/$pkgname.png" -t "$pkgdir/usr/share/icons/hicolor/256x256/apps"

}
