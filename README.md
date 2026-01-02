# shelby-LiuNeng

一个把 **Shelby CLI 官方教程流程**整理成 **中文菜单 + 一键初始化** 的脚本。

- 自动检测并安装依赖（尽力而为）：curl / git / node / npm / Shelby CLI
- 中文菜单功能：
  1. 创建新钱包
  2. 查看钱包地址
  3. 通过钱包地址进行领水（提示/入口）
  4. 选择需要上传的文件（并上传，可选下载校验）
  5. 导出钱包私钥（危险操作，双重确认）

> ⚠️ 安全提示：脚本会在本机生成并保存私钥到 `~/.shelby/accounts/`，权限为 600。请勿把私钥发给任何人或上传到网盘。

---

## 一行安装并运行（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/a941249849/shelby-LiuNeng/main/shelby-menu.sh \
  -o shelby-menu.sh \
&& chmod +x shelby-menu.sh \
&& ./shelby-menu.sh

