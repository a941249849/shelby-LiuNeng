#!/usr/bin/env bash
set -euo pipefail

REPO_OWNER="a941249849"
REPO_NAME="shelby-LiuNeng"
BRANCH="main"
SCRIPT_NAME="shelby-menu.sh"
RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${BRANCH}"

# 目标：把脚本下载到当前目录（更符合用户预期）
DEST="./${SCRIPT_NAME}"

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "❌ 缺少依赖命令：$1"
    exit 1
  }
}

# 基础依赖：curl 或 wget
download() {
  local url="$1"
  local out="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$out" "$url"
  else
    echo "❌ 未检测到 curl 或 wget，请先安装其中一个。"
    exit 1
  fi
}

echo "==> Shelby-LiuNeng 安装器"
echo "==> 将从仓库下载并运行：${SCRIPT_NAME}"
echo

URL="${RAW_BASE}/${SCRIPT_NAME}"

# 如果当前目录已存在同名文件，提示是否覆盖
if [[ -f "$DEST" ]]; then
  echo "⚠️ 当前目录已存在 ${DEST}"
  read -r -p "是否覆盖？(y/N): " yn
  yn="${yn:-N}"
  if [[ ! "$yn" =~ ^[Yy]$ ]]; then
    echo "已取消。你可以手动运行：./${SCRIPT_NAME}"
    exit 0
  fi
fi

TMP="$(mktemp -d)"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

echo "==> 下载：$URL"
download "$URL" "$TMP/$SCRIPT_NAME"

# 简单校验：确保下载内容看起来像 shell 脚本
if ! head -n 1 "$TMP/$SCRIPT_NAME" | grep -qE '^#!'; then
  echo "❌ 下载内容异常（没有 shebang）。可能是 URL/分支/文件名错误。"
  echo "   请检查：$URL"
  exit 1
fi

# 安装到当前目录
mv "$TMP/$SCRIPT_NAME" "$DEST"
chmod +x "$DEST"

echo "✅ 安装完成：$DEST"
echo "==> 现在开始运行菜单脚本..."
echo

exec "$DEST"
