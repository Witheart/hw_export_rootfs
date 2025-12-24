#!/bin/bash

fuse_path="/tmp/fuse"

# 直接尝试访问文件（不依赖 -e 检测）
if ls -ld "$fuse_path" &> /dev/null; then
    : # 文件可访问，什么都不做
else
    # 检查错误类型是否权限问题
    err_msg=$(ls -ld "$fuse_path" 2>&1)
    if [[ "$err_msg" =~ "权限不够" || "$err_msg" =~ "Permission denied" ]]; then
        echo -e "\033[31m错误：检测到无法访问的文件 ${fuse_path}\033[0m"
        echo -e "\033[33m⚠️  该文件通常由远程控制软件（如todesk、向日葵）创建且在运行时无法操作\033[0m"
        echo -e "请执行以下操作："
        echo -e "  1. 退出所有远程控制软件"
        echo -e "  2. 手动删除该文件：sudo rm -rf ${fuse_path}"
        echo -e "  3. 或者重启系统后再次运行此脚本"
        echo -e "处理完成后请重新运行打包脚本！"
        exit 1
    fi
fi
