## 简介

本脚本用于将 Ubuntu 系统的根文件系统导出为镜像文件。支持 `ext4` 和 `btrfs` 文件系统类型，并提供了系统清理、缓存清理等功能，以确保导出的镜像文件尽可能精简。

注意：only4local 分支清理的是执行脚本的宿主系统的snap数据，而不是要打包目录的snap数据。

## 使用说明

### 基本用法

```bash
hw_export_rootfs </path/to/store> [-s <source_path>] [-t <ext4|btrfs>] [-h]
```

### 参数说明

- `</path/to/store>`：指定镜像文件的存储路径。
- `-s <source_path>`：指定要打包的源目录（默认为 `/`）。
- `-t <ext4|btrfs>`：指定镜像文件的文件系统类型（默认使用源文件系统类型）。
- `-h`：显示脚本的使用说明。

### 示例

1. 将根文件系统导出到 `/mnt/backup` 目录，使用默认的源文件系统类型：

   ```bash
   hw_export_rootfs /mnt/backup
   ```

2. 将 `/mnt/custom_rootfs` 目录导出为 `btrfs` 文件系统镜像，并存储到 `/mnt/backup`：

   ```bash
   hw_export_rootfs /mnt/backup -s /mnt/custom_rootfs -t btrfs
   ```

## 脚本功能

1. **系统准备和清理**：（branch：only4local）
   - 启用 `resize-helper.service`。
   - 清理 APT 缓存。
   - 清理 Snap 缓存。
   - 清理旧版本的 Snap 包。

2. **目标文件系统清理**：
   - 删除不必要的文档和日志文件。
   - 清理 `/tmp` 目录。
   - 处理 `/media` 目录中的用户文件权限。
   - 处理 Docker 目录的符号链接问题。

3. **镜像文件创建**：
   - 根据源文件系统类型创建镜像文件。
   - 使用 `rsync` 将源目录同步到镜像文件中。
   - 对 `ext4` 文件系统进行优化和压缩。

4. **错误处理**：
   - 提供错误捕获和清理机制，确保在脚本执行失败时正确卸载和清理临时挂载点。

## 注意事项

- 本脚本需要以 `root` 用户权限运行。
- 确保目标存储路径有足够的可用空间。
- 如果源目录是 `/`，脚本会自动检测根文件系统的类型并应用于镜像文件。

## 依赖

- `rsync`：用于文件同步。
- `btrfs` 或 `ext4` 工具：用于创建和优化文件系统。

## 版本信息

- 作者：Witheart
- 原脚本来源：Firefly
