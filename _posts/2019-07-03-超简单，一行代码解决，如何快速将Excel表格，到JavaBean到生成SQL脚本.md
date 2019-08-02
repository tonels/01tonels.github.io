# 前言-真的很快速，之前用的是Apache下的Jar包，用起来太麻烦了

```a
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi</artifactId>
    <version>3.17</version>
</dependency>
```
## 一、也试过用阿里基于POI封装的操作，阿里的团队应该很厉害，可能是不熟悉使用方式，也不是很顺手。它的解析数据很简单，两行代码

```a
 InputStream is = new BufferedInputStream(new FileInputStream("C:\\Users\\ZhengYuan\\Desktop\\model.xlsx"));
        List<Object> read1 = EasyExcelFactory.read(is, new Sheet(1, 1));
```


**它解析的出来的是List《Object》，数据格式如下**
```a
[
[1, 阿拉巴马州, Alabama, AL, 蒙哥马利, Montgomery, null],
 [2, 阿拉斯加州, Alaska, AK, 朱诺, Juneau, null], 
 [3, 阿利桑那州, Arizona, AZ, 菲尼克斯, Phoenix, null],
  [4, 阿肯色州, Arkansas, AR, 小石城, Little rock, null], 
  [5, 加利福尼亚州, California, CA, 萨克拉门托, Sacramento, null], 
  [6, 科罗拉多州, Colorado, CO, 丹佛, Denver, null], 
  [7, 康涅狄格州, Connecticut, CT, 哈特福德, Hartford, null],
   [8, 特拉华州, Delaware, DE, 多佛, Dover, null], 
  [9, 佛罗里达州, Florida, FL, 塔拉哈西, Tallahassee, null],
   [10, 乔治亚州, Georgia, GA, 亚特兰大, Atlanta, null]
]
```
**所以，其实里面的Object其实也是一个List，**

```a
[1, 阿拉巴马州, Alabama, AL, 蒙哥马利, Montgomery, null],
```

### 但如何将这里List映射到一个Java对象VO，就很难了，我之前试过一些方法，也能实现但太麻烦了，其实阿里团队应该是国内Java技术最好的了，可能自己并没有掌握精髓而已，这里粘上[阿里Github开源项目](https://github.com/alibaba)，大家可以多去看看，对自己学习很有帮助，毕竟是中国人自己开发的很有技术性的东西。

## 二、在我将要放弃的时候，又发现两个工具类，
**这里贴上maven依赖，是在是很强大的工具类，Guava试谷歌团队开发，使用的，hutool是**
```a
   <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
            <version>4.5.10</version>
        </dependency>
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
            <version>28.0-jre</version>
        </dependency>
```
**其实平时偶尔在用这两个包，只是没有真的好好研究，很多工作还是在重复造轮子了**

### 2.1 解析 Excel 如此方便，快速，下面是代码示例
首先是 excel 表格，这里粘贴一部分数据截图，前十条吧，猜猜总共多少条？

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190703103818818.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
#### **Java对象VO,这里还有我之前自动建表的注解，其实只有一个@Data就可以映射了**

```
package tonels.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Accessors(chain = true)
@Entity
@Table(name = "state")
public class State {

    @Id
    private Integer id;

    @Column(name = "ch_name")
    private String chName;

    @Column(name = "en_name")
    private String enName;

    private String code;

    private String capital;

    private String capitalen;

    private String remark;
}

```
#### 这里是测试代码
```
package tonels.excel;

import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import tonels.model.State;

import java.util.List;

public class Test2 {

    public static void main(String[] args) {
        ExcelReader reader = ExcelUtil.getReader("C:\\Users\\ZhengYuan\\Desktop\\model.xlsx");
        List<State> read = reader.read(0, 1, State.class);
        System.out.println(read);
    }
}
```
#### 打印结果，如下

```
[
State(id=1, chName=阿拉巴马州, enName=Alabama, code=AL, captial=null, capitalen=Montgomery, remark=), 
State(id=2, chName=阿拉斯加州, enName=Alaska, code=AK, captial=null, capitalen=Juneau, remark=),
 State(id=3, chName=阿利桑那州, enName=Arizona, code=AZ, captial=null, capitalen=Phoenix, remark=), 
 State(id=4, chName=阿肯色州, enName=Arkansas, code=AR, captial=null, capitalen=Little rock, remark=),
  State(id=5, chName=加利福尼亚州, enName=California, code=CA, captial=null, capitalen=Sacramento, remark=), 
  State(id=6, chName=科罗拉多州, enName=Colorado, code=CO, captial=null, capitalen=Denver, remark=), 
  State(id=7, chName=康涅狄格州, enName=Connecticut, code=CT, captial=null, capitalen=Hartford, remark=), 
  State(id=8, chName=特拉华州, enName=Delaware, code=DE, captial=null, capitalen=Dover, remark=), 
  State(id=9, chName=佛罗里达州, enName=Florida, code=FL, captial=null, capitalen=Tallahassee, remark=), 
  State(id=10, chName=乔治亚州, enName=Georgia, code=GA, captial=null, capitalen=Atlanta, remark=)
]
```
##### 这正是我所希望的返回的样子 @@@@，先分享到这里吧，接下来，我还要把这些数据生成SQL脚本。
