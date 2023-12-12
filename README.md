# BI_suppermarket_sales
## Install
Pull image
```
docker pull mcr.microsoft.com/mssql/server
```
Run mssql instance
```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=@Passw0rd" -e "TZ=Asia/Ho_Chi_Minh" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest
```
Open tool, connect to local MSSQL local and run `script.sql`
### Using SQL Server Management Studio
Click and change local connection
![image](https://github.com/ducanng/BI_suppermarket_sales/assets/74152283/f441cb8b-1995-4261-bfd8-6227eeee9118)
