## 线程的定义：
某一时间点执行的处理，是操作系统能够进行运算调度的最小单位。一条线程是某一进程中一个单一顺序的控制流，一个进程中可以并发多个线程，每条线程并行执行不同的任务。
## Java中线程的实现：
基于Java虚拟机（JVM，Java Virtual Machine，多学英语，也算是培养专业素养了），这点很重要，帮你们复习一下JVM的运行原理，自己之前看过研究过JVM的一些知识，自己亲手画的运行内存图。

下面是我上传的资料连接，有兴趣的朋友，欢迎下载。

[***Java虚拟机原理规范***](http://download.csdn.net/download/qq_42105629/10473416)
![jvm内存分布](https://img-blog.csdnimg.cn/20190406135758402.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)   

## 代码实现

太多JVM的知识，不太好讲，这里先不说了。下面直接上代码，比较两种方式的实现。。。
eclipse或是其他开发工具的使用我也不介绍了，我是用eclipse开发，其他工具，甚至记事本（扫地僧的级别玩家，膜拜都是可以实现的，确保本地配置好了好了java的运行环境即可。
抱歉，可能部分人会觉的代码比较乱，自己可以分包写，对于简单些的代码，我习惯这样写。
```code

public class Demo2 {
	public static void main(String[] args) { // main方法的入口方法
		new Thread2_1("线程一").run(); // main线程，线程中调用了其他线程方法
		new Thread2_1("线程一").start(); // Thread-1线程， ,并自动调用了run方法

		new Thread2_2("线程二").run(); // main线程
		new Thread(new Thread2_2("线程二")).start(); // Thread-2线程，并自动调用了run方法
	}
}

class Thread2_1 extends Thread {

	private String name;

	public Thread2_1(String name) {
		name = this.name;
	}

	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(Thread.currentThread().getName() + "--extends 实现---Good");
		}
	}

	public void a() {
		System.out.println(Thread.currentThread().getName() + "-----其他方法执行了");
	}
}

class Thread2_2 implements Runnable {

	private String name;

	public Thread2_2(String name) {
		name = this.name;
	}

	@Override
	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(Thread.currentThread().getName() + "--implements 实现---Good");
		}
	}

}
```
## 代码分析
程序入口，main方法，定义了线程的启动，比较结果输出
```main
public class Demo2 {
	public static void main(String[] args) { // main方法的入口方法
		new Thread2_1("线程一").run(); // main线程，线程中调用了其他线程方法
		new Thread2_1("线程一").start(); // Thread-1线程， ,并自动调用了run方法

		new Thread2_2("线程二").run(); // main线程
		new Thread(new Thread2_2("线程二")).start(); // Thread-2线程，并自动调用了run方法
	}
}
```
定义Thread2_1线程，extends Thread 方式实现，有参构造，便于命名区分，两个方法用于测试
```Thread2_1
class Thread2_1 extends Thread {

	private String name;

	public Thread2_1(String name) {
		name = this.name;
	}

	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(Thread.currentThread().getName() + "--extends 实现---Good");
		}
	}

	public void a() {
		System.out.println(Thread.currentThread().getName() + "-----其他方法执行了");
	}
}
```
定义Thread2_2线程，implements runnable 方式，有参构造，便于命名区分
```Thread2_2
class Thread2_2 implements Runnable {

	private String name;

	public Thread2_2(String name) {
		name = this.name;
	}

	@Override
	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(Thread.currentThread().getName() + "--implements 实现---Good");
		}
	}

}
```
## 输出结果

```
main--extends 实现---Good
main--extends 实现---Good
main--extends 实现---Good
main--extends 实现---Good
main--extends 实现---Good
Thread-1--extends 实现---Good
Thread-1--extends 实现---Good
main--implements 实现---Good
main--implements 实现---Good
main--implements 实现---Good
main--implements 实现---Good
main--implements 实现---Good
Thread-1--extends 实现---Good
Thread-1--extends 实现---Good
Thread-1--extends 实现---Good
Thread-2--implements 实现---Good
Thread-2--implements 实现---Good
Thread-2--implements 实现---Good
Thread-2--implements 实现---Good
Thread-2--implements 实现---Good
```
是不是和你预期一样？
## 总结
一、两种方式都是可行的，都是start()方法启动，会自动调用run()方法，但略有区别。
二、线程调用run()方法，不会启动新的线程，就像例子中，还是在main线程中运行的。
三、Thread类和Runnable方法本质上：Thread类底层是实现了Runnable接口，并且持有run方法,但Thread 类的run方法主体是空的，不执行任何操作，Thread类的run方法通常都由run方法重写（@override）。

