# 第1章 拓展资料
## 1.1 准备数据
```sql
CREATE TABLE student (
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20),
  age INT,
  score DOUBLE DEFAULT 0.0
);
```

## 1.2 硬编码方式实现C3P0连接池
### 1.2.1 案例需求
使用代码给C3P0连接池设置相应的参数。

### 1.2.2 案例步骤
1. 导入jar包`c3p0-0.9.1.2.jar`
2. 创建连接池对象ComboPooledDataSource对象
3. 设置连接参数：driverClass，jdbcUrl，user，password
4. 设置连接池参数
   * 初始连接数initialPoolSize
   * 最大连接数maxPoolSize
   * 最大等待时间checkoutTimeout
   * 最大空闲回收时间maxIdleTime
5. 获取连接对象(`getConnection()`方法)

### 1.2.3 案例代码
```java
public class Demo01 {

	public static void main(String[] args) throws Exception {
		// 2.创建连接池对象ComboPooledDataSource对象
		ComboPooledDataSource ds = new ComboPooledDataSource();
		
		// 连接到数据库的相关参数
		// 3.设置连接参数:driverClass , jdbcUrl, user, password
		ds.setDriverClass("com.mysql.jdbc.Driver"); // 设置驱动的名称
		ds.setJdbcUrl("jdbc:mysql://localhost:3306/day25");
		ds.setUser("root");
		ds.setPassword("root");
		
		// 4.设置连接池参数
		// a.初始连接数initialPoolSize
		ds.setInitialPoolSize(5);
		
		// b.最大连接数maxPoolSize
		ds.setMaxPoolSize(10);
		
		// c.最大等待时间checkoutTimeout
		// Java程序去连接池中取连接,最长的等待时间,超过这个时间会有异常
		ds.setCheckoutTimeout(5000);
		
		// d.最大空闲回收时间maxIdleTime
		// 连接池中的连接超过这个时间没有人使用,就会自动销毁
		ds.setMaxIdleTime(3000);
		
		Connection conn = ds.getConnection(); // 从一个连接池中取出一个连接
		String sql = "INSERT INTO student VALUES (NULL, ?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "张三");
		pstmt.setInt(2, 25);
		pstmt.setDouble(3, 99.5);
		
		int i = pstmt.executeUpdate();
		System.out.println("INSERT 影响的行数：" + i);
		pstmt.close();
		conn.close(); // 将连接还回连接池中
	}
}
```

### 1.2.4 案例效果
1. 正常获取连接
  ![](imgs\拓展02.png)
2. 获取连接超时
  ![](imgs\拓展03.png)
3. 使用连接池中连接执行SQL语句
  ![](imgs\拓展01.png)

>总结：使用纯代码获取配置C3P0连接池的弊端，所有配置信息都写在代码中。一旦需要改配置信息，就需要改动源代码，非常麻烦。

## 1.3 硬编码方式实现DRUID连接池
### 1.3.1 案例需求
使用代码给DRUID连接池设置相应的参数。

### 1.3.2 案例步骤
1. 导入jar包`druid-1.0.9.jar`
2. 创建连接池对象DruidDataSource对象
3. 设置连接参数:driverClassName , url, username, password
4. 设置连接池参数
   * 初始连接数initialSize
   * 最大连接数maxActive
   * 最大等待时间maxWait
   * 最小空闲连接minIdle
5. 获取连接对象(`getConnection()`方法)

### 1.3.3 案例代码
```java
public class Demo02 {
	public static void main(String[] args) throws Exception {
		DruidDataSource ds = new DruidDataSource();
		
		// 设置置连接参数
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://127.0.0.1:3306/day25");
		ds.setUsername("root");
		ds.setPassword("root");
		
		// 设置连接池参数
		ds.setInitialSize(5);
		ds.setMaxActive(10);
		ds.setMaxWait(3000);
		ds.setMinIdle(3);
		
		// 从连接池中取出连接
		Connection conn = ds.getConnection();
		
		// 执行SQL语句
		String sql = "INSERT INTO student VALUES (NULL, ?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "王五");
		pstmt.setInt(2, 35);
		pstmt.setDouble(3, 88.5);
		
		int i = pstmt.executeUpdate();
		System.out.println("影响的行数： " + i);
		
		pstmt.close();
		conn.close(); // 将连接还回连接池中
	}
}
```

### 1.3.4 案例效果
1. 正常获取连接
  ![](imgs\拓展04.png)
2. 获取连接超时
  ![](imgs\拓展05.png)
3. 使用连接池中连接执行SQL语句
  ![](imgs\拓展06.png)

>总结：使用纯代码获取配置DRUID连接池的弊端，所有配置信息都写在代码中。一旦需要改配置信息，就需要改动源代码，非常麻烦。