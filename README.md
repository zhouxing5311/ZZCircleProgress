# ZZCircleProgress

draw rect实现的圆形进度条。可以使用部分圆弧当做整个进度条，并可以随意设置起始角度及减少的圆弧角度大小。

使用方法:
ZZCircleProgress拷贝至项目工程，导入ZZCircleProgress.h。
        
初始化:
1.- (instancetype)init;

2.- (instancetype)initWithFrame:(CGRect)frame;

3.//初始化 坐标 线条背景色 填充色 起始角度 线宽
  - (instancetype)initWithFrame:(CGRect)frame
        pathBackColor:(UIColor *)pathBackColor
        pathFillColor:(UIColor *)pathFillColor
           startAngle:(CGFloat)startAngle
          strokeWidth:(CGFloat)strokeWidth;
                  
效果展示:
![image](https://github.com/zhouxing5311/ZZCircleProgress/blob/master/ZZCircleProgressDemo/ZZCircleProgress.gif) 

一直想做一个实现和使用起来都比较简便的圆形进度条，但是网上一直没有找到合适的，因此打算参考别人的代码并加入自己的实现及优化，
从而实现了现在的这个圆弧形进度条。项目开发中需要一个简单的进度条，但是搜索了很多一直没有找到适合我们项目的使用情况。主要是有两点问题。

首先一个问题就是进度条的布局问题。网上找的一些实现有的必须在初始化的时候给进度条视图确定的坐标，从而才能保证布局的正确性，但是有时候我们并不能保证初始化的
时候我们就已经知道进度条的坐标，因此就十分不方便。而目前的实现方法系统通过自动调用draw rect就会知道自己的坐标变化，从而能保证坐标计算的正确性。
因此比较方便。就目前测试来看初始化的时候指定坐标或者是在之后指定坐标还是使用相对布局，暂时都没有什么问题。因此可以放心使用。

还有个问题就是网上目前大部分的圆形进度条过度追求各种样式各种功能，从而造成代码阅读起来很费劲，难以找到我们最需要的关键实现信息。而我们实际开发中可能仅仅
只需要某个简单的实现，使用时不会出现问题就好了。

实现这个进度条的目的就是给开发者们一个简单的实现实例，从而可以方便的加入自己的想法及实现。目前只是一个圆弧形进度条加上一个光标，技术难点就是每次重绘的时候
光标的位置比较难计算。要用到正弦余弦函数，然后再根据进度条半径及线宽计算出光标的x,y值。从而计算出小圆点的坐标。另一个难点就是每次重绘的时候要保证进度条和
光标保持同步，因此只好用NSTimer定时调用progress值递增并重绘方法，从而保证每次进度条和光标增量相同，实现同步动画效果。

下面是进度条实际使用的效果。
                  
