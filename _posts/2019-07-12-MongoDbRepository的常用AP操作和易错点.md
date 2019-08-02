## 上一篇 [12个MongoDB的可视化工具，以及shell 操作脚本练习](https://blog.csdn.net/qq_42105629/article/details/95480751)
### 在使用SpringData MongoDB时，MongoDbRepository 有如下可利用的 CRUD 的方法
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190712160824546.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)



### 一、insert和save的区别
都是添加保存操作，区别在于当传入主键（不必要）添加时，insert 有插入数据的含义，当有主键冲突时，会报错，而save操作是替换的意思，会覆盖当前主键的数据
### 二、关于主键是Long类型和String类型的问题
```
@Accessors(chain = true)
@Data
@Document(collection = "article_info")
public class Article {

    @Id
    private String id;

    @Field("title")
    private String title;

    @Field("url")
    private String url;

    @Field("author")
    private String author;

    @Field("tags")
    private List<String> tags;

    @Field("visit_count")
    private Long visitCount;

    @Field("add_time")
    private Date addTime;

}
```
```
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Document(collection = "person")
public class Person {

    @Id
    private Long id;

    private String firstname;

    private String lastname;

    private LocalDate birthday;
}
```
#### 1.1 主键为String时，添加时，主键可以指定也可以不指定，Mongo库会自定生成24位的Hash主键，或者你所指定的主键值
#### 1.2 主键为Long类型时，必须给给主键赋值才能添加(Mongo shell操作可以不必须，会自动hash主键值)
#### 1.3 两种类型在Mongo库的存储格式也是不同的
```
{
    "_id": NumberLong("5"),
    "firstname": "李",
    "lastname": "啸",
    "birthday": ISODate("1975-03-04T16:00:00.000Z"),
    "_class": "demo3.model.Person"
}
```
```
{
    "_id": ObjectId("5d285daff2067e140813dfb4"), // 这里主键会自动加下划线
    "title": "Q2SNdr7",
    "url": "http://Wn29gk",
    "author": "ut minim magna",
    "visit_count": NumberLong("91559171"),     // 注意这里其实是忽略驼峰式命名的
    "add_time": ISODate("1993-03-25T00:00:00.000Z"), // 日期类型存在形式，返回对象时，会格式转换为 1993-03-25
    "_class": "demo3.model.Article"  // 会添加 _class字段
}
```
### 三、还有时间格式问题，注释中有提到
#### 四、还有驼峰式命名，也会自动转换的
