# jQuery基础拓展资料

## 学习目标：

1. 能够了解扩展的层级选择器
2. 能够了解扩展的属性选择器
3. 能够了解扩展的表单选择器

# 第1章 层级选择器

## 1.1 语法

| 语法            | 解释                       |
| --------------- | -------------------------- |
| prev + next     | 获得A元素同级下一个B元素   |
| prev ~ siblings | 获得A元素同级所有后面B元素 |

## 1.2 代码

```js
//<input type="button" value=" 改变 id 为 one 的下一个 <div> 的背景色为 红色"  id="b1"/>
$("#b1").click(function(){
    $("#one+div").css("background-color","red");
});
		 
//<input type="button" value=" 改变 id 为 two 的元素后面的所有兄弟<div>的元素的背景色为 红色"  id="b2"/>
$("#b2").click(function(){
    $("#two~div").css("background-color","red");
});
```



# 第2章 属性选择器

## 2.1 语法

| 语法               | 解释                     |
| ------------------ | ------------------------ |
| [attribute!=value] | 属性不等于指定值的选择器 |
| [attribute$=value] | 属性以指定值结尾的选择器 |
| [attribute^=value] | 属性以指定值开头的选择器 |
| [attribute*=value] | 属性包含指定值的选择器   |

## 2.2 代码

```js
//<input type="button" value=" 属性title值不等于test的div元素(没有属性title的也将被选中)背景色为红色"  id="b3"/>
$("#b1").click(function(){
    $("div[title!='test']").css("background-color","red");
});

//<input type="button" value=" 属性title值 以te开始 的div元素背景色为红色"  id="b4"/>
$("#b2").click(function(){
    $("div[title^='te']").css("background-color","red");
});

//<input type="button" value=" 属性title值 以est结束 的div元素背景色为红色"  id="b5"/>
$("#b3").click(function(){
    $("div[title$='est']").css("background-color","red");
});

//<input type="button" value="属性title值 含有es的div元素背景色为红色"  id="b6"/>
$("#b4").click(function(){
    $("div[title*='es']").css("background-color","red");
});
```



# 第3章 表单选择器

## 3.1 语法

| 语法      | 解释                       |
| --------- | -------------------------- |
| :input    | 选择表单元素的选择器       |
| :text     | 选择文本输出框元素的选择器 |
| :password | 选择密码框元素的选择器     |
| :redio    | 选择单选按钮元素的选择器   |
| :checkbox | 选择复选按钮元素的选择器   |
| :submit   | 选择提交按钮元素的选择器   |
| :image    | 选择图片元素的选择器       |
| :reset    | 选择重置按钮元素的选择器   |
| :button   | 选择普通按钮元素的选择器   |
| :file     | 选择文件上传框元素的选择器 |
| :hidden   | 选择隐藏元素的选择器       |

## 3.2 代码

```js
//<input type="button" value="点击获得所用input元素" id="btn1">
$("#btn1").click(function(){
    var $inputs = $("form :input");
    $inputs.each(function(index,element){
        alert(element.type);
    });
});
//<input type="button" value="点击获得文本输出框元素的内容" id="btn2">
$("#btn2").click(function(){
    alert($("form :text").val());
});
//<input type="button" value="点击获得密码框元素的内容" id="btn3">
$("#btn3").click(function(){
    alert($("form :password").val());
});
//<input type="button" value="点击获得单选按钮元素的值" id="btn4">
$("#btn4").click(function(){
    $("form :radio").each(function(index,element){
        alert(element.value);
    });
});
//<input type="button" value="点击获得复选按钮元素的值" id="btn5">
$("#btn5").click(function(){
    $("form :checkbox").each(function(index,element){
        alert(element.value);
    });
});
//<input type="button" value="点击获得提交按钮元素的值" id="btn6">
$("#btn6").click(function(){
    alert($("form :submit").val());
});
//<input type="button" value="点击获得图片元素的src" id="btn7">
$("#btn7").click(function(){
    alert($("form :image").attr("src"));
});
//<input type="button" value="点击获得重置按钮元素的值" id="btn8">
$("#btn8").click(function(){
    alert($("form :reset").val());
});
//<input type="button" value="点击获得表单内部的普通按钮元素的值" id="btn9">
$("#btn9").click(function(){
    alert($("form :button").val());
});
//<input type="button" value="点击获得文件上传框元素的值" id="btn10">
$("#btn10").click(function(){
    alert($("form :file").val());
});
//<input type="button" value="点击获得隐藏元素的值" id="btn11">
$("#btn11").click(function(){
    alert($("form :hidden").val());
});
```



