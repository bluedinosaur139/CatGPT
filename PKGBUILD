pkgname=catgpt
pkgver=$(curl -s https://api.github.com/repos/bluedinosaur139/catgpt/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
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

    # Assuming Electron Packager output directory is something like:
    # ./dist/CatGPT-linux-x64/ for x64 architecture
    # ./dist/CatGPT-linux-arm64/ for ARM architecture

    if [ "$CARCH" == "x86_64" ]; then
        install -Dm755 "dist/CatGPT-linux-x64/CatGPT" "$pkgdir/usr/bin/catgpt"
    elif [ "$CARCH" == "aarch64" ]; then
        install -Dm755 "dist/CatGPT-linux-arm64/CatGPT" "$pkgdir/usr/bin/catgpt"
    else
        echo "Unsupported architecture: $CARCH"
        exit 1
    fi
}
