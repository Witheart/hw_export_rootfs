# hw_export_rootfs 根文件系统打包工具使用指南
- 作者：吴思含（Witheart）
- 更新时间：20250708

---

## 所需工具
- ext4格式U盘或SD卡（容量大于8GB）
- hw_export_rootfs工具
- ftp工具（如mobaxterm） / 另一个exfat格式的U盘

## 主要操作
- 重启要打包根文件系统的主板
- 开机状态下，主板接入ext4 U盘或SD卡
- 终端输入lsblk查看挂载位置
- 将hw_export_rootfs工具复制到ext4格式U盘或SD卡中
- 进入挂载位置，执行
```bash
sudo ./hw_export_rootfs ./
```
- 输入commit信息（用于标识该版本更新的内容），比如“新安装了xx软件，更新了开机脚本”
- 提示是否清理snap缓存，输入y进行清理
- 等待打包完成（会提示Success），会在当前目录下生成一个.img文件，此即为打包出的根文件系统

## ext4U盘或SD卡怎么制作
[https://blog.csdn.net/Beihai_Van/article/details/144788991](https://blog.csdn.net/Beihai_Van/article/details/144788991)

## 如何将img文件导出
由于ext4格式的U盘或SD卡Windows系统无法识别，故需要通过下面的方式导出：
- 方式一：接入另一个exfat格式的U盘，将打包出的根文件系统复制到该U盘中，便可通过该U盘复制到Windows主机中
- 方式二：使用ftp工具（如mobaxterm）将打包出的根文件系统直接传输到Windows主机中