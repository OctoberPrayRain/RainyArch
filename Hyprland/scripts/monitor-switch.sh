#!/bin/bash
# ~/.config/hypr/scripts/monitor-switch.sh

# 1. 尝试从系统环境变量或进程中重新获取实例签名
# 在 uwsm 环境下，如果变量没传进来，hyprctl 有时会失效
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    # 尝试从运行中的进程重新找回签名（保底方案）
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls /tmp/hypr | head -n 1)
fi

# 2. 等待 hyprctl 准备就绪
# 相比 sleep 5，这种循环检查更科学
MAX_ATTEMPTS=30
for ((i=1; i<=MAX_ATTEMPTS; i++)); do
    if hyprctl instances &>/dev/null; then
        break
    fi
    sleep 0.5
done

# 3. 检查脚本是否真的能与 Hyprland 通信
if ! hyprctl instances &>/dev/null; then
    echo "错误: 无法连接到 Hyprland 实例" >&2
    exit 1
fi

# 4. 检测 HDMI 显示器是否存在（包括未启用的）
# 使用 monitors all 可以查看到已连接但尚未禁用的显示器
if hyprctl monitors all | grep -q "HDMI-A-1"; then
    echo "检测到 HDMI-A-1，正在禁用内置显示器 eDP-1..."
    # 禁用内置显示器，强制系统只在原生（单显）模式下运行，避开截图崩溃 Bug
    hyprctl keyword monitor "eDP-1,disable"
    # 同时确保 HDMI-A-1 是开启状态
    hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
else
    echo "未检测到 HDMI-A-1，恢复内置显示器 eDP-1..."
    hyprctl keyword monitor "eDP-1,2560x1440@60,0x0,1.6"
fi