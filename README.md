# OpenClaw Uninstall

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

轻量、便捷的 OpenClaw 卸载工具，支持清理 OpenClaw 相关的程序文件、配置缓存、注册表项（Windows）/系统配置（Linux/macOS），确保彻底卸载无残留。

## 🌟 特性
- 跨平台支持：Windows、Linux、macOS
- 一键全自动卸载，无需手动清理文件/注册表
- 可选择性清理：支持保留配置文件或完全清除所有数据
- 卸载日志生成：记录卸载过程，便于排查问题
- 安全校验：卸载前自动检测 OpenClaw 运行状态，避免进程占用导致卸载失败

## 📋 环境要求
| 系统        | 最低版本/依赖                     |
|-------------|-----------------------------------|
| Windows     | Windows 7+ (64位)，PowerShell 5.1+ |
| Linux       | Ubuntu 16.04+/CentOS 7+，bash 4.0+ |
| macOS       | macOS 10.14+，zsh/bash            |

## 🚀 快速开始

### 1. 克隆仓库
```bash
git clone https://github.com/WHDevLab/openclaw_uninstall.git
cd openclaw_uninstall
```

### 2. 权限准备
- **Windows**：以「管理员身份」打开 PowerShell/CMD
- **Linux/macOS**：赋予脚本执行权限
  ```bash
  chmod +x openclaw_uninstall.sh
  ```

### 3. 运行卸载工具
#### Windows（PowerShell）
```powershell
.\forwindow.bat
```
#### Linux/macOS（终端）
```bash
./formac.sh
```

### 4. 交互选项说明
运行脚本后，会出现以下交互选项，按需选择即可：
```
========================================
OpenClaw 卸载工具 v1.0
========================================
1. 完全卸载（删除所有文件/配置/注册表）
2. 保留配置卸载（仅删除程序文件，保留用户配置）
3. 仅清理缓存（不卸载程序，仅删除缓存文件）
4. 查看卸载日志
5. 退出
请输入选项编号（1-5）：
```

## 📂 卸载范围说明
工具会自动清理以下路径的 OpenClaw 相关内容（不同系统路径略有差异）：

| 类型         | Windows 路径                          | Linux 路径                          | macOS 路径                          |
|--------------|---------------------------------------|-------------------------------------|-------------------------------------|
| 程序主目录   | `C:\Program Files\OpenClaw`           | `/usr/local/bin/openclaw`           | `/Applications/OpenClaw.app`        |
| 用户配置     | `%APPDATA%\OpenClaw`                  | `~/.config/openclaw`                | `~/Library/Application Support/OpenClaw` |
| 缓存文件     | `%LOCALAPPDATA%\OpenClaw\Cache`       | `~/.cache/openclaw`                 | `~/Library/Caches/OpenClaw`         |
| 注册表（仅Win） | `HKEY_CURRENT_USER\Software\OpenClaw` | -                                   | -                                   |

## 📌 注意事项
1. 卸载前请关闭所有 OpenClaw 相关进程，否则可能导致部分文件无法删除；
2. 「完全卸载」会删除所有用户配置（如自定义脚本、偏好设置），请提前备份重要数据；
3. Linux/macOS 系统下若提示权限不足，可在命令前加 `sudo`（如 `sudo ./openclaw_uninstall.sh`）；
4. 卸载完成后建议重启终端/系统，确保残留进程完全清理；
5. 若卸载失败，可查看生成的 `uninstall_log_YYYYMMDD.txt` 日志文件定位问题。

## ❓ 常见问题
### Q1: Windows 运行脚本提示「执行策略禁止」？
A1: 以管理员身份打开 PowerShell，执行以下命令解除限制：
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
选择「Y」确认，之后重新运行卸载脚本。

### Q2: Linux 卸载后仍能看到 OpenClaw 命令？
A2: 可能是软链接未清理，执行以下命令手动删除：
```bash
sudo rm -rf /usr/bin/openclaw /usr/local/bin/openclaw
source ~/.bashrc  # 或 source ~/.zshrc
```

### Q3: 卸载日志显示「文件被占用」？
A3: 打开任务管理器（Windows）/ `htop`（Linux/macOS），结束所有含「OpenClaw」的进程，重新运行卸载脚本。

## 📄 许可证
本项目基于 MIT 许可证开源，详见 [LICENSE](LICENSE) 文件。

## 📞 问题反馈
若使用过程中遇到问题，可通过以下方式反馈：
1. 提交 [GitHub Issue](https://github.com/WHDevLab/openclaw_uninstall/issues)
2. 联系开发者：whdevlab@example.com（替换为实际邮箱）

---

## 自定义扩展（可选）
如果仓库包含额外功能（如批量卸载、静默模式），可补充以下内容：

### 静默卸载（无交互）
支持无交互模式卸载（适合自动化脚本集成）：
#### Windows
```powershell
.\openclaw_uninstall.ps1 -Silent -Mode Full  # Full=完全卸载，KeepConfig=保留配置
```
#### Linux/macOS
```bash
./openclaw_uninstall.sh --silent --mode full  # full/keepconfig
```

### 手动卸载指南（备用方案）
若自动脚本失效，可按以下步骤手动卸载：
1. 删除程序主目录（见「卸载范围说明」）；
2. 手动清理配置/缓存路径；
3. Windows 需打开「注册表编辑器」（`regedit`），删除 `HKEY_CURRENT_USER\Software\OpenClaw` 项；
4. 清理系统环境变量中含「OpenClaw」的路径（若有）。
