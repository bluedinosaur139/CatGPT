pkgname=catgpt
pkgver=1.0.0
pkgrel=1
arch=('x86_64' 'aarch64')
url="https://github.com/bluedinosaur139/catgpt"
license=('ISC')
depends=('electron' 'npm')
source=("$pkgname-$pkgver.tar.gz::https://github.com/bluedinosaur139/catgpt/archive/$pkgver.tar.gz")
sha256sums=('SKIP')  # Replace with actual checksum

build() {
    cd "$srcdir/$pkgname-$pkgver"
    npm install  # Installs dependencies from package.json
    npm run build  # Runs the build script in package.json
}

package() {
    cd "$srcdir/$pkgname-$pkgver"
    install -Dm755 "path-to-your-output" "$pkgdir/usr/bin/catgpt"  # Change "path-to-your-output" to your actual build output directory
}
