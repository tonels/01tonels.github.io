---
layout: post
title: "findById、getOne和findOneById的区别"
description: "findById、getOne和findOneById的区别"
categories: [SpringData JPA]
tags: [jekyll]
redirect_from:
  - /2019/02/28/
---
# findById、getOne和findOneById的区别
**代码示例**
```getOne
@GetMapping("/getOne")
	public ResultBean getOne(Long id) {
		return ResultBean.ok(stu2Service.getOne(id));
	}
```
```findById
@GetMapping("/findById")
	public ResultBean findById(Long id) {
		return ResultBean.ok(stu2Service.findById(id));
	}
```

```findOneById
@GetMapping("/findOneById")
	public ResultBean findOneById(Long id) {
		return ResultBean.ok(stu2Service.findOneById(id));
	}
```
**总结  不同点**

 1. 返回对象不同
```
public Optional<T> findById(ID id)；	返回的是Optional对象，通过.get()可获取到对象
public T getOne(ID id)；	不是直接返回的对象，但此方法可以获取对象的相关属性值
Stu2 findOneById(Long id);	根据命名规则中自定义实现，可直接返回到对象
```
 2. 对空值异常的处理不同,此处模拟的是如果Id在数据库中不存在时的异常

```
findById
        	No value present] with root cause
```
```
 getOne
 	Unable to find com.aust.first.entity.Stu2 with id 20
```
```
 findOneById，没有异常出现
```



 3. SQL语句不同
```
		findById
        	SELECT
	stu2x0_.id_ AS id_1_1_0_,
	stu2x0_.admission_time AS admissio2_1_0_,
	stu2x0_.age_ AS age_3_1_0_,
	stu2x0_.created_by AS created_4_1_0_,
	stu2x0_.hobbies_ AS hobbies_5_1_0_,
	stu2x0_.name_ AS name_6_1_0_,
	stu2x0_.phone_ AS phone_7_1_0_,
	stu2x0_.sid_ AS sid_8_1_0_,
	stu2x0_.summary_ AS summary_9_1_0_
FROM
	ls_stu2 stu2x0_
WHERE
	stu2x0_.id_ =?
```
```
 		getOne        	
SELECT
	stu2x0_.id_ AS id_1_1_0_,
	stu2x0_.admission_time AS admissio2_1_0_,
	stu2x0_.age_ AS age_3_1_0_,
	stu2x0_.created_by AS created_4_1_0_,
	stu2x0_.hobbies_ AS hobbies_5_1_0_,
	stu2x0_.name_ AS name_6_1_0_,
	stu2x0_.phone_ AS phone_7_1_0_,
	stu2x0_.sid_ AS sid_8_1_0_,
	stu2x0_.summary_ AS summary_9_1_0_
FROM
	ls_stu2 stu2x0_
WHERE
	stu2x0_.id_ =?
```
```
 		findOneById        	
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
	stu2x0_.id_ =?
```
不是很高大上的东西，自己的学习记录而已……


