# day09【字节流、字符流】

## 主要内容

* IO流
* 字节流
* 字符流
* 异常处理
* Properties

## 教学目标
- [ ] 能够说出IO流的分类和功能
- [ ] 能够使用字节输出流写出数据到文件
- [ ] 能够使用字节输入流读取数据到程序
- [ ] 能够理解读取数据read(byte[])方法
- [ ] 能够使用字节流完成文件的复制
- [ ] 能够使用FileReader读数据
- [ ] 能够使用FileReader读数据一次一个字符数组
- [ ] 能够使用FileWirter写数据到文件
- [ ] 能够说出FileWriter中关闭和刷新方法的区别
- [ ] 能够使用FileWriter写数据的5个方法
- [ ] 能够使用FileWriter写数据实现换行和追加写
- [ ] 能够使用Properties的load方法加载文件中的配置信息

# 第一章 IO概述

## 1.1 什么是IO,i,input,o,output,输入输出用来传输数据的方式

生活中，你肯定经历过这样的场景。当你编辑一个文本文件，忘记了`ctrl+s` 保存,然后断电了，可能文件就白白编辑了。当你电脑上插入一个U盘，可以把一个视频，拷贝到你的电脑硬盘里。那么数据都是在哪些设备上的呢？键盘、内存、硬盘、外接设备等等。

我们把这种数据的传输，可以看做是一种数据的流动，按照流动的方向，以内存为基准，分为`输入input` 和`输出output` ，即**流向内存是输入流，流出内存的是输出流**。

Java中I/O操作,主要是指使用`java.io`包下的内容，进行输入、输出操作。**输入**也叫做**读取**数据，**输出**也叫做作**写出**数据。

## 1.2 IO的分类,(能够说出IO流的分类和功能)

按照数据的流向分为：**输入流**和**输出流**。

* **输入流** ：把数据从`其他设备`上**读取**到`内存`中的流。 //功能,读数据
* **输出流** ：把数据从`内存` 中**写**出到`其他设备`上的流。//功能,把数据写到其他地方

按照数据的类型分为：**字节流**和**字符流**。

* **字节流** ：以字节为单位，读写数据的流。
* **字符流** ：以字符为单位，读写数据的流。//字符流=字节流+码表

## 1.3 IO的流向说明图解

![](img/1_io.jpg)

## 1.4 顶级父类们,都是抽象类,用他们的子类来完成io流读写操作

|            |           **输入流**            |              输出流              |
| :--------: | :-----------------------------: | :------------------------------: |
| **字节流** | 字节输入流<br />**InputStream** | 字节输出流<br />**OutputStream** |
| **字符流** |   字符输入流<br />**Reader**    |    字符输出流<br />**Writer**    |

### 注意:一般情况下,看到类以stream结尾是字节流,以er结尾的是字符流!!!

# 第二章 字节流

## 2.1 一切皆为字节

一切文件数据(文本、图片、视频等)在存储时，都是以二进制数字的形式保存的，是一个一个字节，那么传输时一样如此。**所以，字节流可以传输任意文件数据。**在操作流的时候，我们要时刻明确，无论使用什么样的流对象，底层传输的,始终为二进制数据!!!

## 2.2 字节输出流【OutputStream】

`java.io.OutputStream `**抽象类**是表示字节输出流的所有类的超类，将指定的字节信息写出到目的地。它定义了字节输出流的基本共性功能(方法)。

* `public void close()` ：关闭此输出流,并释放与此流相关联的,任何系统资源。  内置缓冲区刷新
* `public void flush() ` ：刷新此输出流,并强制任何缓冲的输出字节被写出。  
* `public void write(byte[] b)`：将 b.length字节从指定的字节数组写入此输出流。  
* `public void write(byte[] b, int off, int len)` ：从指定的字节数组写入 len字节，从偏移量 off开始输出到此输出流。  
* `public abstract void write(int b)` ：将指定的字节写到输出流。97,码表翻译a,打开文件是a

> 小贴士：
>
> close方法，当完成流的操作时，推荐调用此方法，来释放系统资源。

## 2.3 FileOutputStream类

`OutputStream`有很多子类，我们从最简单的一个子类开始。

`java.io.FileOutputStream `类是**文件输出流，把数据写出到文件中**。

### 构造方法

* `public FileOutputStream(File file)`：创建文件输出流,以写入由指定的 File对象表示的文件。 
* `public FileOutputStream(String name)`： 创建文件输出流,以指定的名称写入文件。  

当你创建一个输出流对象写数据到文件中时，必须传入一个文件路径。输出流的构造方法，如果没有这个文件，会创建该文件。如果有这个文件，会清空这个文件的数据**(不想清空,在构造方法()里面加个逗号和true表示追加内容,不清空原来的数据)**。

* 构造举例，代码如下：

```java
public class FileOutputStreamConstructor throws IOException {
    public static void main(String[] args) {
   	 	// 使用File对象创建流对象
        File file = new File("a.txt");
        FileOutputStream fos = new FileOutputStream(file);
      
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("b.txt");
    }
}
```

### 写出字节数据,(能够使用字节输出流写出数据到文件)

1. **写出字节**：`write(int b)` 方法，每次可以写出一个字节数据，代码使用演示：

```java
public class FOSWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("fos.txt");
        
      	// 写出数据
      	fos.write(97); // 写出第1个字节
      	fos.write(98); // 写出第2个字节
      	fos.write(99); // 写出第3个字节
        
      	// 关闭资源
        fos.close();
    }
}
输出结果：//写过去的是97,经过码表翻译成a,97对应的字符是a,这个在基础班,我们已经学习过了!!!
abc
```

> 小贴士：
>
> 1. 虽然参数为int类型四个字节，但是只会保留一个字节的信息写出。
> 2. 流操作完毕后，推荐释放系统资源，调用close方法，千万记得。

2. **写出字节数组**：`write(byte[] b)`，每次可以写出数组中的数据，代码使用演示：

```java
public class FOSWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("fos.txt");    
        
      	// 字符串转换为字节数组
      	byte[] b = "黑马程序员".getBytes();
      	// 写出字节数组数据
      	fos.write(b);
        
      	// 关闭资源
        fos.close();
    }
}
输出结果：
黑马程序员
```

3. **写出指定长度字节数组**：`write(byte[] b, int off, int len)` ,每次写出从off索引开始，len个字节，代码使用演示：

```java
public class FOSWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("fos.txt");     
        
      	// 字符串转换为字节数组
      	byte[] b = "abcde".getBytes();
		// 写出从索引2开始，2个字节。索引2是c，两个字节，也就是cd。
        fos.write(b,2,2);
        
      	// 关闭资源
        fos.close();
    }
}
输出结果：
cd
```

### 数据追加续写

经过以上的演示，每次程序运行，创建输出流对象，都会清空目标文件中的数据。如何保留目标文件中数据，还能继续添加新数据呢？

- `public FileOutputStream(File file, boolean append)`： 创建文件输出流以写入由指定的 File对象表示的文件。  
- `public FileOutputStream(String name, boolean append)`： 创建文件输出流以指定的名称写入文件。  

这两个构造方法，参数中都需要传入一个boolean类型的值，`true` 表示追加数据，`false` 表示清空原有数据。这样创建的输出流对象，就可以指定是否追加续写了，代码使用演示：

```java
public class FOSWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("fos.txt"，true);   
        
      	// 字符串转换为字节数组
      	byte[] b = "abcde".getBytes();
		// 写出从索引2开始，2个字节。索引2是c，两个字节，也就是cd。
        fos.write(b);
        
      	// 关闭资源
        fos.close();
    }
}
文件操作前：cd
文件操作后：cdabcde
```

### 写出换行

Windows系统里，换行符号是`\r\n` 。代码使用演示：

```java
public class FOSWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileOutputStream fos = new FileOutputStream("fos.txt");  
        
      	// 定义字节数组
      	byte[] words = {97,98,99,100,101};
      	// 遍历数组
        for (int i = 0; i < words.length; i++) {
          	// 写出一个字节
            fos.write(words[i]);
          	// 写出一个换行, 换行符号转成数组写出
            fos.write("\r\n".getBytes());
        }
        
      	// 关闭资源
        fos.close();
    }
}

输出结果：
a
b
c
d
e
```

> * 回车符`\r`和换行符`\n` ：
>   * 回车符：回到一行的开头（return）。
>   * 换行符：下一行（newline）。
> * 系统中的换行：
>   * Windows系统里，每行结尾是 `回车+换行` ，即`\r\n`；
>   * Unix系统里，每行结尾只有 `换行` ，即`\n`；
>   * Mac系统里，每行结尾是 `回车` ，即`\r`。

## 2.4 字节输入流【InputStream】

`java.io.InputStream `**抽象类**是表示字节输入流的所有类的超类，可以读取字节信息到内存中。它定义了字节输入流的基本共性功能方法。

- `public void close()` ：关闭此输入流,并释放与此流相关联的任何系统资源。    
- `public abstract int read()`： 从输入流读取数据的下一个字节。 
- `public int read(byte[] b)`： 从输入流中读取一些字节数，并将它们存储到字节数组 b中 。

> 小贴士：
>
> close方法，当完成流的操作时，调用推荐此方法，释放系统资源。

## 2.5 FileInputStream类

`java.io.FileInputStream `类是**文件输入流，用来读取文件的**。

### 构造方法

* `FileInputStream(File file)`： 通过打开与实际文件的连接来创建一个 FileInputStream ，该文件由文件系统中的 File对象 file命名。 
* `FileInputStream(String name)`： 通过打开与实际文件的连接来创建一个 FileInputStream ，该文件由文件系统中的路径名 name命名。  

当创建一个输入流对象时，必须传入一个文件路径。该路径下，如果没有该文件,会抛出`FileNotFoundException` 

- 构造举例，代码如下：

```java
public class FileInputStreamConstructor throws IOException{
    public static void main(String[] args) {
   	 	// 使用File对象创建流对象
        File file = new File("a.txt");
        FileInputStream fos = new FileInputStream(file);
      
        // 使用文件名称创建流对象
        FileInputStream fos = new FileInputStream("b.txt");
    }
}
```

### 读取字节数据

1. **读取字节**：`read`方法，每次可以读取一个字节的数据，提升为int类型，如果读取到文件末尾，则返回`-1`表示，代码使用演示：

```java
public class FISRead {
    public static void main(String[] args) throws IOException{
      	// 使用文件名称创建流对象
       	FileInputStream fis = new FileInputStream("read.txt");
        
      	// 读取数据，返回一个字节
        int read = fis.read();
        System.out.println((char) read);
        read = fis.read();
        System.out.println((char) read);
        read = fis.read();
        System.out.println((char) read);
        read = fis.read();
        System.out.println((char) read);
        read = fis.read();
        System.out.println((char) read);
        
      	// 读取到末尾,返回-1
       	read = fis.read();
        System.out.println( read);
        
		// 关闭资源
        fis.close();
    }
}
输出结果：
a
b
c
d
e
-1
```

循环改进读取方式，代码使用演示：**(能够使用字节输入流读取数据到程序)**

```java
public class FISRead {
    public static void main(String[] args) throws IOException{
      	// 使用文件名称创建流对象
       	FileInputStream fis = new FileInputStream("read.txt");
        
      	// 定义变量，保存数据
        int b ；
        // 循环读取
        while ((b = fis.read())!=-1) {
            System.out.println((char)b);
        }
        
		// 关闭资源
        fis.close();
    }
}
输出结果：
a
b
c
d
e
```



2. **使用字节数组读取**：`read(byte[] b)`，每次读取b的长度个字节到数组中，方法的返回值,返回读取到的有效字节个数，读取到文件末尾时，返回`-1` 表示，代码使用表示演示：

```java
public class FISRead {
    public static void main(String[] args) throws IOException{
      	// 使用文件名称创建流对象.
       	FileInputStream fis = new FileInputStream("read.txt"); // 文件中为abcde
        
      	// 定义变量，作为有效个数
        int len ；
        // 定义字节数组，作为装字节数据的容器   
        byte[] b = new byte[2];
        // 循环读取
        while (( len= fis.read(b))!=-1) {
           	// 每次读取后,把数组变成字符串打印
            System.out.println(new String(b));
        }
        
		// 关闭资源
        fis.close();
    }
}

输出结果：
ab
cd
ed
```

错误数据`d`，是由于最后一次读取时，只读取一个字节`e`，数组中，上次读取的数据没有被完全替换，所以要通过`len` ，获取有效的字节，代码使用演示：

```java
public class FISRead {
    public static void main(String[] args) throws IOException{
      	// 使用文件名称创建流对象.
       	FileInputStream fis = new FileInputStream("read.txt"); // 文件中为abcde
        
      	// 定义变量，作为有效个数
        int len ；
        // 定义字节数组，作为装字节数据的容器   
        byte[] b = new byte[2];
        // 循环读取
        while (( len= fis.read(b))!=-1) {
           	// 每次读取后,把数组的有效字节部分，变成字符串打印
            System.out.println(new String(b，0，len));//  len 每次读取的有效字节个数
        }
        
		// 关闭资源
        fis.close();
    }
}

输出结果：
ab
cd
e
```

> 小贴士：
>
> 使用数组读取，每次读取多个字节，减少了系统间的IO操作次数，从而提高了读写的效率，建议开发中使用。
>
> **超级总结:不会读,记下面的!!!**
>
> 字节输入流FileInputStream读一个字节read()和读一个字节数组read(byte[] arr)方法,
>
> 有数组读取到的内容存到数组,方法的返回值表示读取到的有效字节个数,
>
> 没数组读取到的内容存到read方法的返回值,
>
> 但是只要读不到都返回-1,就可以定义变量接收read方法的返回值,循环赋值判断不等于-1就可以一直读
>
> 套路:
>
> **int ch;**
>
> **while(()!=-1){//()当成一个整体,不要漏掉里面的()括号!!!记忆!!!**
>
> **}**
>
> **字节输入流一个读一个字节和一个读一个字节数组的代码总结如下:**(**能够理解读取数据read(byte[])方法)**
>
> ~~~java
> //file,读文件,跟文件相关,字节输入流一个读一个字节数组
>         FileInputStream fis = new FileInputStream("day09\\a.txt");
>         int ch;
> 
>         byte[] arr = new byte[2];
>         while ((ch=fis.read(arr))!=-1) {//97
>             System.out.print(new String(arr,0,ch));//abc,把读取到数组的有效字节变成字符串
>         }
> 
>         fis.close();
> 
> //		 file,读文件,跟文件相关,字节输入流一个读一个字节
> //        int ch;
> //        while ((ch=fis.read())!=-1) {
> //            System.out.print((char)ch);//abc
> //        }
> //
> //        fis.close();
> ~~~
>
> 

## 2.6 字节流练习：复制,又叫拷贝,文件的读和写就是拷贝,简单

### 复制原理图解

![](img/2_copy.jpg)

### 案例实现

复制图片文件，代码使用演示：(**能够使用字节流完成文件的复制**)

```java
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Test03 {
    public static void main(String[] args) throws Exception {
        //复制,又叫拷贝,文件的读和写就是拷贝,简单a.txt//abc979899
        //一次读写一个字节的拷贝,file
//        FileInputStream fis = new FileInputStream("day09\\a.txt");
//        FileOutputStream fos = new FileOutputStream("day09\\b.txt");//输出流构造方法,没有文件创建
//
//        int ch;
//        while ((ch=fis.read())!=-1) {
//            //System.out.print(ch);/979899没有数组读到ch里面存起来
//            fos.write(ch);
//        }
//
//        fis.close();
//        fos.close();

        //一次读写一个字节数组的拷贝
        FileInputStream fis = new FileInputStream("day09\\a.txt");
        FileOutputStream fos = new FileOutputStream("day09\\c.txt");//输出流构造方法,没有文件创建

        int ch;
        byte[] arr = new byte[2];
        while ((ch=fis.read(arr))!=-1) {
            fos.write(arr, 0, ch);
        }

        fis.close();
        fos.close();
    }
}
```

> 小贴士：
>
> 流的关闭原则：先开后关，后开先关。

# 第三章 字符流,跟字节流的用法几乎一样,要注意的是字符输出流有内置数组,其他把字节换成字符用!

当使用字节流读取文本文件时，可能会有一个小问题。就是遇到中文字符时，可能不会显示完整的字符，那是因为一个中文字符,可能占用多个字节存储。所以Java提供一些字符流类，以字符为单位读写数据，专门用于处理文本文件。

## 3.1 字符输入流【Reader】

`java.io.Reader`抽象类是表示用于读取字符流的所有类的超类，可以读取字节信息到内存中。它定义了字节输入流的基本共性功能方法。

- `public void close()` ：关闭此流,并释放与此流相关联的任何系统资源。    
- `public int read()`： 从输入流读取一个字符。 
- `public int read(char[] cbuf)`： 从输入流中读取一些字符，并将它们存储到字符数组 cbuf中 。

## 3.2 FileReader类  

`java.io.FileReader `类是读取字符文件的便利类

### 构造方法

- `FileReader(File file)`： 创建一个新的 FileReader ，给定要读取的File对象。   
- `FileReader(String fileName)`： 创建一个新的 FileReader ，给定要读取的文件的名称。  

当你创建一个流对象时，必须传入一个文件路径。类似于FileInputStream 。

- 构造举例，代码如下：

```java
public class FileReaderConstructor throws IOException{
    public static void main(String[] args) {
   	 	// 使用File对象创建流对象
        File file = new File("a.txt");
        FileReader fr = new FileReader(file);
      
        // 使用文件名称创建流对象
        FileReader fr = new FileReader("b.txt");
    }
}
```

### 读取字符数据,(能够使用FileReader读数据)

1. **读取字符**：`read`方法，每次可以读取一个字符的数据，提升为int类型，读取到文件末尾，返回`-1`，循环读取，代码使用演示：

```java
public class FRRead {
    public static void main(String[] args) throws IOException {
      	// 使用文件名称创建流对象
       	FileReader fr = new FileReader("read.txt");
        
      	// 定义变量，保存数据
        int b ；
        // 循环读取
        while ((b = fr.read())!=-1) {
            System.out.println((char)b);
        }
        
		// 关闭资源
        fr.close();
    }
}
输出结果：
黑
马
程
序
员
```

> 小贴士：虽然读取了一个字符，但是会自动提升为int类型。
>

2. **使用字符数组读取**：`read(char[] cbuf)`，每次读取b的长度个字符到数组中，返回读取到的有效字符个数，读取到末尾时，返回`-1` ，代码使用演示：

```java
public class FRRead {
    public static void main(String[] args) throws IOException {
      	// 使用文件名称创建流对象
       	FileReader fr = new FileReader("read.txt");
        
      	// 定义变量，保存有效字符个数
        int len ；
        // 定义字符数组，作为装字符数据的容器
         char[] cbuf = new char[2];
        // 循环读取
        while ((len = fr.read(cbuf))!=-1) {
            System.out.println(new String(cbuf));
        }
        
		// 关闭资源
        fr.close();
    }
}
输出结果：
黑马
程序
员序
```

获取有效的字符改进，代码使用演示：**(能够使用FileReader读数据一次一个字符数组)**

```java
public class FISRead {
    public static void main(String[] args) throws IOException {
      	// 使用文件名称创建流对象
       	FileReader fr = new FileReader("read.txt");
        
      	// 定义变量，保存有效字符个数
        int len ；
        // 定义字符数组，作为装字符数据的容器
        char[] cbuf = new char[2];
        // 循环读取
        while ((len = fr.read(cbuf))!=-1) {
            System.out.println(new String(cbuf,0,len));
        }
        
    	// 关闭资源
        fr.close();
    }
}

输出结果：
黑马
程序
员
```

## 3.3 字符输出流【Writer】

**总结:**

**字符输出流有内置数组,先写到内置数组缓冲区,满了刷新到文件,**

**不满残留内置数组,文件没有,**

**要手动调用输出流的close方法,关闭流之前,刷新内置数组数据到文件中**

`java.io.Writer `抽象类是表示用于写出字符流的所有类的超类，将指定的字符信息写出到目的地。它定义了字节输出流的基本共性功能方法。

- `public abstract void close()` ：关闭此输出流,并释放与此流相关联的任何系统资源。  
- `public abstract void flush() ` ：刷新此输出流.并强制任何缓冲的输出字符被写出。  
- `public void write(int c)` ：写出一个字符。
- `public void write(char[] cbuf)`：将 b.length字符从指定的字符数组,写出此输出流。  
- `public abstract void write(char[] b, int off, int len)` ：从指定的字符数组写出 len字符，从偏移量 off开始输出到此输出流。  
- `public void write(String str)` ：写出一个字符串。//多了写直接写字符串,字节流把字符串变成字节数组写过去,调用getBytes()得到字节数组

## 3.4 FileWriter类

`java.io.FileWriter `类是写出字符到文件的便利类。构造时使用系统默认的字符编码和默认字符缓冲区。

### 构造方法

- `FileWriter(File file)`： 创建一个新的 FileWriter，给定要读取的File对象。   
- `FileWriter(String fileName)`： 创建一个新的 FileWriter，给定要读取的文件的名称。  

当你创建一个流出对象时，必须传入一个文件路径，类似于FileOutputStream。构造方法没有文件帮你创建,有文件清空,不想清空,追加,逗号,true表示追加,不清空,在后面增加

- 构造举例，代码如下：

```java
public class FileWriterConstructor {
    public static void main(String[] args) throws IOException {
   	 	// 使用File对象创建流对象
        File file = new File("a.txt");
        FileWriter fw = new FileWriter(file);
      
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("b.txt");
    }
}
```

### 写出数据,(能够使用FileWirter写数据到文件)

**写出字符**：`write(int b)` 方法，每次可以写出一个字符数据，代码使用演示：

```java
public class FWWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("fw.txt");   
        
      	// 写出数据
      	fw.write(97); // 写出第1个字符
      	fw.write('b'); // 写出第2个字符
      	fw.write('C'); // 写出第3个字符
      	fw.write(30000); // 写出第4个字符，中文编码表中30000对应一个汉字。
      
      	/*
        【注意】关闭资源时,与FileOutputStream不同。
      	 如果不关闭,数据只是保存到缓冲区数组，并未保存到文件。
        */
        // fw.close();
    }
}
输出结果：
abC田
```

> 小贴士：
>
> 1. 虽然参数为int类型四个字节，但是只会保留一个字符的信息写出。
> 2. 未调用close方法，数据只是保存到了缓冲区数组，并未写出到文件中。

### 关闭和刷新,(能够说出FileWriter中关闭和刷新方法的区别)

因为内置缓冲区数组的原因，如果不关闭输出流，无法写出字符到文件中。但是关闭的流对象，是无法继续写出数据的。如果我们既想写出数据，又想继续使用流，就需要`flush` 方法了。

* `flush` ：刷新缓冲区，流对象可以继续使用。
* `close` ：关闭流，释放系统资源。关闭前会刷新缓冲区。

代码使用演示：

```java
public class FWWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("fw.txt");
        // 写出数据，通过flush
        fw.write('刷'); // 写出第1个字符
        fw.flush();
        fw.write('新'); // 继续写出第2个字符，写出成功
        fw.flush();
      
      	// 写出数据，通过close
        fw.write('关'); // 写出第1个字符
        fw.close();
        fw.write('闭'); // 继续写出第2个字符,【报错】java.io.IOException: Stream closed
        fw.close();
    }
}
```

> 小贴士：即便是flush方法写出了数据，操作的最后还是建议要调用close方法，来释放系统资源。

### 写出其他数据,(能够使用FileWriter写数据的5个方法)

1. **写出字符数组** ：`write(char[] cbuf)` 和 `write(char[] cbuf, int off, int len)` ，每次可以写出字符数组中的数据，用法类似FileOutputStream，代码使用演示：

```java
public class FWWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("fw.txt"); 
        
      	// 字符串转换为字节数组
      	char[] chars = "黑马程序员".toCharArray();
      
      	// 写出字符数组
      	fw.write(chars); // 黑马程序员
        
		// 写出从索引2开始，2个字符。索引2是'程'，两个字符，也就是'程序'。
        fw.write(b,2,2); // 程序
      
      	// 关闭资源
        fos.close();
    }
}
```

2. **写出字符串**：`write(String str)` 和 `write(String str, int off, int len)` ，每次可以写出字符串中的数据，更为方便，代码使用演示：

```java
public class FWWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("fw.txt");     
      	// 字符串
      	String msg = "黑马程序员";
      
      	// 写出字符数组
      	fw.write(msg); //黑马程序员
      
		// 写出从索引2开始，2个字符。索引2是'程'，两个字符，也就是'程序'。
        fw.write(msg,2,2);	// 程序
      	
        // 关闭资源
        fos.close();
    }
}
```

3. **追加和换行**：操作类似于FileOutputStream。**(能够使用FileWriter写数据实现换行和追加写)**

```java
public class FWWrite {
    public static void main(String[] args) throws IOException {
        // 使用文件名称创建流对象，可以追加续写数据
        FileWriter fw = new FileWriter("fw.txt"，true); 
        
      	// 写出字符串
        fw.write("黑马");
      	// 写出换行
      	fw.write("\r\n");
      	// 写出字符串
  		fw.write("程序员");
        
      	// 关闭资源
        fw.close();
    }
}
输出结果:
黑马
程序员
```

> 小贴士：字符流，只能操作文本文件，不能操作图片，视频等非文本文件。其他图片视频音频用字节流,拷贝,秒杀,啥都可以!!!

## 字符流拷贝(文本用记事本打开看的懂文字,不包括图片音频视频),就是文件的读和写,简单,记忆,写出来

~~~java
//字符输入流跟字节输入流用法几乎一样,只不过把字节换成字符
//字符输出流,跟字节输出流不一样的地方,在于字符输出流有内置数组,先写到内置数组缓冲区,满了刷新文件,不满残留
//内置数组,文件没有,要手动调用输出流的close方法,关闭流之前,刷新内置数组数据到文件中
 //file,一次读写一个字符的拷贝
        FileReader fr = new FileReader("day09//a.txt");
        FileWriter fw = new FileWriter("day09//f.txt");//没有文件创建,输出流内置数组

        int ch;
        while ((ch=fr.read())!=-1) {
//            System.out.print((char)ch);//你好你好啊
            fw.write(ch);
        }

        fr.close();
        fw.close();//关闭,刷新,数组,文件

        //一次读写一个字符的拷贝
        FileReader fr = new FileReader("day09//a.txt");
        FileWriter fw = new FileWriter("day09//g.txt");//没有文件创建,输出流内置数组

        int ch;
        char[] arr = new char[2];
        while ((ch=fr.read(arr))!=-1) {
//            System.out.print((char)ch);//你好你好啊
            fw.write(arr,0,ch);
        }

        fr.close();
        fw.close();//关闭,刷新,数组,文件
~~~



# 第四章 IO异常的处理

### JDK7前处理

之前的入门练习，我们一直把异常抛出，而实际开发中一般并不推荐这样处理，大多数希望后续代码继续执行,建议使用`try...catch...finally` 代码块，处理异常部分，代码使用演示：

```java  
public class HandleException1 {
    public static void main(String[] args) {
      	// 声明变量
        FileWriter fw = null;
        try {
            //创建流对象
            fw = new FileWriter("fw.txt");
            // 写出数据
            fw.write("黑马程序员"); //黑马程序员
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fw != null) {//防止上面出现异常没有给fw赋值,调用close方法出现空指针异常
                    fw.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
    }
}
```

### JDK7的处理

还可以使用JDK7优化后的`try-with-resource` 语句，该语句确保了每个资源,在语句结束时关闭。所谓的资源（resource）是指在程序完成后，必须关闭的流对象。写在()里面的流对象对应的类都实现了自动关闭接口AutoCloseable

格式：

```java
try (创建流对象语句，如果多个,使用';'隔开) {
	// 读写数据
} catch (IOException e) {
	e.printStackTrace();
}
```

代码使用演示：

```java
public class HandleException2 {
    public static void main(String[] args) {
      	// 创建流对象
        try ( FileWriter fw = new FileWriter("fw.txt"); ) {
            // 写出数据
            fw.write("黑马程序员"); //黑马程序员
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### JDK9的改进(了解内容,看看就好)

JDK9中`try-with-resource` 的改进，对于**引入对象**的方式，支持的更加简洁。被引入的对象，同样可以自动关闭，无需手动close，我们来了解一下格式。

改进前格式：

```java
// 被final修饰的对象
final Resource resource1 = new Resource("resource1");
// 普通对象
Resource resource2 = new Resource("resource2");

// 引入方式：创建新的变量保存
try (Resource r1 = resource1;
     Resource r2 = resource2) {
     // 使用对象
}
```

改进后格式：

```java
// 被final修饰的对象
final Resource resource1 = new Resource("resource1");
// 普通对象
Resource resource2 = new Resource("resource2");

// 引入方式：直接引入
try (resource1; resource2) {
     // 使用对象
}
```

改进后，代码使用演示：

```java
public class TryDemo {
    public static void main(String[] args) throws IOException {
       	// 创建流对象
        final  FileReader fr  = new FileReader("in.txt");
        FileWriter fw = new FileWriter("out.txt");
       	// 引入到try中
        try (fr; fw) {
          	// 定义变量
            int b;
          	// 读取数据
          	while ((b = fr.read())!=-1) {
            	// 写出数据
            	fw.write(b);
          	}
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

# 第五章 属性的集合,简称属性集

## 5.1 概述,`Properties` 类除了原来双列集合的功能,还表示了一个持久的属性集,属性列表中每个键及其对应值都是一个字符串 ;`Properties`  可保存在流(写)中或从流中加载(读)

`java.util.Properties ` 继承于` Hashtable` ，来表示一个持久的属性集。它使用键值结构存储数据，每个键及其对应值都是一个字符串。该类也被许多Java类使用，比如获取系统属性时，`System.getProperties` 方法就是返回一个`Properties`对象。

## 5.2 Properties类,双列集合put方法

`Properties` 类表示了一个持久的属性集合(属性列表中每个键及其对应值都是一个字符串),`Properties`  可保存在流中store,或从流中加载load,Properties类,创建对象,调用方法,简单

### 构造方法

- `public Properties()` :创建一个空的属性列表。

### 基本的存储方法

- `public Object setProperty(String key, String value)` ： 保存一对属性。  
- `public String getProperty(String key) ` ：使用此属性列表中指定的键搜索属性值。
- `public Set<String> stringPropertyNames() ` ：所有键的名称的集合。

```java
public class ProDemo {
    public static void main(String[] args) throws FileNotFoundException {
        // 创建属性集对象
        Properties properties = new Properties();
        // 添加键值对元素
        properties.setProperty("filename", "a.txt");
        properties.setProperty("length", "209385038");
        properties.setProperty("location", "D:\\a.txt");
        // 打印属性集对象
        System.out.println(properties);
        // 通过键,获取属性值
        System.out.println(properties.getProperty("filename"));
        System.out.println(properties.getProperty("length"));
        System.out.println(properties.getProperty("location"));

        // 遍历属性集,获取所有键的集合
        Set<String> strings = properties.stringPropertyNames();
        // 打印键值对
        for (String key : strings ) {
          	System.out.println(key+" -- "+properties.getProperty(key));
        }
    }
}
输出结果：
{filename=a.txt, length=209385038, location=D:\a.txt}
a.txt
209385038
D:\a.txt
filename -- a.txt
length -- 209385038
location -- D:\a.txt
```

### 与流相关的方法,(能够使用Properties的load方法加载文件中的配置信息)

- `public void load(InputStream inStream)`： 从字节输入流中读取关联的文件到集合中,一般存储键值对。 

参数中使用了字节输入流，通过流对象，可以关联到某文件上，这样就能够加载文本中的数据了。文本数据格式:

```
filename=a.txt
length=209385038
location=D:\a.txt
```

加载代码演示：

```java
public class ProDemo2 {
    public static void main(String[] args) throws FileNotFoundException {
        // 创建属性集对象
        Properties pro = new Properties();
        // 加载文本中信息到属性集
        pro.load(new FileInputStream("read.txt"));
        // 遍历集合并打印
        Set<String> strings = pro.stringPropertyNames();
        for (String key : strings ) {
          	System.out.println(key+" -- "+pro.getProperty(key));
        }
     }
}
输出结果：
filename -- a.txt
length -- 209385038
location -- D:\a.txt
```

### 课堂演示代码如下==========================================================

~~~java
import java.io.FileInputStream;
import java.util.Properties;
public class Test09 {
    public static void main(String[] args) throws Exception {
        //Properties类,双列集合put方法
//        Properties p = new Properties();//p,没有泛型<>,出现比较早
//        p.put("xx", 123);//双列集合啥都可以添加,没有限定元素的数据类型
        //HashMap替代双列集合功能,特有的功能

        //Properties 类表示了一个持久的属性的集合,属性集合中每个键及其对应值都是一个字符串<String>
        Properties p = new Properties();
       // p.setProperty("password", "123");//字符串,属性,底层就put的字符串
//        String value = p.getProperty("password");//底层就是get(key),通过键得到值
//        System.out.println(value);//123
//        System.out.println(p);//{},{password=123}
//
//        //stringPropertyNames,键的集合,keySet();
//        Set<String> strings = p.stringPropertyNames();
//        for (String s : strings) {
//            System.out.println(s);//password
//        }

        //Properties可保存方法在io流中或从流中加载方法
//        System.out.println(p);//{password=123}
        //FileOutputStream fos = new FileOutputStream("day09\\data.txt");//没有文件创建
        //p.store(fos, null);//把p里面的内容通过输出流写到关联的文件data.txt;写

        //流中加载方法,读取
        FileInputStream fis = new FileInputStream("day09\\data.txt");
        p.load(fis);//通过输入流读取关联的文件,data.txt文件内存,存到p里面去
        System.out.println(p);//{}
    }
}
~~~

