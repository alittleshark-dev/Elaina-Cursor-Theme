#!/bin/bash

# 检查是否安装了 ani2xcursor
if ! command -v ani2xcursor &> /dev/null; then
    echo "错误: 未找到 ani2xcursor 工具。"
    echo "请先安装 (例如使用 AUR 助手: paru -S ani2xcursor-bin)"
    exit 1
fi

# 进入 windows 目录
cd windows || { echo "错误: 未找到 windows 文件夹，请确保在仓库根目录运行此脚本。"; exit 1; }

# 自动生成完美的 manifest.toml 配置
echo "正在生成 manifest 配置文件..."
echo "目标路径 => windows/ani2xcursor/manifest.toml"
mkdir -p ani2xcursor
cat << 'EOF' > ani2xcursor/manifest.toml
[input]
theme = "Elaina Cursor Theme"

[files]
pointer     = "正常选择.ani"
help        = "帮助选择.ani"
working     = "后台运行.ani"
busy        = "忙.ani"
precision   = "精确选择.cur"
text        = "文本选择.ani"
hand        = "手写.cur"
unavailable = "不可用.cur"
vert        = "垂直调整大小.cur"
horz        = "水平调整大小.cur"
dgn1        = "沿对角线调整大小1.cur"
dgn2        = "沿对角线调整大小2.cur"
move        = "移动.cur"
alternate   = "候选.ani"
link        = "链接选择.ani"
EOF

echo "正在转换并安装 Elaina 光标..."
# 在当前 windows 目录下执行转换
ani2xcursor . --install

# 检查上一条命令是否执行成功
if [ $? -eq 0 ]; then
    echo "安装完成！请在系统设置中将光标主题改为 'Elaina'"
else
    echo "转换失败，请检查上方报错信息。"
fi
