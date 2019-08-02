# [上一篇，基于Hutool包对数据库的增删改查操作](https://blog.csdn.net/qq_42105629/article/details/94627718)
# 这里基于Hutool包下封装的工具类，对Linux连接，还有基本命令操作演示
## 一、工具包代码示例
### 此处是源代码的一部分，，[完整代码在Github上](https://github.com/looly/hutool)

```
/**
 * Jsch工具类<br>
 * Jsch是Java Secure Channel的缩写。JSch是一个SSH2的纯Java实现。<br>
 * 它允许你连接到一个SSH服务器，并且可以使用端口转发，X11转发，文件传输等。<br>
 */
public class JschUtil {
	/** 不使用SSH的值 */
	public final static String SSH_NONE = "none";
	/** 本地端口生成器 */
	private static final LocalPortGenerater portGenerater = new LocalPortGenerater(10000);
	/**
	 * 生成一个本地端口，用于远程端口映射
	 * @return 未被使用的本地端口
	 */
	public static int generateLocalPort() {
		return portGenerater.generate();
	}
	/**
	 * 获得一个SSH会话，重用已经使用的会话
	 * @param sshHost 主机
	 * @param sshPort 端口
	 * @param sshUser 用户名
	 * @param sshPass 密码
	 * @return SSH会话
	 */
	public static Session getSession(String sshHost, int sshPort, String sshUser, String sshPass) {
		return JschSessionPool.INSTANCE.getSession(sshHost, sshPort, sshUser, sshPass);
	}
	/**
	 * 打开一个新的SSH会话
	 * 
	 * @param sshHost 主机
	 * @param sshPort 端口
	 * @param sshUser 用户名
	 * @param sshPass 密码
	 * @return SSH会话
	 */
	public static Session openSession(String sshHost, int sshPort, String sshUser, String sshPass) {
		final Session session = createSession(sshHost, sshPort, sshUser, sshPass);
		try {
			session.connect();
		} catch (JSchException e) {
			throw new JschRuntimeException(e);
		}
		return session;
	}
	/**
	 * 新建一个新的SSH会话
	 * 
	 * @param sshHost 主机
	 * @param sshPort 端口
	 * @param sshUser 机用户名
	 * @param sshPass 密码
	 * @return SSH会话
	 * @since 4.5.2
	 */
	public static Session createSession(String sshHost, int sshPort, String sshUser, String sshPass) {
		if (StrUtil.isEmpty(sshHost) || sshPort < 0 || StrUtil.isEmpty(sshUser) || StrUtil.isEmpty(sshPass)) {
			return null;
		}

		Session session;
		try {
			session = new JSch().getSession(sshUser, sshHost, sshPort);
			session.setPassword(sshPass);
			// 设置第一次登陆的时候提示，可选值：(ask | yes | no)
			session.setConfig("StrictHostKeyChecking", "no");
		} catch (JSchException e) {
			throw new JschRuntimeException(e);
		}
		return session;
	}
}
```
## 二、Java测试连接，操作代码
#### 2.1 建立连接
```
public class JschUtilTest {
	
	@Test
	@Ignore
	public void bindPortTest() {
		//新建会话，此会话用于ssh连接到跳板机（堡垒机），此处为xx.xx.xx.xx(IP)
		Session session = JschUtil.getSession("xx.xx.xx.xx", 22, "xxx", "xxx"); // 这里的IP，端口，用户名和密码需要自己指定
		System.out.println(session.getUserName());
		System.out.println(session.getPort());
	}
}
```
运行测试，就会在控制台打印用户名和端口信息，说明已经成功建立连接了
#### 2.1 ls 查看目录操作
代码示例

```
@Test
	@Ignore
	public void sftpTest() {
		Session session = JschUtil.getSession("xxxx.xx.xx.xx", 22, "username", "password");
		Sftp sftp = JschUtil.createSftp(session);
		List<String> ls = sftp.ls("/opt");
		ls.forEach(System.out::println);
	}
```
结果比较
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190708134735780.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyMTA1NjI5,size_16,color_FFFFFF,t_70)
#### 2.2 删除命令

```
@Test
	@Ignore
	public void sftpTest2() {
		Session session = JschUtil.getSession("xxxx.xx.xx.xx", 22, "username", "password");
		Sftp sftp = JschUtil.createSftp(session);
		boolean b = sftp.delDir("/opt/test/test");
		System.out.println(b);
	}
```

#### 2.3 新建文件夹

```
	@Test
	@Ignore
	public void sftpTest3() {
		Session session = JschUtil.getSession("xxxx.xx.xx.xx", 22, "username", "password");
		Sftp sftp = JschUtil.createSftp(session);
		boolean b = sftp.mkdir("/opt/test/test2");
		System.out.println(b);
	}
```


#### 2.4 文件上传（ Windows --> Linux ）

```
@Test
	@Ignore
	public void sftpTest4() {
		Session session = JschUtil.getSession("xxxx.xx.xx.xx", 22, "username", "password");
		Sftp sftp = JschUtil.createSftp(session);
		Sftp put = sftp.put("D:\\tmp\\a.txt", "/opt/test/as.txt");
	}
```
#### 2.4 文件下载

```
	@Test
	@Ignore
	public void sftpTest5() {
		Session session = JschUtil.getSession("xxxx.xx.xx.xx", 22, "username", "password");
		Sftp sftp = JschUtil.createSftp(session);
sftp.download("/opt/test/as.txt", FileUtil.file("D:\\tmp\\b.txt"));
	}
```


