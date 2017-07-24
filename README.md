# ZZCircleProgress 基于Quartz2D和CABasicAnimation实现的带圆点圆形进度条

## ZZCircleProgress部分特点
* 通过`drawRect`以及`CALayer`结合`CABasicAnimation`、`CAKeyframeAnimation`实现的圆形进度条。
* 可以自定义圆形进度条起始角度`startAngle`和圆形进度条缺少的角度`reduceAngle`。
* 增加圆形进度条同步显示的小圆点图片`showPoint`，通过正弦余弦函数实现轨迹同步（两种方式），这个小圆点和进度条的同步显示是整个圆形进度条最麻烦的地方。
* 根据对应的进度在动画期间实时显示对应的进度百分比。`showProgressText`
* 通过两种圆形进度条的实现方式希望给大家一些启发。

## 使用方法: 
* 选取对应的实现方式文件夹内容拷贝到项目中并导入对应头文件。
        
### 初始化 

**drawRect实现**

```
ZZCircleProgress *progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectZero pathBackColor:[UIColor cyanColor] pathFillColor:[UIColor redColor] startAngle:0 strokeWidth:8];
//progressView.pathBackColor = [UIColor cyanColor];//线条背景色
//progressView.pathFillColor = [UIColor redColor];//线条填充色
//progressView.startAngle = 0;//圆弧开始角度，默认为-90°，即正上方
//progressView.reduceAngle = 0;//整个圆弧减少的角度，默认为0
//progressView.strokeWidth = 8;//线宽，默认为10
progressView.frame = CGRectMake(100, 100, 150, 150);
progressView.increaseFromLast = NO;//为YES动画则从上次的progress开始，否则从头开始，默认为NO
progressView.animationModel = CircleIncreaseSameTime;//不同的进度条动画时间相同，CircleIncreaseByProgress进度越大时间越久
progressView.showPoint = YES;//是否显示光标，默认为YES
progressView.showProgressText = NO;//是否显示进度文本，默认为YES
progressView.notAnimated = NO;//不开启动画，默认为NO
progressView.forceRefresh = YES;//是否在set的值等于上次值时同样刷新动画，默认为NO

progressView.progress = 0.5;//设置完之后给progress的值
[self.view addSubview:progressView];

```

drawRect实现方法的好处是通过调用`setNeedsDisplay`方法就可以在修改完进度条的属性之后同步到进度条上，而且涉及到的对象较少。坏处就是当界面中存在大量进度条的时候大量的重绘工作和计时器的频繁调用会对CPU和GPU的性能造成一定的影响。因此实际开发中还是应该避免频繁使用drawRect的重绘操作。


**核心动画实现**

```
ZZCACircleProgress *circle3 = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
circle3.reduceAngle = 30;
circle3.increaseFromLast = YES;
circle3.pointImage.image = [UIImage imageNamed:@"test_point"];
circle3.duration = 1.5;//动画时长
circle3.prepareToShow = YES;//设置好属性，准备好显示了，显示之前必须调用一次

circle3.progress = 0.6;

```
核心动画实现方法的好处是动画效果较drawRect实现方法实现出来的进度条动画效果更加平滑，但是在模拟器上使用`CADisplayLink`时因为模拟器的刷新率不高，所以导致每次进度文本都要落后于动画，建议在真机中测试。此方法实现的进度条要在设置完响应的属性之后调用`circle3.prepareToShow = YES;`方法才能正常显示，因为当调用prepareToShow的时候才去根据设置的属性创建相应的layer。

**PS**
核心动画实现的时候进度条路径和小圆点的同步显示搞了大半天，一直不能同步显示！一直都是动画过程中两个位置会错开，后来发现其实是小圆点的核心动画的计算方式出了问题，导致小圆点的运动并不是匀速的。通过设置关键帧动画属性`pathAnimation.calculationMode = @"paced";`问题得以解决。

### 效果展示:

![image](https://github.com/zhouxing5311/ZZCircleProgress/blob/master/ZZCircleProgress.gif) 


