***

## Spring Data JPA中自定义命名规则中，如何实现，自定义排序输出

***
## 代码如下
```controller
// findByName,会有重名的，返回list,默认是按照ID，返回，现自定义排序规则,按照入学时间升序排序
	@GetMapping("/findByName2")
	public ResultBean getbyName2(String name) {
		return ResultBean.ok(stu2Service.findByAndSort(name));
	}
```

```service
public interface Stu2Service {
	List<Stu2> findByAndSort(String name);
}
```

```JPARepository
public interface Stu2Repository extends JpaRepository<Stu2, Long>, JpaSpecificationExecutor<Stu2> {

	@Query("select u from Stu2 u where u.name=?1")
	List<Stu2> findByAndSort(String name, Sort sort);
}
```

```serviceImpl
@Override
public List<Stu2> findByAndSort(String name) {
	return stu2Repository.findByAndSort(name, Sort.by(Direction.ASC, "admissionTime"));
	}
```
## 启动项目，访问   http://ip:port/xxx//findByName2?name=xx

### JPA生成的SQL语句为
```SQL
SELECT
	stu2x0_.id_ AS id_1_1_,
	stu2x0_.admission_time AS admissio2_1_,
	stu2x0_.age_ AS age_3_1_,
	stu2x0_.created_by AS created_4_1_,
	stu2x0_.hobbies_ AS hobbies_5_1_,
	stu2x0_.name_ AS name_6_1_,
	stu2x0_.phone_ AS phone_7_1_,
	stu2x0_.sid_ AS sid_8_1_,
	stu2x0_.summary_ AS summary_9_1_
FROM
	ls_stu2 stu2x0_
WHERE
	stu2x0_.name_ =?
ORDER BY
	stu2x0_.admission_time ASC
```

这里是引用

### 响应数据为JSON格式

```Response
{
    "code":"0",
    "msg":"成功",
    "result":[
        {
            "id":15,
            "sid":null,
            "name":"西门峰",
            "age":26,
            "phone":null,
            "hobbies":"篮球",
            "summary":"即使生活很丧，我依旧不想去做一个极端且悲观的人，因为我相信，既然有那么多人憧憬未来，对生活满怀期待，那这世界一定没有我想的那么糟糕。",
            "createdBy":"sl",
            "admissionTime":"2008-06-18 09:27:25"
        },
        {
            "id":16,
            "sid":null,
            "name":"西门峰",
            "age":13,
            "phone":null,
            "hobbies":"橄榄球",
            "summary":"To be or not to be……",
            "createdBy":"sl",
            "admissionTime":"2018-02-01 16:52:00"
        },
        {
            "id":14,
            "sid":null,
            "name":"西门峰",
            "age":21,
            "phone":null,
            "hobbies":"足球",
            "summary":"即使生活很丧，我依旧不想去做一个极端且悲观的人，因为我相信，既然有那么多人憧憬未来，对生活满怀期待，那这世界一定没有我想的那么糟糕。",
            "createdBy":"ls",
            "admissionTime":"2018-05-27 17:01:25"
        }
    ],
    "success":true
}
```
