# day05 【异常、线程】

## 主要内容

- 异常、线程

## 教学目标

- [ ] 能够辨别程序中异常和错误的区别
- [ ] 说出异常的分类
- [ ] 说出虚拟机处理异常的方式
- [ ] 列举出常见的三个运行期异常
- [ ] 能够使用try...catch关键字处理异常
- [ ] 能够使用throws关键字处理异常
- [ ] 能够自定义异常类
- [ ] 能够处理自定义异常类
- [ ] 说出进程的概念
- [ ] 说出线程的概念
- [ ] 能够理解并发与并行的区别
- [ ] 能够开启新线程

# 第一章    异常

## 1.1 异常概念

异常，就是不正常的意思。在生活中:医生说,你的身体,某个部位有异常,该部位和正常相比有点不同,该部位的功能将受影响.在程序中的意思就是：

* **异常** ：**指的是程序在执行( 编译和运行)过程中，出现的非正常的情况，最终会导致JVM的非正常停止(中断)**。

在Java等面向对象的编程语言中，异常本身是一个类(模拟一类事物)，**产生异常就是创建异常对象并抛出了一个异常对象**。**Java虚拟机默认处理异常的方式**是中断处理,把程序中断,停止,并告诉你异常问题的名字,原因,代码位置!!!

> 异常指的并不是语法错误,语法错了,编译不通过,不会产生字节码文件,根本不能运行.

## 1.2 异常体系,异常一类事物,写一个类来模拟

异常机制其实是帮助我们**找到**程序中的问题，异常的根类是`java.lang.Throwable`，其下有两个子类：`java.lang.Error`与`java.lang.Exception`，平常所说的异常指`java.lang.Exception`。

![](img\异常体系.png)

**Throwable体系：**

* **Error**:严重错误Error，无法通过处理的错误，只能事先避免，好比绝症。
* **Exception**:表示异常，异常产生后程序员可以通过代码的方式纠正，使程序继续运行，是必须要处理的。好比感冒、阑尾炎。

**Throwable中的常用方法：**//留

* `public void printStackTrace()`:打印异常的详细信息。

  包含了异常的类型,异常的原因,还包括异常出现的位置,在开发和调试阶段,可以使用printStackTrace。

* `public String getMessage()`:获取发生异常的原因。

  *提示给用户的时候,就提示错误原因。*

* `public String toString()`:获取异常的类型和异常描述信息(手动写一般不用)。

***出现异常,不要紧张,把异常的简单类名,拷贝到API中去查。***

![](img\简单的异常查看.bmp)

## 1.3 异常分类

我们平常说的异常就是指Exception，因为这类异常一旦出现，我们就要对代码进行更正，修复程序。

**异常(Exception)的分类**:根据在编译时期还是运行时期去检查异常?

* **编译时期异常**:checked异常。在编译时期,就会检查,如果没有处理异常,则编译失败。(如日期格式化异常)
* **运行时期异常**:runtime异常。在运行时期,检查异常.在编译时期,运行异常不会编译器检测(不报错)。(如数学异常)

​    ![](img\异常的分类.png)

## 1.4     异常的产生过程解析

先运行下面的程序，程序会产生一个数组索引越界异常ArrayIndexOfBoundsException。我们通过图解来解析下异常产生的过程。

 工具类

~~~java
public class ArrayTools {
    // 对给定的数组通过给定的角标获取元素。
    public static int getElement(int[] arr, int index) {
        int element = arr[index];
        return element;
    }
}
~~~

 测试类

~~~java
public class ExceptionDemo {
    public static void main(String[] args) {
        int[] arr = { 34, 12, 67 };//0.1.2
        int num = ArrayTools.getElement(arr, 4)
        System.out.println("num=" + num);
        System.out.println("over");
    }
}
~~~

上述程序执行过程图解：

 ![](img\异常产生过程.png)

# 第二章 异常的处理

Java异常处理的五个关键字：**try、catch、finally、throw、throws**

## 2.1 	抛出一个异常对象,真的具体问题throw

在编写程序时，我们必须要考虑程序出现问题的情况。比如，在定义方法时，方法需要接受参数。那么，当调用方法使用接受到的参数时，首先需要先对参数数据进行合法的判断，数据若不合法，就应该告诉调用者，传递合法的数据进来。这时需要使用抛出异常的方式来告诉调用者。

在java中，提供了一个**throw**关键字，它用来抛出**一个指定的异常对象**。那么，抛出一个异常具体如何操作呢？

1. 创建一个异常对象。封装一些提示信息(信息可以自己编写)。

2. 需要将这个异常对象告知给调用者。怎么告知呢？怎么将这个异常对象传递到调用者处呢？通过关键字throw就可以完成。throw 异常对象。

   throw**用在方法内**，用来抛出一个异常对象，将这个异常对象传递到调用者处，并结束当前方法的执行。

**使用格式：**

~~~
throw new 异常类名(参数);
~~~

 例如：

~~~java
throw new NullPointerException("要访问的arr数组不存在");

throw new ArrayIndexOutOfBoundsException("该索引在数组中不存在，已超出范围");
~~~

学习完抛出异常的格式后，我们通过下面程序演示下throw的使用。

~~~java
public class ThrowDemo {
    public static void main(String[] args) {
        //创建一个数组 
        int[] arr = {2,4,52,2};
        //根据索引找对应的元素 
        int index = 4;
        int element = getElement(arr, index);

        System.out.println(element);
        System.out.println("over");
    }
    /*
     * 根据 索引找到数组中对应的元素
     */
    public static int getElement(int[] arr,int index){ 
       	//判断  索引是否越界
        if(index<0 || index>arr.length-1){
             /*
             判断条件如果满足，当执行完throw抛出异常对象后，方法已经无法继续运算。
             这时就会结束当前方法的执行，并将异常告知给调用者。这时就需要通过异常来解决。 
              */
             throw new ArrayIndexOutOfBoundsException("哥们，角标越界了~~~");
        }
        int element = arr[index];
        return element;
    }
}
~~~

> 注意：如果产生了问题，我们就会throw将问题描述类即异常进行抛出，也就是将问题返回给该方法的调用者。
>
> 那么对于调用者来说，该怎么处理呢？一种是进行捕获处理，另一种就是继续将问题声明出去，使用throws声明处理。

## 2.2 Objects非空判断

还记得我们学习过一个Objects类吗，曾经提到过它由一些静态的实用方法组成，这些方法是null-save（空指针安全的）或null-tolerant（容忍空指针的），那么在它的源码中，对对象为null的值进行了抛出异常操作。

* `public static <T> T requireNonNull(T obj)`:查看指定引用对象不是null。

查看源码发现这里对为null的进行了抛出异常操作：

~~~java
public static <T> T requireNonNull(T obj) {
    if (obj == null)
      	throw new NullPointerException();
    return obj;
}
~~~

## 2.3  声明异常throws,throw产生一个真实具体的问题,throws问题的处理方式,不负责任处理,交给jvm,中断,问题类型,原因,位置

**声明异常**：将问题标识出来，报告给调用者。如果方法内通过throw抛出了编译时异常对象，但是有没有捕获处理（稍后讲解该方式），那么必须通过throws进行声明，让调用者去处理。

关键字**throws**运用于方法声明之上,用于表示当前方法不处理异常,而是提醒该方法的调用者来处理异常(抛出异常).

**声明异常格式：**

~~~
修饰符 返回值类型 方法名(参数) throws 异常类名1,异常类名2…{   }	
~~~

声明异常的代码演示：

~~~java
public class ThrowsDemo {
    public static void main(String[] args) throws FileNotFoundException {//声明 调用者jvm,中止
        read("a.txt");
    }

    // 如果定义功能时有问题发生需要报告给调用者。可以通过在方法上使用throws关键字进行声明
    public static void read(String path) throws FileNotFoundException {//声明,标记,通知调用者
        if (!path.equals("a.txt")) {//如果不是 a.txt这个文件 
            // 我假设  如果不是 a.txt 认为 该文件不存在 是一个错误 也就是异常  throw
            throw new FileNotFoundException("文件不存在");//抛出一个编译时异常对象
        }
    }
}
~~~

throws用于进行异常类的声明，若该方法可能有多种异常情况产生，那么在throws后面可以写多个异常类，用逗号隔开。

~~~java
public class ThrowsDemo2 {
    public static void main(String[] args) throws IOException {//声明,交给调用者,jvm
        read("a.txt");
    }

    public static void read(String path)throws FileNotFoundException, IOException {//声明,标记
        if (!path.equals("a.txt")) {//如果不是 a.txt这个文件 
            // 我假设  如果不是 a.txt 认为 该文件不存在 是一个错误 也就是异常  throw
            throw new FileNotFoundException("文件不存在");//编译时异常,也是io异常
        }
        
        if (!path.equals("b.txt")) {
            throw new IOException();//编译时异常
        }
    }
}
//总结:异常是一类事物,写一个类来模拟,类模板而已,真正的这个具体事物是这个类的一个new出来的对象
//当方法的内部出现异常(问题),抛出一个异常对象来表示,谁想使用我这个问题代码,要进行处理,
//处理的方式有两种trycatach,另一种是不负责任的做法throws声明一个异常类型出去,继续交个方法的调用去处理
//如果throws交给jvm虚拟机,把程序中止,告诉异常问题的类型,原因,位置
//编译时异常必须处理,运行时异常可以处理也可以不处理,暂时先用throws处理(相当于不负责任的处理)
~~~

## 2.4  捕获异常try…catch,不是throws踢皮球不负责的处理,而是自己能处理,自己处理,既然是自己处理,没有交个jvm,所以没有中断,后续代码继续执行!!!(throws踢皮球方式最终交个jvm中断,后续代码不再执行!!!)

如果异常出现的话,会立刻中止程序,所以我们得处理异常:

1. 该方法不处理,而是声明抛出,由该方法的调用者来处理(throws)。
2. 在方法中使用try-catch的语句块来处理异常。

**try-catch**的方式就是捕获异常。

* **捕获异常**：Java中对异常有针对性的语句进行捕获，可以对出现的异常进行指定方式的处理。

捕获异常语法如下：

~~~java
try{//尝试,试验,检测,需要时间,越少越好
     编写可能会出现异常的代码
}catch(异常类型  e){//e=对象;//如果上面出现问题,立马catch块抓住它,进行捕获
     处理异常的代码
     //记录日志/打印异常信息/继续抛出异常//待会说
}
~~~

**try：**该代码块中编写可能产生异常的代码。

**catch：**用来进行某种异常的捕获，实现对捕获到的异常进行处理。



> 注意:try和catch都不能单独使用,必须连用。catch处理,后续代码继续执行

演示如下：

~~~java
public class TryCatchDemo {
    public static void main(String[] args) {
        try {// 当产生异常时，必须有处理方式。要么捕获，要么声明。
            read("b.txt");
        } catch (FileNotFoundException e) {// 括号中需要定义什么呢？
          	//try中抛出的是什么异常，在括号中就定义什么异常类型
            System.out.println(e);
        }
        System.out.println("over");
    }
    /*
     *
     * 我们 当前的这个方法中 有异常  有编译期异常
     */
    public static void read(String path) throws FileNotFoundException {
        if (!path.equals("a.txt")) {//如果不是 a.txt这个文件 
            // 我假设  如果不是 a.txt 认为 该文件不存在 是一个错误 也就是异常  throw
            throw new FileNotFoundException("文件不存在");
        }
    }
}
~~~

如何获取异常信息：

Throwable类中定义了一些查看方法:

* `public String getMessage()`:获取异常的描述信息,原因(提示给用户的时候,就提示错误原因。


* `public String toString()`:获取异常的类型和异常描述信息(不用)。
* `public void printStackTrace()`:打印异常的跟踪栈信息并输出到控制台。红色东西,问题类型,原因,位置

​            *包含了异常的类型,异常的原因,还包括异常出现的位置,在开发和调试阶段,可以使用printStackTrace。*

在开发中呢也可以在catch将编译期异常转换成运行期异常处理。

多个异常使用捕获又该如何处理呢？

1. 多个异常分别处理。

2. 多个异常一次捕获，多次处理。//jdk1.7才有,但是有注意事项

3. 多个异常一次捕获一次处理。

4. 三种处理,课堂代码如下:

   ~~~java
   import java.io.FileNotFoundException;
   import java.io.IOException;
   
   public class Test06 {
       public static void main(String[] args)  {
   //        多个异常使用捕获又该如何处理呢？
   //        1. 多个异常分别处理。
   //        try {
   //            method();//FileNotFoundException是IOException子类,儿子
   //            method2();//ClassNotFoundException
   //            method3();//IOException
   //        } catch(FileNotFoundException e) {//e = 异常对象;
   //            e.printStackTrace();
   //        } catch(ClassNotFoundException e) {
   //            e.printStackTrace();
   //        } catch(IOException e) {
   //            e.printStackTrace();
   //        }
           //注意事项,前面的异常类型不能是后面异常类型的父类,报错,多态,父类接收所有的子类对象,后面子类没有意义
   //        try {
   //            method();//FileNotFoundException是IOException子类,儿子
   //            method2();//ClassNotFoundException
   //            method3();//IOException
   //        } catch(IOException e) {//e =  new FileNotFoundException();//多态
   //            e.printStackTrace();
   //        } catch(ClassNotFoundException e) {
   //            e.printStackTrace();
   //        } catch( FileNotFoundException e) {//e=..
   //            e.printStackTrace();
   //        }
   
   //        2. 多个异常一次捕获，多次处理。//jdk1.7
             try {
                 method();
                 method2();
                 method3();
             } catch(  ClassNotFoundException | IOException e) {
                 e.printStackTrace();//一次处理
             }
   
             //注意事项,//1.7才开始,要求多个异常类型只能是平级关系,不能是字父类,父类接收子类,子类多余的
   
   ////        3. 多个异常一次捕获一次处理。
   //          try {
   //              method();
   //              method2();
   //              method3();
   //          } catch(Exception e) {
   //              e.printStackTrace();
   //          }
   
           //1.多个异常分别处理。
   //        try {
   //            method();
   //        } catch (FileNotFoundException e) {
   //            e.printStackTrace();
   //        }
   //        try {
   //            method2();
   //        } catch (ClassNotFoundException e) {
   //            e.printStackTrace();
   //        }
   //        try {
   //            method3();
   //        } catch (IOException e) {
   //            e.printStackTrace();
   //        }
   //
   //        System.out.println("后续代码");
       }
   
       public static void method() throws FileNotFoundException{//三个编译时异常,必须处理
           //throw new FileNotFoundException();
       }
   
       public static void method2() throws ClassNotFoundException{
   
       }
   
       public static void method3() throws IOException{
   
       }
   }
   ~~~

   

一般我们是使用一次捕获多次处理方式，格式如下：

~~~java
try{
     编写可能会出现异常的代码
}catch(异常类型A  e){  当try中出现A类型异常,就用该catch来捕获.
     处理异常的代码
     //记录日志/打印异常信息/继续抛出异常
}catch(异常类型B  e){  当try中出现B类型异常,就用该catch来捕获.
     处理异常的代码
     //记录日志/打印异常信息/继续抛出异常
}
//记录日志/打印异常信息/继续抛出异常===========课堂代码============================================
import java.io.FileNotFoundException;
public class Test05 {
    public static void main(String[] args) {//jvm,中断,后续不走,类型,原因,位置
//        try {// 当产生异常时，必须有处理方式。要么捕获，要么声明。
//            read("b.txt");
//        } catch (FileNotFoundException e) {// 括号中需要定义什么呢？
//            //try中抛出的是什么异常，在括号中就定义什么异常类型
//            System.out.println(e);
//        }
//        System.out.println("over");

        try {
            read("b.txt");//中断了,下面代码不走,alt enter,修正代码
        } catch (FileNotFoundException e) {//e = new FileNotFoundException("文件不存在");e对象名
            e.printStackTrace();//红色东西,问题类型,原因,位置,处理了,打印异常信息
//            System.out.println(e.toString());//java.io.FileNotFoundException: 文件不存在
//            System.out.println(e);//java.io.FileNotFoundException: 文件不存在
//            System.out.println(e.getMessage());//文件不存在
            // //记录日志/打印异常信息/继续抛出异常//待会说
            //System.out.println("异常发生了");//日志
            //继续抛出异常对象
            //throw new FileNotFoundException("文件找不到");//编译时异常
            //throw  new  RuntimeException(e);//运行时,可选处理,e编译时异常,变成运行时异常,异常转义
        }

        System.out.println("后续代码");
    }
    /*
     *
     * 我们 当前的这个方法中 有异常  有编译期异常
     */
    public static void read(String path)  throws FileNotFoundException{
        if (!path.equals("a.txt")) {//如果不是 a.txt这个文件
            // 我假设  如果不是 a.txt 认为 该文件不存在 是一个错误 也就是异常  throw
            throw new FileNotFoundException("文件不存在");//对象,一个问题
        }
    }
}
~~~

> 注意:这种异常处理方式，要求多个catch中的异常不能相同，并且若catch中的多个异常之间有子父类异常的关系，那么子类异常要求在上面的catch处理，父类异常在下面的catch处理
>
> ```java
> try {
>     method();
>     method2();
>     method3();
> } catch( IOException e) {//父类,写catch里面的异常不能是后面异常的父类,FileNotFoundException也是IOException可以,把父类异常接收了
>     e.printStackTrace();
> }catch(ClassNotFoundException e) {
>     e.printStackTrace();
> }catch(FileNotFoundException e) {//子类,报错
>     e.printStackTrace();
> }
> ```
>
> 

## 2.4 finally 代码块,跟try或者trycatch组合用的,不能单独使用,最终的,里面的代码永远都会执行,除非你在它之前退出Java虚拟机,用这行代码,System.exit(0);,程序立马停止,后面的代码不走

**finally**：有一些特定的代码无论异常是否发生，都需要执行。另外，因为异常会引发程序跳转，导致有些语句执行不到。而finally就是解决这个问题的，在finally代码块中存放的代码都是一定会被执行的。

什么时候的代码必须最终执行？

当我们在try语句块中打开了一些物理资源(磁盘文件/网络连接/数据库连接等),我们都得在使用完之后,最终关闭打开的资源。

finally的语法:

 try...catch....finally:自身需要处理异常,最终还得关闭资源。

> 注意:finally不能单独使用。

比如在我们之后学习的IO流中，当打开了一个关联文件的资源，最后程序不管结果如何，都需要把这个资源关闭掉。

finally代码参考如下：

~~~java
public class TryCatchDemo4 {
    public static void main(String[] args) {
        try {
            read("a.txt");
        } catch (FileNotFoundException e) {
            //抓取到的是编译期异常  抛出去的是运行期 
            throw new RuntimeException(e);
        } finally {
            System.out.println("不管程序怎样，这里都将会被执行。");
        }
        System.out.println("over");
    }
    /*
     *
     * 我们 当前的这个方法中 有异常  有编译期异常
     */
    public static void read(String path) throws FileNotFoundException {
        if (!path.equals("a.txt")) {//如果不是 a.txt这个文件 
            // 我假设  如果不是 a.txt 认为 该文件不存在 是一个问题 也就是异常  throw
            throw new FileNotFoundException("文件不存在");
        }
    }
}
~~~

> 当只有在try或者catch中调用退出JVM的相关方法,此时finally才不会执行,否则finally永远会执行。

## 2.5   异常注意事项//面试,选择题,记忆

* 运行时异常被抛出(throw异常对象)可以不处理。即不捕获(trycatch)也不声明(throws)抛出。
* 如果父类抛出了多个异常,子类覆盖父类方法时,只能抛出相同的异常或者是他的子集。//
* 父类方法没有抛出异常，子类覆盖父类该方法时也不可抛出异常。此时子类产生该异常，只能捕获处理，不能声明抛出//
* 当多异常处理时，捕获处理，前边的类不能是后边类的父类
* 在try/catch后可以追加finally代码块，其中的代码一定会被执行，通常用于资源回收(一定要做事情)。
* 如果finally有return语句,永远返回finally中的结果,避免该情况. //

~~~java
public class Test09 {
    public static void main(String[] args) {
        //如果finally有return语句,永远返回finally中的结果,避免该情况
        int i = method();
        System.out.println(i);//30
    }

    public static int method() {
        int num = 10;

        try {
            System.out.println(10/0);
            return num;//return记录方法的返回键(死),return之前会看看没有finally(最后一口气),有就执行里面的代码
        } catch(Exception e) {
            System.exit(0);
            num = 20;
            return num;//20
        }finally {
            num = 30;
            return num;//你最终调用了那个块里面的return,方法的结果返回值就是哪个快里面后面的return的值
        }
    }
}
~~~



# 第三章 自定义异常//就是自己写的异常(一类事物类,希望成为异常的一种,继承,谁是谁的一种,做法继承异常类,并且调用父类有参构造方法传入异常信息,在需要的用到的地方抛出子类对象即可)//记忆!

## 3.1 概述

**为什么需要自定义异常类:(因为api提供的异常类是有限的,所以要写自己的异常类,来满足具体的细致的需求)**

我们说了Java中不同的异常类,分别表示着某一种具体的异常情况,那么在开发中总是有些异常情况是SUN没有定义好的,此时我们根据自己业务的异常情况来定义异常类。,例如年龄负数问题,考试成绩负数问题。

在上述代码中，发现这些异常都是JDK内部定义好的，但是实际开发中也会出现很多异常,这些异常很可能在JDK中没有定义过,例如年龄负数问题,考试成绩负数问题.那么能不能自己定义异常呢？//继承,谁是谁的一种

**什么是自定义异常类:**

在开发中根据自己业务的异常情况来定义异常类.

自定义一个业务逻辑异常: **LoginException**。一个登陆异常类。

**异常类如何定义:**

1. 自定义一个编译期异常: 自定义类 并继承于`java.lang.Exception`。
2. 自定义一个运行时期的异常类:自定义类 并继承于`java.lang.RuntimeException`。

## 3.2 自定义异常的练习

要求：我们模拟登陆操作，如果用户名已存在，则抛出异常并提示：亲，该用户名已经被注册。

首先定义一个登陆异常类LoginException：

~~~java
// 业务逻辑异常
public class LoginException extends Exception {
    /**
     * 空参构造
     */
    public LoginException() {
    }

    /**
     *
     * @param message 表示异常提示
     */
    public LoginException(String message) {
        super(message);
    }
}
~~~

模拟登陆操作，使用数组模拟数据库中存储的数据，并提供当前注册账号是否存在方法用于判断。

~~~java
public class Demo {
    // 模拟数据库中已存在账号
    private static String[] names = {"bill","hill","jill"};
   
    public static void main(String[] args) {     
        //调用方法
        try{
              // 可能出现异常的代码
            checkUsername("nill");
            System.out.println("注册成功");//如果没有异常就是注册成功
        }catch(LoginException e){
            //处理异常
            e.printStackTrace();
        }
    }

    //判断当前注册账号是否存在
    //因为是编译期异常，又想调用者去处理 所以声明该异常
    public static boolean checkUsername(String uname) throws LoginException{
        for (String name : names) {
            if(name.equals(uname)){//如果名字在这里面 就抛出登陆异常
                throw new LoginException("亲"+name+"已经被注册了！");
            }
        }
        return true;
    }
}

public class Test07 {
    public static void main(String[] args) throws Exception{
        Person p = new Person();
        p.setAge(-18);//年龄为负数,问题,抛出去,处理

        System.out.println(p.getAge());
    }
}

class Person {
    String name;
    int age;//18

    public Person() {
    }

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) throws Exception{
        if (age<0){
            //问题,抛出去,处理
//            throw new Exception("年龄为负数,不合理"+age);//编译时异常,必须
            throw new AgeException("年龄为负数,不合理"+age);//编译时异常,必须
        }

        this.age = age;
    }
}

//年龄为负数,都叫编译时异常,把异常细化,自己写,自己定义,年龄为负数异常,也是异常,成为异常类,用继承,谁是谁的一种
//一类事物写一个类来模拟,年龄为负数异常,写一个异常类,继承,谁是谁的一种
class AgeException extends Exception{
    //new Exception("年龄为负数,不合理"+age);//编译时异常,必须
    //super("年龄为负数,不合理"+age);//异常信息,要子类调用父类有参的构造方法,alt insert

    public AgeException() {
    }

    public AgeException(String message) {
        super(message);
    }
}
~~~

#  第四章 多线程

**进程**:进行中的程序

**线程**:进程中的执行路径(**执行路径,能做事情的地方,通道,路径**)

**多线程:进程中有多条执行路径,我就可以做多个事情(一条执行路径,可以执行或者说做一个事情)**

我们在之前，学习的程序在没有跳转语句的前提下，都是由上至下依次执行，那现在想要设计一个程序，边打游戏边听歌，怎么设计？

要解决上述问题,咱们得使用多进程或者多线程来解决.

## 4.1 并发与并行,并行是同时进行,并发是切换进行,有时间间隔

* **并行**：指两个或多个事件在**同一时刻**发生（同时发生）。(说白了,并行就是多个事情同时进行,需要多核(多个)CPU,一个CPU在执行一个事情同时,另外一个cpu在同时执行另外的事情!!!)
* **并发**：指两个或多个事件在**同一个时间段内**发生。(说白了,并发,发,发作是需要时间的,不是同时进行,cpu一行执行那个事情,一会执行另外的事情,由于CPU切换的非常快,你看起来以为是同时进行,但其实并不是!!!)

![](img\并行与并发.bmp)

在操作系统中，安装了多个程序，并发指的是在一段时间内宏观上(你看起来)有多个程序同时运行，这在**单 CPU** 系统中，每一时刻只能有一道程序执行，即微观上这些程序是分时的交替运行，只不过是给人的感觉是同时运行，那是因为分时交替运行的时间是非常短的。//并发

而在多个 CPU 系统中，则这些可以并发执行的程序便可以分配到多个处理器上（CPU），实现多任务并行执行，即利用每个处理器来处理一个可以并发执行的程序，这样多个程序便可以同时执行。目前电脑市场上说的多核 CPU，便是多核处理器，核 越多，并行处理的程序越多，能大大的提高电脑运行的效率。//并行

> 注意：单核处理器的计算机肯定是不能并行的处理多个任务的，只能是多个任务在**单个CPU上并发**运行。同理,线程也是一样的，从宏观角度上理解线程是并行运行的，但是从微观角度上分析却是串行运行的，即一个线程一个线程的去运行，当系统只有一个CPU时，线程会以某种顺序执行多个线程，我们把这种情况称之为线程调度(CPU的切换一会执行这个一会执行那个,切换非常快)。

## 4.2 线程与进程相关一些概念,了解性内容,以后面试时再看看即可

* **进程**：是指一个内存中运行的应用程序，每个进程都有一个独立的内存空间，一个应用程序可以同时运行多个线程；进程也是程序的一次执行过程，是系统运行程序的基本单位；系统运行一个程序即是一个进程从创建、运行到消亡的过程。
* **线程**：进程内部的一个独立执行单元(路径)；一个进程可以同时并发的运行多个线程，可以理解为一个进程便相当于一个单 CPU 操作系统，而线程便是这个系统中运行的多个任务。

我们可以在电脑底部任务栏，右键----->打开任务管理器,可以查看当前任务的进程和线程：

**进程**

![](img\进程概念.png)

**线程**

![](img\线程概念.png)

**进程与线程的区别**

* 进程：有独立的内存空间，进程中的数据存放空间（堆空间和栈空间）是独立的，至少有一个线程。
* 线程：**堆空间是共享的**，栈空间是独立的，**线程消耗的资源比进程小的多。**

 **注意：**

1. 因为一个进程中的多个线程是并发运行的，那么从微观角度看也是有先后顺序的，哪个线程执行完全取决于 CPU 的调度，程序员是干涉不了的。而这也就造成的多线程的随机性。
2. Java 程序的进程里面至少包含两个线程，主进程也就是 main()方法线程，另外一个是垃圾回收机制线程。每当使用 java 命令执行一个类时，实际上都会启动一个 JVM程序，每一个 JVM 实际上就是在操作系统中启动了一个进程，java 本身具备了垃圾的收集机制，所以在 Java 运行时至少会启动两个线程。
3. 由于创建一个线程的开销比创建一个进程的开销小的多，那么我们在开发多任务运行的时候，通常考虑创建多线程，而不是创建多进程。

**线程调度:**

计算机通常只有一个CPU时,在任意时刻只能执行一条计算机指令,每一个线程只有获得CPU的使用权才能执行指令。所谓多线程并发运行,从宏观上看,其实是各个线程轮流获得CPU的使用权,分别执行各自的任务。那么,在可运行池中,会有多个线程处于就绪状态等待CPU,JVM就负责了线程的调度。JVM采用的是**抢占式调度**,没有采用分时调度,因此可以能造成多线程执行结果的的随机性。



## 4.3 创建线程类对象,调用方法,开启新线程做事情(start-run)

## 线程是一类事物,写类来模拟,Thread线程类,里面有线程相关功能

Java使用`java.lang.Thread`类代表**线程**，所有的线程对象都必须是Thread类或其子类的实例。每个线程的作用是完成一定的任务，实际上就是执行一段程序流即一段顺序执行的代码。Java使用**线程执行体**来代表这段程序流。Java中通过继承Thread类来**创建**并**启动多线程**的步骤如下：

1. 定义Thread类的子类，并重写该类的run()方法，该run()方法的方法体就代表了线程需要完成的任务,因此把run()方法称为**线程执行体**。
2. 创建Thread子类的实例对象，即创建了线程对象
3. 调用线程对象的start()方法来启动该线程,底层会帮我们调用重写的run方法,做事情

代码如下：

测试类：

~~~java
public class Demo01 {
	public static void main(String[] args) {
		//创建自定义线程对象
		MyThread mt = new MyThread("新的线程！");
		//开启新线程
		mt.start();
        
		//在主方法中执行for循环
		for (int i = 0; i < 10; i++) {
			System.out.println("main线程！"+i);
		}
	}
}
~~~

自定义线程类：

~~~java
public class MyThread extends Thread {
	//定义指定线程名称的构造方法
	public MyThread(String name) {
		//调用父类的String参数的构造方法，指定线程的名称
		super(name);
	}
	/**
	 * 重写run方法，完成该线程执行的逻辑
	 */
	@Override
	public void run() {
		for (int i = 0; i < 10; i++) {
			System.out.println(getName()+"：正在执行！"+i);
		}
	}
}

public class Test08 {
    public static void main(String[] args) {
        //线程是一类事物,用类来模拟,线程类,Thread,创建对象名
//        Thread t = new Thread();
//        t.start();//线程开启需要一定时间,底层调用run方法,理解线程就是一辆汽车,开启,运行

        MyThread son = new MyThread();
        son.start();//线程开启了,就近原则,子类有就走子类的,做事情
    }
}

//写一个类成为Thread类的子类,因为Thread类里面run方法根本没做什么事情,我要重写run方法做我想要做的事情
class MyThread extends Thread {//继承,谁是谁的一种
    @Override
    public void run() {
        System.out.println(666);
    }
}
~~~

OK 相信我们都看到多线程的现象了，那么接下来几天我们就进入多线程的世界！
