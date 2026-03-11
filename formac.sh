#!/bin/bash
# 步骤1：停止OpenClaw守护进程和Gateway服务
openclaw daemon stop 2>/dev/null
openclaw gateway stop 2>/dev/null

# 步骤2：卸载npm全局安装的OpenClaw
npm uninstall -g openclaw 2>/dev/null

# 步骤3：卸载pnpm全局安装的OpenClaw（如有）
pnpm remove -g openclaw 2>/dev/null

# 步骤4：删除git安装的包装脚本和源码目录
rm -f ~/.local/bin/openclaw 2>/dev/null
rm -rf ~/openclaw 2>/dev/null

# 步骤5：清理npm/pnpm残留目录和软链接
rm -rf "$(npm root -g)/openclaw" 2>/dev/null
rm -f /opt/homebrew/bin/openclaw /usr/local/bin/openclaw 2>/dev/null
rm -rf "$(pnpm root -g)/openclaw" 2>/dev/null
rm -f "$(dirname $(pnpm root -g))/bin/openclaw" 2>/dev/null

# 步骤6：彻底删除配置目录（含旧版本遗留）
rm -rf ~/.openclaw 2>/dev/null
rm -rf ~/.clawdbot ~/.moltbot ~/.moldbot 2>/dev/null

# 步骤7：验证卸载结果
echo "=== 卸载验证 ==="
if which openclaw 2>/dev/null; then
    echo "⚠️  卸载失败，仍检测到OpenClaw命令"
else
    echo "✅  卸载成功，未检测到OpenClaw相关命令"
fi
