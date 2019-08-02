## Ajax工作机制
### 1. 认识Ajax
Ajax是Asynchronous JavaScript and XML的简称，即异步的 JavaScript 和 XML。AJAX 不是新的编程语言，而是一种使用现有标准的新方法。最大的优点是在不重新加载整个页面的情况下，可以与服务器交换数据并更新部分网页内容。不需要任何浏览器插件，但需要用户允许JavaScript在浏览器上执行。

###  2. Ajax原理
![Ajax原理](https://img-blog.csdnimg.cn/20190319140150140.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
### 3. 样例代码

 **Java编写Servlet处理Http请求，Eclipse中新建Web工程，项目工程结构如下**
 ![工程结构](https://img-blog.csdnimg.cn/2019031914102337.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
```Servlet
			package sj;
			 
			import java.io.IOException;
			import java.io.PrintWriter;
			import javax.servlet.ServletException;
			import javax.servlet.annotation.WebServlet;
			import javax.servlet.http.HttpServlet;
			import javax.servlet.http.HttpServletRequest;
			import javax.servlet.http.HttpServletResponse;
			 
			/**
			 * Servlet implementation class servlet
			 */
			@WebServlet("/servlet") //这个注解可以指定请求路径为 ip:port/工程名(Ajax)/
			public class Servlet extends HttpServlet {
				private static final long serialVersionUID = 1L;
			       
			    /**
			     * @see HttpServlet#HttpServlet()
			     */
			    public Servlet() {
			        super();
			        // TODO Auto-generated constructor stub
			        System.out.println("启动");
			    }
			 
				/**
				 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
				 */
			    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
			        this.doPost(request, response);  
			    } 
			 
				/**
				 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
				 */
			    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
			        response.setCharacterEncoding("utf-8");  
			        System.out.println("ajax后台交互成功");  
			        PrintWriter write=response.getWriter();  
			        write.println("这是响应的数据<br>"); 
			        write.println("姓名:Tonels<br/>年龄:20");  
			        write.flush();  
			    }  
			 
			}
```
***- hello.html内容格式如下***
```hello.html
<!DOCTYPE html >  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<script type="text/javascript" src="js/util.js"></script>  
<title>Ajax学习</title>  
<script>  
window.onload=function(){  
 
    document.getElementById("btn1").onclick=function(){  
        //发出已补请求  
        //1/得到xhr对象  
        var xhr=getXHR();  
        //2.注册状态变化监听器  
        xhr.onreadystatechange=function(){  
            if(xhr.readyState==4)  
                {  alert(xhr.status); 
                if(xhr.status==200)  
                    {  
                    alert("服务器响应了");  
                    document.getElementById("mytext").innerHTML=xhr.responseText;  
                    }         
                }
            
        }  
        //3.建立与服务器的连接  
        xhr.open("GET","servlet"+"?time="+new Date().getTime());  
        //4.向服务器发出请求  
        xhr.send();  
    }  
}  
</script>  
</head>  
<body>  
<button id="btn1">点我呀</button>  
<div id="mytext"></div>  
</body>  
</html>  
```
- ***util.js代码如下***
```util.js代码如下
function getXHR(){  
    var xmlHttp;  
    try {  
        xmlHttp=new XMLHttpRequest();  
    }catch(e)  
    {  
        try{  
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");  
    }  
        catch(e)  
        {  
            try{  
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");  
            }  
            catch(e)  
            {  
                alert("你的浏览器不支持ajax");  
                return false;  
            }   
        }   
    }  
    return xmlHttp;  
}  
```
- ***启动项目***，前提是本地的tomcat要配置好，启动后直接访问  http://localhost:8080/Ajax/hello.html   即可看到代码效果。
### 4. AJAX 应用场景及常见问题解决
***- 应用场景***
第一、请求的提交是为了页面数据的显示，这时候用户一般不希望看到页面的刷新，是使用AJAX的一个最佳时候。
第二、如果请求提交后，用户能从页面感觉到提交结果，这时候，也最好不要有页面刷新，推荐使用AJAX技术。
第三、如果请求提交后，用户不能从页面感觉到提交动作，如绝大多数时候的数据的增加和修改，这时候则需要页面刷新，不能使用AJAX技术。
第四、复杂的UI，以前对于复杂的C/S模式的UI，B/S模式一向采取逃避的方法，现在则可以放心大胆的使用AJAX来加以解决。  

***- 常见问题解决：***
	1、 第一、输入值校验的问题 申请用户的时候检查用户名是否重复，用AJAX访问后台，既不需要刷新页面，也没有过多的JS代码
	
2、第二、级联显示的问题  访问后台吧，页面需要刷新；JS代码量大，影响内存，数据不安全；所以常级联选择框，级联菜单，导航树等

3、第三、请求结果只改变部分页面 如，论坛的回复帖子和帖子列表在一个页面上的时候。这两个UI在一个页面上，用户体验比回复帖子在另外一个页面好。但回复后要对整个页面进行刷新，这种感觉就不好了。你看，那么大一个帖子列表，只增加你的一个回复，却要对整个页面进行刷新，不管从哪个角度来看都不好。

4、第四、由于技术原因而使用iframe的问题 避免iframe的嵌套引入的技术难题

5、第五、数据录入和列表显示在同一个页面 C/S 模式的UI中常常有数据录入和数据列表显示在同一个界面上，这样对于用户来说有很好的用户体验，用户录入的结果马上就能在同一界面显示。但是在B/S的 UI上，由于需要提交刷新的问题，我们经常把数据的录入和数据显示分别放在两个不同的页面上。很显然，这样的用户体验肯定没有C/S模式来得好。像这样的 问题还有很多，在B/S模式下，都因为技术的原因而选择其他的解决办法。现在我们可以自豪的使用AJAX来宣告可以做出和C/S模式一样复杂的UI了

6、第六、翻页问题 不需要刷新的翻页



### 5. 总结
目前前端框架都是支持Ajax的，像jQuery.js,VUE.js,Node.js等这些库，可以很方便的实现Ajax异步请求，就不用直接用原生的JavaScript语言做繁琐的实现，有兴趣的话，可以自己参考相关资料，动手学习。
	
