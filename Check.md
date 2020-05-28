## MySQL
### check MySQL服務參數

```
vi /etc/my.cnf.d/server.cnf
```

### 登入MySQL後,檢查資料庫與使用者

```
mysql -urt -p
show databases;
use mysql 
select * from user;
select User,Host FROM mysql.user;
```

## 檢查系統
### 主機名稱

```
cat /etc/hostname
```

### 用戶

```
cat /etc/passwd | grep -e admin -e airlink

```

visudo 
## 校正系統時間

ntpdate 192.168.0.5
## 檢查防火牆
### 防火牆規則
cat /etc/sysconfig/iptables
### 確認防火牆Logs檔案導出規則
cat /etc/rsyslog.d/iptables.conf
## 確認服務
### 確認服務開啟狀態 (約11項)

```
systemctl list-unit-files|grep enable|grep service
```

### 預計開啟的服務與用途

|service |用途|
|:-:|:-|
auditd.service|安全審查|
autovt@.service|登入訊息相關|
crond.service|自動排程|
getty@.service|tty控制|
iptables.service|防火牆|
lvm2-monitor.service |LVM支援
mariad.service|MYSQL|
postfix.service|郵件|
rsyslog.service|系統日誌
sshd.service|SSH連線
xinetd.service| 其他網路服務(由extended internet daemon)



### 確認服務開啟狀態(舊系統)
chkconfig
### 設定DNS
- 外部
vi /etc/resolv.conf
- 內部
vi /etc/hosts


## 確認crontab設定
- crontab白名單

```
cat  /etc/cron.allow
```

- 檢查自動執行script

```
ls  /root/bin/
```

- 檢查這四個script aide.sh  auditd.sh  LogCleaner.sh  ntpdate.sh


aide.sh  
auditd.sh  
LogCleaner.sh  
ntpdate.sh
	


- 確認檔案權限

```
ls -al /etc/|grep cron
ls -al /etc/cron.allow
ls -al /etc/at.allow


```

### crontab自動執行規則 

```
crontab -e 
```


### 確認AIDE資料庫是否正常

```
ls -al /var/lib/aide/aide.db.gz
```

## 確認系統網路使用限制

```
sysctl -p /etc/sysctl.conf
```