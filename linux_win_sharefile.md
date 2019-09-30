
### linux与windows之间的文件共享方法

1. 查看各自ip linux`ifconfig` win`ipconfig`

2. 设置winsows的host 

   在`C:\\Windows\System32\drivers\etc\hosts`中添加`linux_IP ubuntu1610.localhost ubuntu1016`
   这里的`ubuntu1610`是后面在samba里的netbios name里设置的，可以任意

   打开cmd 运行一下命令，打开防火墙和网络发现

```
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
```

3. linux 安装配置 smmba

`sudo apt-get install samba samba-common python-glade2 system-config-samba`

`sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak` #备份

**写入以下配置**
```
#============================ Global definition ================================
 
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = ubuntu1604 
security = user
map to guest = bad user
name resolve order = bcast host
dns proxy = no
bind interfaces only = yes

#============================ Share Definitions ============================== 

[Public]
   path = /samba/public
   writable = yes
   guest ok = yes
   guest only = yes
   read only = no
   create mode = 0777
   directory mode = 0777
   force user = nobody

```

这里的`path = /samba/public`可以任意

**创建路径**
`sudo mkdir -p /samba/public`

**设置权限**

```
sudo chown -R nobody:nogroup /samba/public
sudo chmod -R 0775 /samba/public
```
**重启samba**

`sudo service smbd restart`

**关闭linux 防火墙**
`ufw disable` 