# 安裝流程 (AP1+AP2) 測試主機

## 環境設定參考 CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v2.2.0.pdf

## 系統資訊
### 主機規格：
- Server:	VMware ESXi 5.5
- HDD	100GB

### 系統版本：
> OS :	Red Hat Enterprise Linux 7.2 64-bit

### 系統設定：
>  主機名稱	DCC-TEST-177
 	
## 工作記錄：

|安裝人員|作業日期|備註|
| :-| -:| :--: |
|Frank|2020/05/21|在VM上裝RHEL7|

## 安裝流程
### 安裝說明

|安裝人員|作業日期|備註|
| :-------- | --------:| :--: |
|Frank|2020/05/21|在VM上裝RHEL7|	
### 安裝系統/基本套件/開發套件
1. 準備Red Hat Enterprise Linux 7.2 64-bit DVD光碟，並使用DVD光碟開機
2. 進安裝畫面下按下TAB後，在 boot: 提示下使用 sshd=1 選項：

**linux sshd=1** 

3. Red Hat DVD開機時，選擇[English] / [English(United States)]，按下[Contiune]

4. INSTALLATION SUMMARY畫面，個別設定項目如下：

|類別	| - |	設定內容|
|:-|:-:|:-|
LOCALIZATION|DATE & TIME|	Asia/Taipei|	
-|LANGUAGE SUPPORT|English|	
-|KEYBOARD|English|
SECURITY|SECURITY POLICY|(預設值)No profile selected|
-|SOFTWARE	INSTALLATION SOURCE	|(預設值)Local media	|
-|SOFTWARE SELECTION|	(預設值)Minimal install|
|SYSTEM	|INSTALLATION DESTINATION	|依照硬碟分割設定|	
-|NETWORK & HOST NAME|	依照網路設定	|
-|KDUMP	|(預設值)Kdump is enabled|

5. 硬碟分割設定

LV |Name	Size	|Mount Point|
|:-|:-:|:-|
lv_root	|ALL|	/|
lv_tmp	|5120 (5GB)	|/tmp|
lv_swap	|5120 (5GB)	|/swap|

6. 網路設定		
設備|IP|備註|
|:-|:-:|:-|
eth0	|IP: 192.168.13.177/24		GW: 192.168.13.254|-
eth1	|N/A|-
eth2	|N/A|-	
eth3	|N/A|-	
iLo	|192.168.5.10/24|	無使用	GW: N/A|

7. 按下[Begin]開始安裝系統，並且在此畫面設定系統管理者(root)的密碼

**按公司設定值**

7. 安裝完成後，按下[Reboot]將系統重新開機
8. 初次登入系統，使用"root"帳號登入
9. 設定DVD安裝ISO檔案為yum Server，藉由rhel7dvd.repo與Yum_Base_from_DVD.sh來安裝基本套件與開發套件

### 系統設定



### 安裝資料庫套件
1. 安裝MariaDB (使用RHEL 7.2 DVD MariaDB 5.5)
```
yum install -y mariadb-server mariadb-devel mariadb-libs
```
2. 啟動MariaDB
```
systemctl enable mariadb
systemctl start mariadb
```
3. 執行安全性安裝MariaDB
```
mysql_secure_installation
```
一開始輸入的root密碼依照預設值為空白，所以這邊直接按下Enter，之後再修改密碼為80268351，接者依照詢問內容如下
	Set root password? [Y/n] n
	Remove anonymous users? [Y/n] Y
	Disallow root login remotely? [Y/n] Y
	Remove test database and access to it? [Y/n] Y
	Reload privilege tables now? [Y/n] Y
4. 設定資料庫
建立管理者(root)密碼 
```
 mysqladmin -u root password 80268351

```
§ 關閉mysql history
- 各別登入系統帳號設定
  -  登入其他系統使用者帳號(airlink)，執行下列指令

```
rm ~/.mysql_history
ln -s /dev/null ~/.mysql_history
```

§ [RH 7新增]調整MySQL服務參數
- 修改server.cnf參數檔案
```
vi /etc/my.cnf.d/server.cnf
```

> 在參數檔最後的 [mariadb-5.5] 標簽底下，增加下列參數

|增加參數|參數說明|驗證方式|預期結果|
|:-|:-|:--|:--:|
bind-address=0.0.0.0|	設定MariaDB只會Listing IPv4，若是沒有設定則會優先Listing IPv6|netstat -anopt	Proto應該顯示tcp，代表為IPv4|查看Proto欄位是tcp或是tcp6|
local-infile=0|關閉local_file|SHOW VARIABLES WHERE Variable_name = 'local_infile';|	Valus=OFF|
|max_connections=500|增加最大連線數量	|show variables like 'max_connections';	|Valus=500 |      
innodb_file_per_table=ON	|將InnoDB格式的資料，各別存放在自己的Tables|	show variables like 'innodb_file_per_table';|	Valus=ON|
skip-name-resolve=ON|	關閉DNS反查功能	|show variables like 'skip_name_resolve%';|	skip_name_resolve=ON|
slow_query_log		slow_query_log_file = /var/log/mariadb/slow.log			long_query_time = 5|-| show variables like 'slow%';	|-|