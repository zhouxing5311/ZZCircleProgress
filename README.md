# ZZCircleProgress

<p>
<img src="ZZCircleProgress_logo.png" title="ZZCircleProgress_logo" float=left>
</p>

[![Language](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)
![Pod Version](https://img.shields.io/cocoapods/v/ZZCircleProgress.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/ZZCircleProgress.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/ZZCircleProgress.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`ZZCircleProgress` 是一款可以高度自定义的环形进度条。你能看到的任何地方都可以进行自定义，包括圆环的开始角度、缺少角度、以及动画时长、动画刷新方式等等。而且相关的属性设置支持动态化，你可以在进度条加载完成之后随时更改他们的属性。

## 最近更新
* 2019.03.01：解决`initWithFrame: pathBackColor: pathFillColor: startAngle: strokeWidth:`方法设置pathBackColor、pathFillColor方法失效问题。
* 2019.01.08：解决自动布局下进度条大小展示异常的问题；去除prepareToShow属性；代码整理优化。

## 特点

- [x] 可以自定义所有东西。
- [x] 采用`CAAnimation`方式实现进度动画，保证了进度条的性能及流畅度。
- [x] 设置开始角度及减少角度时直接传入对应的角度即可(0-360)，无需进行转换。
- [x] 可以在进度条初始化完成之后再次更改进度条的起始角度等属性。
- [x] 可以通过storyboard、xib及纯代码方式加载。
- [x] 支持cocoapods。
- [x] 支持iOS7.0及之后的版本。

## 安装方式

### 通过CocoaPods。
```
pod 'ZZCircleProgress'
```
或
```
pod 'ZZCircleProgress', '~> 0.2.1'
```
由于上传到CocoaPods没多久。可能需要`pod setup`初始化一下。


## 使用方法

### 通过storyboard或xib方式加载。
拖入一个UIView到故事板中，并指定Class为`ZZCircleProgress`即可。

### 纯代码方式加载。
```objective-c
ZZCircleProgress *progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(100, 100, 100, 100) pathBackColor:[UIColor lightGrayColor] pathFillColor:[UIColor redColor] startAngle:0 strokeWidth:20];
[self.view addSubview:progressView];
```

初始化提供了设置坐标、线条背景色、线条填充色、开始角度及线条宽度的方法。可以设置相关属性如下。

```objective-c
progressView.reduceAngle = 30;//整合进度条缺少30度
progressView.pointImage.image = [UIImage imageNamed:@"test"];//设置小圆点图片
progressView.duration = 2.0;//动画时长。默认为1.5
progressView.showPoint = NO;//是否显示默认小圆点。默认为YES
progressView.showProgressText = NO;//是否显示默认进度文本。默认为YES
progressView.increaseFromLast = YES;//进度条动画是否从上次进度开始动画。默认为NO
progressView.progressLabel......//progressLabel集成自UILabel。属性随意设置
```

## 效果展示

![image](https://github.com/zhouxing5311/ZZCircleProgress/blob/master/ZZCircleProgress_demo.gif) 


## 更新历史:
* 2019.01.08：解决自动布局下进度条大小展示异常的问题；去除prepareToShow属性；代码整理优化。
* 2018.05.26：解决iOS10以下设备可能报错的问题。frameInterval和preferredFramesPerSecond进行版本判断。
* 2018.05.16：发布0.1.0版本及0.2.0版本到cocoapods。(0.1.0版本包括以前draw rect实现的进度条)
* 2018.03.09：ZZCACircleProgress支持属性动态修改，具体实例见demo，ZZCircleProgress增加动画时长属性。
* 2017.11.24：懒加载提前调用问题修复
* 2017.08.30：修复xib方式导入不显示的问题


## 问题反馈

如果使用过程发现什么问题可以随时联系我QQ：1098660224，微信：zhouxing5311或提issues。



