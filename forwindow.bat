@echo off
chcp 65001 >nul
:: 步骤1：停止OpenClaw守护进程和Gateway服务
openclaw daemon stop 2>nul
openclaw gateway stop 2>nul

:: 步骤2：卸载npm全局安装的OpenClaw
npm uninstall -g openclaw

:: 步骤3：卸载pnpm全局安装的OpenClaw（如有）
pnpm remove -g openclaw 2>nul

:: 步骤4：彻底删除配置目录和git安装残留
rmdir /s /q "%USERPROFILE%\.openclaw" 2>nul
rmdir /s /q "%USERPROFILE%\openclaw" 2>nul
del /f "%USERPROFILE%\.local\bin\openclaw.cmd" 2>nul

:: 步骤5：验证卸载结果
echo === 卸载验证 ===
where openclaw 2>nul
if %errorlevel% equ 0 (
    echo ⚠️  卸载失败，仍检测到OpenClaw命令
) else (
    echo ✅  卸载成功，未检测到OpenClaw相关命令
)
pause
