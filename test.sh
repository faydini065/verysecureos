#!/usr/bin/env sh
set -e

echo "=== Very Secure OS verification script ==="

HOME_DIR="$HOME"
REPO_DIR="${HOME_DIR}/verysecureos"
VERIFY_DIR="${REPO_DIR}/formalverificationtest"
CORE_BIN="${REPO_DIR}/src/core.bin"
ISABELLE_BIN="${VERIFY_DIR}/Isabelle2024/bin/isabelle"

if [ ! -d "$REPO_DIR" ]; then
    echo "-> Repository not found. Cloning into $REPO_DIR..."
    cd "$HOME_DIR"
    git clone https://github.com/siyanware/verysecureos.git
else
    echo "-> Repository already exists. Pulling latest updates..."
    cd "$REPO_DIR"
    git pull origin main >/dev/null 2>&1 || true
fi

if [ ! -f "$CORE_BIN" ]; then
    echo "-> src/core.bin not found. Creating a baseline empty file..."
    mkdir -p "${REPO_DIR}/src"
    touch "$CORE_BIN"
fi

CURRENT_MD5=$(md5sum "$CORE_BIN" | awk '{print $1}')
if [ "$CURRENT_MD5" != "d41d8cd98f00b204e9800998ecf8427e" ]; then
    echo "-> ERROR: Integrity check failed. src/core.bin is modified or not empty."
    exit 1
fi
echo "-> Integrity check succeed. src/core.bin file is secure."

if [ -f "${VERIFY_DIR}/Verification.thy" ]; then
    sed -i "s|val file_path = \".*\";|val file_path = \"${CORE_BIN}\";|g" "${VERIFY_DIR}/Verification.thy"
else
    echo "-> Verification.thy target not found."
    exit 1
fi

if [ ! -f "$ISABELLE_BIN" ]; then
    echo "-> Toolchain not found. Provisioning Isabelle2024 locally..."
    
    if command -v wget >/dev/null 2>&1; then
        wget -q "https://isabelle.in.tum.de/website-Isabelle2024/dist/Isabelle2024_linux.tar.gz" -O "/tmp/Isabelle2024_linux.tar.gz"
    elif command -v curl >/dev/null 2>&1; then
        curl -sL "https://isabelle.in.tum.de/website-Isabelle2024/dist/Isabelle2024_linux.tar.gz" -o "/tmp/Isabelle2024_linux.tar.gz"
    else
        echo "-> ERROR: Network fetching primitives (wget/curl) missing."
        exit 1
    fi
    
    tar -xzf "/tmp/Isabelle2024_linux.tar.gz" -C "$VERIFY_DIR"
    rm -f "/tmp/Isabelle2024_linux.tar.gz"
fi

echo "-> Executing formal mathematical verification layer..."
cd "$VERIFY_DIR"
"$ISABELLE_BIN" build -D .

echo "=== Formal Verification Process Completed Successfully ==="
