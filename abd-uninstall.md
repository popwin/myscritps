### 下载适用于 Windows 的 SDK Platform-Tools
里面有adb.exe 工具
### 手机打开usb调试
### 命令行 add devices 
查看手机是否连接，出现list of devices attached 表明连接
### adb shell pm list packages >> list-huawei.txt
查看所有软件包
### adb shell pm uninstall --user 0 +软件包名
卸载系统自带软件
### adb shell am monitor 
监测正在启动的app