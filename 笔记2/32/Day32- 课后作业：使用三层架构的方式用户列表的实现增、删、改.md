# 第5章 课后作业：使用三层架构的方式用户列表的实现增、删、改&分页展示所有联系人

## 5.1 添加联系人功能

### 5.1.1 案例需求

1. 点击添加联系人跳转添加联系人页面

   ![](img\11.png)

2. 在添加联系人页面，添加新的联系人

   ![](img\12.png)

3. 在添加完成，可以查看到新建的联系人信息

### 5.1.2 案例效果

![](img\13.png)

### 5.1.3 案例分析

![](img\14.png)

### 5.1.4 实现步骤

#### 5.1.4.1 页面修改

list.jsp

```jsp
<td colspan="8" align="center"><a class="btn btn-primary" href="/day05/add.jsp">添加联系人</a></td>
```

add.jsp

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- HTML5文档-->
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>添加用户</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <center><h3>添加联系人页面</h3></center>
    <form action="/day05/add" method="post">
        <div class="form-group">
            <label for="name">姓名：</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名">
        </div>

        <div class="form-group">
            <label>性别：</label>
            <input type="radio" name="sex" value="男" checked="checked"/>男
            <input type="radio" name="sex" value="女"/>女
        </div>

        <div class="form-group">
            <label for="age">年龄：</label>
            <input type="text" class="form-control" id="age" name="age" placeholder="请输入年龄">
        </div>

        <div class="form-group">
            <label for="address">籍贯：</label>
            <select name="address" class="form-control" id="jiguan">
                <option value="广东">广东</option>
                <option value="广西">广西</option>
                <option value="湖南">湖南</option>
            </select>
        </div>

        <div class="form-group">
            <label for="qq">QQ：</label>
            <input type="text" class="form-control" name="qq" placeholder="请输入QQ号码"/>
        </div>

        <div class="form-group">
            <label for="email">Email：</label>
            <input type="text" class="form-control" name="email" placeholder="请输入邮箱地址"/>
        </div>

        <div class="form-group" style="text-align: center">
            <input class="btn btn-primary" type="submit" value="提交" />
            <input class="btn btn-default" type="reset" value="重置" />
            <input class="btn btn-default" type="button" value="返回" />
        </div>
    </form>
</div>
</body>
</html>
```



#### 5.1.4.2 servlet代码

```java
package cn.itcast.web;



import cn.itcast.domain.Contact;
import cn.itcast.service.ContactService;
import cn.itcast.service.impl.ContactServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet(name = "AddServlet",urlPatterns = "/add")
public class AddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //处理post请求乱码
        request.setCharacterEncoding("utf-8");
        //获取请求参数，封装数据到对象
        Contact con = new Contact();
        try {
            BeanUtils.populate(con,request.getParameterMap());
        } catch (Exception e) {
            e.printStackTrace();
        }
        //调用Service添加数据
        ContactService contactService = new ContactServiceImpl();
        contactService.add(con);
        //重新调用查询全部的servlet查看效果
        response.sendRedirect(request.getContextPath()+"/queryAll");

    }
}

```



#### 5.1.4.3 service代码

接口：

```java
  /**
     * 添加联系人的方法
     *
     * */
    void add(Contact con);
```

实现类：

```java
   @Override
    public void add(Contact con) {
        contactDao.add(con);
    }
```



#### 5.1.4.4 dao代码

接口：

```java
/**
     *  添加联系人的方法
     *
     * */
    void add(Contact con);
```



实现类：

```java
 @Override
    public void add(Contact con) {
        String sql = "insert into contact values(null,?,?,?,?,?,?)";
        template.update(sql,con.getName(),con.getSex(),con.getAge(),con.getAddress(),con.getQq(),con.getEmail());
    }
```





## 5.2 删除联系人功能

### 5.2.1 案例需求

1. 点击删除按钮删除当前一整行数据

   ![](img\15.png)

2. 删除之后重新查询全部展示删除效果

### 5.2.2 案例效果

![](img\16.png)

之前创建的李思思数据消失。

### 5.2.3 案例分析

![](img\17.png)

### 5.2.4 实现步骤

#### 5.2.4.1 修改jsp页面删除按钮

```jsp
<a class="btn btn-default btn-sm" href="/day05/delete?id=${con.id}">删除</a>
```



#### 5.2.4.2 servlet代码

```java
package cn.itcast.web;

import cn.itcast.service.ContactService;
import cn.itcast.service.impl.ContactServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteServlet",urlPatterns = "/delete")
public class DeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取要被删除数据的主键id
        int id = Integer.parseInt(request.getParameter("id"));
        //调用service方法删除数据
        ContactService contactService = new ContactServiceImpl();
        contactService.delete(id);

        //调用查询全部的servlet展示效果
        response.sendRedirect(request.getContextPath()+"/queryAll");
    }
}

```

#### 5.2.4.3 service代码

接口：

```java
 /**
     * 删除联系人的方法
     *
     * */
    void delete(int id);
```



实现类：

```java
    @Override
    public void delete(int id) {
        contactDao.delete(id);
    }
```



#### 5.2.4.4 dao代码

接口：

```java
 /**
     *  删除联系人的方法
     *
     * */
    void delete(int id);
```



实现类：

```java
 @Override
    public void delete(int id) {
        String sql= "delete from contact where id = ?";
        template.update(sql,id);
    }
```







## 5.3 修改联系人功能

​	修改联系人功能分成两个部分，我们需要分开制作，修改的第一步是要知道原来的数据是什么，因此，第一个部分，我们要做的是数据回显。

### 5.3.1 数据回显（查询指定联系人）

#### 5.3.1.1 案例需求

![](img\18.png)

#### 5.3.1.2 案例效果

​	用户点击修改按钮跳转updae.jsp，并且回显联系人数据。

#### 5.3.1.3 案例分析

![](img\19.png)

#### 5.3.1.4 实现步骤

##### 5.3.1.4.1 修改页面

list.jsp

```jsp
<a class="btn btn-default btn-sm" href="/day05/queryById?id=${con.id}">修改</a>
```

update.jsp

```jsp
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
    <head>
    	<base href="<%=basePath%>"/>
        <!-- 指定字符集 -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>修改用户</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="js/jquery-2.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <div class="container" style="width: 400px;">
        <h3 style="text-align: center;">修改联系人</h3>
        <form action="/day05/update" method="post">
      <div class="form-group">
        <label for="name">姓名：</label>
        <input type="text" class="form-control" id="name" name="name" value="${con.name}"  readonly="readonly" placeholder="请输入姓名" />
      </div>

      <div class="form-group">
        <label>性别：</label>
          <input type="radio" name="sex" value="男"  <c:if test="${con.sex == '男'}">checked="checked"</c:if>/>男
    		<input type="radio" name="sex" value="女" <c:if test="${con.sex == '女'}">checked="checked"</c:if>/>女
      </div>
      
      <div class="form-group">
        <label for="age">年龄：</label>
        <input type="text" class="form-control" id="age"  name="age" value="${con.age}" placeholder="请输入年龄" />
      </div>

      <div class="form-group">
        <label for="address">籍贯：</label>
	     <select name="address" class="form-control" >
	        <option value="广东" <c:if test="${con.address == '广东'}">selected="selected"</c:if>>广东</option>
	        <option value="广西" <c:if test="${con.address == '广西'}">selected="selected"</c:if>>广西</option>
	        <option value="湖南" <c:if test="${con.address == '湖南'}">selected="selected"</c:if>>湖南</option>
        </select>
      </div>
      
      <div class="form-group">
        <label for="qq">QQ：</label>
        <input type="text" class="form-control" name="qq" value="${con.qq}" placeholder="请输入QQ号码"/>
      </div>

      <div class="form-group">
        <label for="email">Email：</label>
        <input type="text" class="form-control" name="email" value="${con.email}" placeholder="请输入邮箱地址"/>
      </div>

         <div class="form-group" style="text-align: center">
			<input class="btn btn-primary" type="submit" value="提交" />
			<input class="btn btn-default" type="reset" value="重置" />
			<input class="btn btn-default" type="button" value="返回"/>
         </div>
        </form>
        </div>
    </body>
</html>
```

##### 5.3.1.4.2 servlet

```java
package cn.itcast.web;

import cn.itcast.domain.Contact;
import cn.itcast.service.ContactService;
import cn.itcast.service.impl.ContactServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "QueryByIdServlet",urlPatterns = "/queryById")
public class QueryByIdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求参数id
        int id = Integer.parseInt(request.getParameter("id"));
        //调用service方法获取数据
        ContactService contactService = new ContactServiceImpl();
        Contact con = contactService.queryById(id);
        //将数据转发到页面展示
        request.setAttribute("con",con);
        request.getRequestDispatcher("/update.jsp").forward(request,response);
    }
}

```

##### 5.3.1.4.3 service

接口：

```java
/**
     * 根据id获取指定联系人的方法
     *
     * */
    Contact queryById(int id);
```



实现类：

```java
  @Override
    public Contact queryById(int id) {
        return  contactDao.queryById(id);
    }
```

##### 5.3.1.4.4 dao

接口：

```java
/**
     * 根据id获取指定联系人的方法
     *
     * */
    Contact queryById(int id);
```



实现类：

```java
 @Override
    public Contact queryById(int id) {
        String sql = "select * from contact where id = ?";
        Contact contact = template.queryForObject(sql, new BeanPropertyRowMapper<Contact>(Contact.class), id);
        return contact;
    }
```



完成了第一部分之后，我们再来正式修改联系人。

### 5.3.2 修改联系人

#### 5.3.2.1 案例需求

![](img\20.png)

#### 5.3.2.2 案例效果

修改完成之后展示修改后的数据

![](img\21.png)

#### 5.3.2.3 案例分析

![](img\22.png)

#### 5.3.2.4 实现步骤

##### 5.3.2.4.1 修改jsp

update.jsp

```jsp
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
    <head>
    	<base href="<%=basePath%>"/>
        <!-- 指定字符集 -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>修改用户</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="js/jquery-2.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <div class="container" style="width: 400px;">
        <h3 style="text-align: center;">修改联系人</h3>
        <form action="/day05/update" method="post">
      <div class="form-group">
        <label for="name">姓名：</label>
        <input type="text" class="form-control" id="name" name="name" value="${con.name}"  readonly="readonly" placeholder="请输入姓名" />
          <!--设置一个隐藏域，保存联系id-->
          <input type="hidden" name="id" value="${con.id}">
      </div>

      <div class="form-group">
        <label>性别：</label>
          <input type="radio" name="sex" value="男"  <c:if test="${con.sex == '男'}">checked="checked"</c:if>/>男
    		<input type="radio" name="sex" value="女" <c:if test="${con.sex == '女'}">checked="checked"</c:if>/>女
      </div>
      
      <div class="form-group">
        <label for="age">年龄：</label>
        <input type="text" class="form-control" id="age"  name="age" value="${con.age}" placeholder="请输入年龄" />
      </div>

      <div class="form-group">
        <label for="address">籍贯：</label>
	     <select name="address" class="form-control" >
	        <option value="广东" <c:if test="${con.address == '广东'}">selected="selected"</c:if>>广东</option>
	        <option value="广西" <c:if test="${con.address == '广西'}">selected="selected"</c:if>>广西</option>
	        <option value="湖南" <c:if test="${con.address == '湖南'}">selected="selected"</c:if>>湖南</option>
        </select>
      </div>
      
      <div class="form-group">
        <label for="qq">QQ：</label>
        <input type="text" class="form-control" name="qq" value="${con.qq}" placeholder="请输入QQ号码"/>
      </div>

      <div class="form-group">
        <label for="email">Email：</label>
        <input type="text" class="form-control" name="email" value="${con.email}" placeholder="请输入邮箱地址"/>
      </div>

         <div class="form-group" style="text-align: center">
			<input class="btn btn-primary" type="submit" value="提交" />
			<input class="btn btn-default" type="reset" value="重置" />
			<input class="btn btn-default" type="button" value="返回"/>
         </div>
        </form>
        </div>
    </body>
</html>
```



##### 5.3.2.4.2 servlet

```java
package cn.itcast.web;

import cn.itcast.domain.Contact;
import cn.itcast.service.ContactService;
import cn.itcast.service.impl.ContactServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet(name = "UpdateServlet",urlPatterns = "/update")
public class UpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //处理请求参数乱码
        request.setCharacterEncoding("utf-8");
        //获取请求参数封装数据到对象
        Contact contact = new Contact();
        try {
            BeanUtils.populate(contact,request.getParameterMap());
        } catch (Exception e) {
            e.printStackTrace();
        }
        //调用service方法修改数据
        ContactService contactService = new ContactServiceImpl();
        contactService.update(contact);
        //调用查询全部的servlet，展示修改效果
        response.sendRedirect(request.getContextPath()+"/queryAll");
    }
}

```



##### 5.3.2.4.3 service

接口：

```java
 /**
     * 修改联系人的方法
     *
     * */
    void update(Contact contact);
```

实现类：

```java
@Override
    public void update(Contact contact) {
        contactDao.update(contact);
    }
```

##### 5.3.2.4.4 dao

接口：

```java
/**
     * 修改联系人的方法
     *
     * */
    void update(Contact contact);
```

实现类：

```java
@Override
    public void update(Contact contact) {
        String sql= "update contact set sex = ?,age = ? ,address = ? ,qq = ? ,email = ? where id = ?";
        template.update(sql,contact.getSex(),contact.getAge(),contact.getAddress(),contact.getQq(),contact.getEmail(),contact.getId());
    }
```



