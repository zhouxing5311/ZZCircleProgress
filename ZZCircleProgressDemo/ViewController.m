//
//  ViewController.m
//  ZZCircleProgressDemo
//
//  Created by iMac on 2016/12/23.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import "ViewController.h"
#import "ZZCircleProgress.h"
#import "ZZCACircleProgress.h"

#define ZZRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController
{
    ZZCircleProgress *circle1;
    ZZCircleProgress *circle2;
//    ZZCircleProgress *circle3;
//    ZZCircleProgress *circle4;
    
    ZZCACircleProgress *circle3;
    ZZCACircleProgress *circle4;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initCircles];
    
}

//初始化
- (void)initCircles {
    
    CGFloat xCrack = ([UIScreen mainScreen].bounds.size.width-150*2)/3.0;
    CGFloat yCrack = ([UIScreen mainScreen].bounds.size.height-150*2)/3.0;
    CGFloat itemWidth = 150;
    
#pragma drawRect实现方式
    //默认状态
    circle1 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle1.progress = 0.6;
    [self.view addSubview:circle1];
    
    //无小圆点、同动画时间
    circle2 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack*2+itemWidth, yCrack, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle2.showPoint = NO;
    circle2.animationModel = CircleIncreaseSameTime;
    circle2.progress = 0.6;
    [self.view addSubview:circle2];
    
//    //自定义起始角度、自定义小圆点、动画从上次数值开始
//    circle3 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
//    circle3.reduceValue = 30;
//    circle3.increaseFromLast = YES;
//    circle3.pointImage = [UIImage imageNamed:@"test_point"];
//    circle3.progress = 0.6;
//    [self.view addSubview:circle3];
//    
//    //同动画时间、隐藏文字
//    circle4 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack*2+itemWidth, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
//    circle4.animationModel = CircleIncreaseSameTime;
//    circle4.showProgressText = NO;
//    circle4.progress = 0.3;
//    [self.view addSubview:circle4];
    
    
    
#pragma 核心动画实现方式
    //自定义起始角度、自定义小圆点
    circle3 = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
    circle3.reduceAngle = 30;
    circle3.increaseFromLast = YES;
    circle3.pointImage.image = [UIImage imageNamed:@"test_point"];
    circle3.duration = 1.5;//动画时长
    circle3.prepareToShow = YES;//设置好属性，准备好显示了，显示之前必须调用一次
    
    circle3.progress = 0.6;
    [self.view addSubview:circle3];
    
    //隐藏文字
    circle4 = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(xCrack*2+itemWidth, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle4.showProgressText = NO;
    circle4.duration = 1.0;//动画时长
    
    circle4.prepareToShow = YES;//设置好属性，准备好显示了，显示之前必须调用一次
    circle4.progress = 0.3;
    
    [self.view addSubview:circle4];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    circle1.progress = arc4random()%101/100.0;
    circle2.progress = arc4random()%101/100.0;
    circle3.progress = arc4random()%101/100.0;
    circle4.progress = arc4random()%101/100.0;
}


@end
