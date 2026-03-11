# 步骤1：停止OpenClaw守护进程和Gateway服务
try { openclaw daemon stop } catch {}
try { openclaw gateway stop } catch {}

# 步骤2：卸载npm全局安装的OpenClaw
npm uninstall -g openclaw

# 步骤3：卸载pnpm全局安装的OpenClaw（如有）
pnpm remove -g openclaw 2>$null

# 步骤4：彻底删除配置目录和git安装残留
Remove-Item -Recurse -Force "$env:USERPROFILE\.openclaw" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\openclaw" -ErrorAction SilentlyContinue
Remove-Item -Force "$env:USERPROFILE\.local\bin\openclaw.cmd" -ErrorAction SilentlyContinue

# 步骤5：清理pnpm残留目录
if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    $pnpmRoot = pnpm root -g
    Remove-Item -Recurse -Force "$pnpmRoot\openclaw" -ErrorAction SilentlyContinue
    Remove-Item -Force "$(Split-Path $pnpmRoot)\bin\openclaw" -ErrorAction SilentlyContinue
}

# 步骤6：验证卸载结果
Write-Host "=== 卸载验证 ===" -ForegroundColor Cyan
if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    Write-Host "⚠️  卸载失败，仍检测到OpenClaw命令" -ForegroundColor Red
} else {
    Write-Host "✅  卸载成功，未检测到OpenClaw相关命令" -ForegroundColor Green
}
