## 项目结构，如下图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715121112774.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
## 一、管理
### 1.1 父子间依赖问题
Pom 工程引入Module，直接 New Module 即可，在 父类的Pom.xml 会自动加入module基本信息，如下
```
<modules>
        <module>initSqlBuild</module>
        <module>specificationBuild</module>
        <module>queryDsl</module>
        <module>initHsqlBuild</module>
        <module>SqlMapping</module>
        <module>jpaCommon</module>
    </modules>
```
新引入的Module的Pom.xml，文件，自动引入如下信息
```
<parent>
        <artifactId>jpa</artifactId>
        <groupId>com.tonels</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>specificationBuild</artifactId>
```


### 1.2 Module间依赖问题
一般会在聚合工程中，加入common模块，提取公共信息，给所有同级模块使用，这个是单向配置的。
直接在依赖方的Pom.xml 里配置如下
```
 <dependency>
            <groupId>com.tonels</groupId>
            <artifactId>common</artifactId>
            <version>1.0-SNAPSHOT</version>
 </dependency>
```

### 1.3 二级父依赖一级父问题，类似上面，直接，加入配置即可
```
		<dependency>
            <groupId>com.tonels</groupId>
            <artifactId>common</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
```
### 1.4 关于项目的重新命名问题，分为两步，
#### 第一步 点击左侧模块名（project 视图下），快捷键 Shirt + F6，出现，下图分别 Rename文件夹名和Module名
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715133955407.png)
#### 第二步 手动修改所依赖和所有被依赖的地方，这里我试过，本地IDEA并没有重新 Rafactor 所有的相关者
### 1.5 关于Parent项目的Remove Module问题，分三步
#### 第一步 点击左侧模块名（project 视图下），右键，如图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715134900976.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
或者直接键盘 Delete，会出现如下，OK 即可
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715135133176.png)
注意：Ok 之后，两个地方会出现变化
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019071513561355.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
#### 第二步 Remove 之后，此时的Pom工程中，模块管理的地方并没有自动移除，这里要手动移除
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715140109758.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
移除后，会注意到，我们期望的，Maven视图下的灰色模块就会不见了。
#### 第三步 手动 Delete projerct视图下的模块即可

## 二、打包问题
### Maven打包就一个问题，就是找不到依赖的问题，可能基于 Eclipse 和 IDEA 的一些配置管理的不同，打包有时会出现不同的结果，有时，Eclipse打包正常，[IDEA无法打包，尝试各种方法解决，我之前写过一些总结，点击可链接。。](https://blog.csdn.net/qq_42105629/article/details/95069955)
要注意的地方
### 2.1 自动打包，在最跟处，用IDEA集成的Macen插件，直接 clean 之后，install 即可
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715141134846.png)
 
### 2.2 手动打包，要完全按照依赖顺序，依次打包，这里我开始是手动依次打包，出现了暂时解决不了的问题，找不到依赖包，后来我选择了第一种。。。。

### 2.3 打包后的目录结构，为什么会是这个样子？？
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190715141804593.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
### 并不是我所希望的目录结构，那种按项目分级的项目结构，可能是我定义Package的时候，不规范，全是 com.tonels 引发的问题，先不探究这个了...其实所有的一切是因为，我先在二级 parent 中定义了一个与一级 parent 同名的模块，我以为会按项目结构划分打包目录，然后后来，引包引不进去，修改项目名，打包不成功，等等暂时不能解决的问题。
### 上一篇 [maven打包失败，Could not resolve dependencies for project...Could not find artifact ...in..问题解决](https://blog.csdn.net/qq_42105629/article/details/95069955)