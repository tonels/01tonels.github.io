# 一、Hutool 关于数据库的操作示例
## 1.1 连接数据库：加载 config/db.setting
![在这里插入图片sssss](https://img-blog.csdnimg.cn/20190704151313333.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)

```
#===================================================================
# 数据库配置文件样例
# DsFactory默认读取的配置文件是config/db.setting
# db.setting的配置包括两部分：基本连接信息和连接池配置信息。
# 基本连接信息所有连接池都支持，连接池配置信息根据不同的连接池，连接池配置是根据连接池相应的配置项移植而来
#===================================================================

## 打印SQL的配置
# 是否在日志中显示执行的SQL，默认false
showSql = true
# 是否格式化显示的SQL，默认false
formatSql = true
# 是否显示SQL参数，默认false
showParams = true
# 打印SQL的日志等级，默认debug
sqlLevel = debug

[mysql]
url = jdbc:mysql://localhost:3306/proce?useSSL=false # 这里指定数据库
user = root
pass = root
```
## 这里是测试model的建表语句和对应Model类
```
CREATE TABLE `user` (
  `id` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```
```
@Data
public class User {

	private Integer id;

	private String name;

	private int age;

	private String birthday;

	private boolean gender;
}

```


## 1.1 测试 MetaUtil


```
public class MetaUtilTest {
	DataSource ds = DSFactory.get("mysql"); // 加载 Mysql 数据库
	@Test
	public void getTablesTest() {
		List<String> tables = MetaUtil.getTables(ds);
	}
	@Test
	public void getTableMetaTest() {
		Table table = MetaUtil.getTableMeta(ds, "user");
	}
}

```
### 返回数据

```
tables = [Atest, author, book, city, state, user]
```
```
table  = {
"pkNames": [],
"columns": [
	{
		"size": 10,
		"isNullable": true,
		"name": "id",
		"typeName": "INT",
		"comment": "",
		"type": 4,
		"tableName": "user"
	},
	{
		"size": 20,
		"isNullable": true,
		"name": "name",
		"typeName": "VARCHAR",
		"comment": "",
		"type": 12,
		"tableName": "user"
	},
	{
		"size": 10,
		"isNullable": true,
		"name": "birthday",
		"typeName": "DATE",
		"comment": "",
		"type": 91,
		"tableName": "user"
	},
	{
		"size": 2,
		"isNullable": true,
		"name": "gender",
		"typeName": "VARCHAR",
		"comment": "",
		"type": 12,
		"tableName": "user"
	}
		],
"comment": "",
"tableName": "user"
}

```

## 1.2 conditionTest

```
@Test
	public void toStringTest() {
		Condition c1 = new Condition("name", null);
		System.out.println(c1);
		Condition c2 = new Condition("birthday", "!= null");
		System.out.println(c2);
		Condition c3 = new Condition("name", "= zhangsan");
		System.out.println(c3);
		Condition c4 = new Condition("name", "like %aaa");
		System.out.println(c4);
		Condition c5 = new Condition("id", "in 1,2,3");
		System.out.println(c5);
		Condition c6 = new Condition("age", "between 12 and 13");
		System.out.println(c6);
	}
```
### 控制台输出为，默认条件占位符为 True
```
name IS NULL
birthday IS NOT NULL
name = ?
name LIKE ?
id IN (?,?,?)
age BETWEEN ? AND ?

```
### 还有关于条件占位符的开启与关闭，这里指定为关闭

```
@Test
	public void toStringNoPlaceHolderTest() {
		Condition conditionNull = new Condition("user", null);
		conditionNull.setPlaceHolder(false);
		System.out.println(conditionNull);

		Condition conditionNotNull = new Condition("user", "!= null");
		conditionNotNull.setPlaceHolder(false);
		System.out.println(conditionNotNull);

		Condition conditionEquals = new Condition("user", "= zhangsan");
		conditionEquals.setPlaceHolder(false);
		System.out.println(conditionEquals);

		Condition conditionLike = new Condition("user", "like %aaa");
		conditionLike.setPlaceHolder(false);
		System.out.println(conditionLike);

		Condition conditionIn = new Condition("user", "in 1,2,3");
		conditionIn.setPlaceHolder(false);
		System.out.println(conditionIn);

		Condition conditionBetween = new Condition("user", "between 12 and 13");
		conditionBetween.setPlaceHolder(false);
		System.out.println(conditionBetween);
	}
```
### 控制台输出为，和上面的输出比较一下区别
```
user IS NULL
user IS NOT NULL
user = zhangsan
user LIKE %aaa
user IN (1,2,3)
user BETWEEN 12 AND 13
```
## 1.3 SqlBuilder测试

```
@Test
	public void queryNullTest() {
		SqlBuilder builder = SqlBuilder.create().select().from("user").where(new Condition("name", "= null"));
		System.out.println(builder);
		
		SqlBuilder builder2 = SqlBuilder.create().select().from("user").where(new Condition("name", "is null"));
		System.out.println(builder2);

		SqlBuilder builder3 = SqlBuilder.create().select().from("user").where(LogicalOperator.OR, new Condition("name", "!= null"),new Condition("name","like%as"));
		System.out.println(builder3);

		SqlBuilder builder4 = SqlBuilder.create().select().from("user").where(LogicalOperator.AND, new Condition("name", "is not null"),new Condition("id", "in 12,13,14"));
		System.out.println(builder4);
	}
```
### 控制台输出为
```
SELECT * FROM user WHERE name IS NULL
SELECT * FROM user WHERE name IS NULL
SELECT * FROM user WHERE name IS NOT NULL OR name = ?
SELECT * FROM user WHERE name IS NOT NULL AND id IN (?,?,?)
```
# [下一篇，基于Hutool包的的增删改查操作](https://blog.csdn.net/qq_42105629/article/details/94627718)