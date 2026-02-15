# Maintainer: Ildar Akhmetgaleev <akhilmak@gmail.com>
# vim: set sw=2 expandtab:
# Based on Arch's PKGBUILD https://gitlab.archlinux.org/archlinux/packaging/packages/helix/-/blob/main/PKGBUILD?ref_type=heads

pkgname=hx
pkgver=25.07.1
pkgrel=0
pkgdesc='A post-modern modal text editor.'
arch=('amd64')
conflicts=('helix-bin' 'helix')
license=('MPL-2.0')
url='https://helix-editor.com/'
depends=('libgcc-s1' 'libc6')
optdepends=('hicolor-icon-theme')
makedepends=('git' 'rustup')
source=("helix-$pkgver.tar.gz::https://github.com/helix-editor/helix/archive/$pkgver.tar.gz")
b2sums=('aadcec0be8d13e3957ac2e032431bafe7a0b743f48532c9a2d888fae17ec85dcb3b38d24b9905b7a6fa0a1cf73b761992a79987b17a762ad42cf8370109d7a4d')

prepare() {
  cd "helix-$pkgver"
  cargo fetch --locked --target "$(rustc -vV | sed -n 's/host: //p')"
}

build() {
  cd "helix-$pkgver"
  cargo build --frozen --release
}

check() {
  cd "helix-$pkgver"
  cargo test --frozen
}

package() {
  cd "helix-$pkgver"
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
  install -Dm 644 "contrib/Helix.desktop" "$pkgdir/usr/share/applications/Helix.desktop"
  install -Dm 644 "contrib/helix.png" -t "$pkgdir/usr/share/icons/hicolor/256x256/apps/helix.png"
}
