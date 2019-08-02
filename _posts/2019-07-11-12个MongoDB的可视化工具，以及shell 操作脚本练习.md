
### 一、准备好，本地安装MongoDB或者远程可连接的MongoDB服务器
##### 客户端，可以是[命令行工具，点击可下载](https://downloads.mongodb.org/win32/mongodb-shell-win32-x86_64-2008plus-ssl-4.0.10.zip)，记得配置环境变量。
##### 也可以是可视化工具，比较多哈
### 1.[Robomongo](https://robomongo.org/)，
### 2. [MongoBooster](http://mongobooster.com/downloads%20)，
### 3. [NoSQLBooster](https://nosqlbooster.com/downloads)
### 4.[Studio 3T](https://studio3t.com/?utm_source=Guru99&utm_medium=listing&utm_campaign=leadgen)
### 5.[MongoDB Compass](https://www.mongodb.com/products/compass)
### 6.[Nucleon Database Master](http://nucleonsoftware.com/downloads)
### 7.[NoSQL Manager](https://www.mongodbmanager.com/download)
### 8. [Mongo Management Studio](http://mms.litixsoft.de)
### 9. [MongoJS Query Analyzer](http://www.aquafold.com/aquadatastudio.html)
### 10.[Nosqlclient](https://www.nosqlclient.com/)
### 11.[Cluster control](https://severalnines.com/product/clustercontrol/for_mongodb)
### 12. navicate 这里就不贴链接了，需要破解，我用的就是这个，支持Mysql，Oracle，MongoDB等多个数据库连接。

### 二、连接使用
MongoDb 和 SQL的对应关系图
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019071116083044.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)

#### 2.1 基础命令
show dbs ;
show databases;
```
admin                      0.000GB
test                       0.001GB
testData                   0.000GB
tonels_test                0.000GB
```
use testData ;   // 切换当前库


show collections; // 显示所有的collections
```
inventory
test2
testData
characters
```
show users; // 打印当前数据库的用户列表。
show roles  ;  // 打印角色

#### 2.2 CRUD操作
##### 2.2.1 添加操作
插入一条数据
```
db.inventory.insertOne(
    {
        item: "canvas",
        qty: 100,
        tags: ["cotton"],
        size: {
            h: 28,
            w: 35.5,
            uom: "cm"
        }
    }
)
```

插入多条数据
```
db.inventory.insertMany([
    {
        item: "journal",
        qty: 25,
        tags: ["blank", "red"],
        size: {
            h: 14,
            w: 21,
            uom: "cm"
        }
    },
    {
        item: "mat",
        qty: 85,
        tags: ["gray"],
        size: {
            h: 27.9,
            w: 35.5,
            uom: "cm"
        }
    },
    {
        item: "mousepad",
        qty: 25,
        tags: ["gel", "blue"],
        size: {
            h: 19,
            w: 22.85,
            uom: "cm"
        }
    }
])
```
三种操作方式
db.collection.insertOne()	// 将单个文档插入到集合中。
db.collection.insertMany()	//将多个文档插入集合中。
db.collection.insert() // 将单个文档或多个文档插入集合中。

// 其他插入方法

db.collection.update() 
db.collection.updateOne()
db.collection.updateMany()
db.collection.findAndModify() 
db.collection.findOneAndUpdate() 
db.collection.findOneAndReplace() 
db.collection.save().
db.collection.bulkWrite()

##### 2.2.2 查询操作
// 查找所有
db.inventory.find( {} )
db.inventory.find()  // 对应 select *

```
// 1
{
    "_id": ObjectId("5d26b1b73739000067000358"),
    "item": "canvas",
    "qty": 100,
    "tags": [
        "cotton"
    ],
    "size": {
        "h": 28,
        "w": 35.5,
        "uom": "cm"
    }
}

// 2
{
    "_id": ObjectId("5d26b2493739000067000359"),
    "item": "journal",
    "qty": 25,
    "tags": [
        "blank",
        "red"
    ],
    "size": {
        "h": 14,
        "w": 21,
        "uom": "cm"
    }
}
```
条件查询
```
db.inventory.find( { status: "D" } ) // select * from ..where 
```

In 查询
```
db.inventory.find( { status: { $in: [ "A", "D" ] } } )
```
逻辑小于
```
db.inventory.find( { status: "A", qty: { $lt: 30 } } )
```

多条件查询
```
db.inventory.find({
    $or: [{
        status: "A"
    }, {
        qty: {
            $lt: 30
        }
    }]
}) // SELECT * FROM inventory WHERE status = "A" OR qty < 30
```
自定义返回问题，先插入测试数据
```
db.inventory.insertMany( [
  { item: "journal", status: "A", size: { h: 14, w: 21, uom: "cm" }, instock: [ { warehouse: "A", qty: 5 } ] },
  { item: "notebook", status: "A",  size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "C", qty: 5 } ] },
  { item: "paper", status: "D", size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "A", qty: 60 } ] },
  { item: "planner", status: "D", size: { h: 22.85, w: 30, uom: "cm" }, instock: [ { warehouse: "A", qty: 40 } ] },
  { item: "postcard", status: "A", size: { h: 10, w: 15.25, uom: "cm" }, instock: [ { warehouse: "B", qty: 15 }, { warehouse: "C", qty: 35 } ] }
]);
```
默认返回所有字段
```
db.inventory.find( { status: "A" } )
```
自定义返回，默认会连带主键返回
```
db.inventory.find({
    status: "A"
}, {
    item: 1,
    status: 1
}) // 相当于 SELECT _id, item, status from inventory WHERE status = "A"
```
返回数据为
```
// 1
{
    "_id": ObjectId("5d26ebf0373900006700038a"),
    "item": "journal",
    "status": "A"
}
// 2
{
    "_id": ObjectId("5d26ebf0373900006700038b"),
    "item": "notebook",
    "status": "A"
}
```
可以不带主键返回
```
db.inventory.find(
 { status: "A"},
 { item: 1,status: 1,  _id: 0}
 )
```
返回数据为
```
// 1
{
    "item": "journal",
    "status": "A"
}
// 2
{
    "item": "notebook",
    "status": "A"
}
```

##### 2.2.3 删除操作
删除所有的数据
```
db.test2.deleteMany({})
```
只删除一个
```
db.inventory.deleteOne( { status: "D" } )
```
##### 2.2.4 修改操作
Update 操作

db.collection.updateOne()
db.collection.updateMany()
db.collection.replaceOne()

如果有多个数据，只会更新一个，updateMany才会更新多个
```
db.inventory.updateOne(
   { item: "paper" },
   {
     $set: { "size.uom": "cm", status: "P" },
     $currentDate: { lastModified: true }
   }
)
```
替换一个
```
db.inventory.replaceOne(
   { item: "paper" },
   { item: "paper", instock: [ { warehouse: "A", qty: 60 }, { warehouse: "B", qty: 40 } ] }
)
```
替换多个
```
db.inventory.replaceMany(
   { item: "paper" },
   { item: "paper", instock: [ { warehouse: "A", qty: 60 }, { warehouse: "B", qty: 40 } ] }
)
```
## [下一篇 MongoDbRepository的常用AP操作和易错点](https://blog.csdn.net/qq_42105629/article/details/95628082)