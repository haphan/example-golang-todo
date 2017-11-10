## awesome-app


Default env params

```
dbhost := getEnv("DB_HOST", "127.0.0.1")
dbuser := getEnv("DB_USER", "root")
dbpassword := getEnv("DB_PASSWORD", "password")
dbport := getEnv("DB_PORT", "3306")
dbname := getEnv("DB_NAME", "todo_app")

```

db structure

```sql
CREATE TABLE `Todo` (
  `Id`          int(11) NOT NULL AUTO_INCREMENT,
  `Title`       varchar(255) DEFAULT NULL,
  `Category`    varchar(255) DEFAULT NULL,
  `State`       varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
```
