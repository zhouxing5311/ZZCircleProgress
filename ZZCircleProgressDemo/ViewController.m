//
//  ViewController.m
//  ZZCircleProgressDemo
//
//  Created by iMac on 2016/12/23.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import "ViewController.h"
#import "ZZCircleProgress.h"
#import "Masonry.h"

@interface ViewController ()

@property (strong, nonatomic) ZZCircleProgress *progressView;


@property (weak, nonatomic) IBOutlet UILabel *startAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reduceAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *strokeWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加进度条frame
//    [self addProgressViewByFrame];
    
    //2.添加进度条autolayout
    [self addProgressViewByAutoLayout];
}

//frame
- (void)addProgressViewByFrame {
    self.progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-240)/2.0, 42, 240, 240) pathBackColor:[UIColor lightGrayColor] pathFillColor:[UIColor redColor] startAngle:0 strokeWidth:10];
    [self.view addSubview:self.progressView];
}

//autolayout
- (void)addProgressViewByAutoLayout {
    self.progressView = [[ZZCircleProgress alloc] init];
    self.progressView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.progressView];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(42);
        make.left.mas_equalTo(self.view).offset(120);
        make.right.mas_equalTo(self.view).offset(-120);
        make.bottom.mas_equalTo(self.view.mas_top).offset(300);
    }];
}


//改变开始角度
- (IBAction)startAngleChanged:(UISlider *)sender {
    
    self.progressView.startAngle = sender.value;
    self.startAngleLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

//改变减少角度
- (IBAction)reduceAngleChanged:(UISlider *)sender {
    
    self.progressView.reduceAngle = sender.value;
    self.reduceAngleLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

//改变线宽
- (IBAction)srokeWidthChanged:(UISlider *)sender {
    
    self.progressView.strokeWidth = sender.value;
    self.strokeWidthLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

//改变动画时长
- (IBAction)animationDurationChanged:(UISlider *)sender {
    
    self.progressView.duration = sender.value;
    self.durationLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
}


//是否显示圆点
- (IBAction)showPointChanged:(UISwitch *)sender {
    
    self.progressView.showPoint = sender.isOn;
}

//是否显示进度文本
- (IBAction)showTextChanged:(UISwitch *)sender {
    
    self.progressView.showProgressText = sender.isOn;
}

//进度是否从头开始
- (IBAction)increaseFromLastChanged:(UISwitch *)sender {
    
    self.progressView.increaseFromLast = sender.isOn;
}

//生成随机进度
- (IBAction)createProgress:(id)sender {
    
    self.progressView.progress = arc4random()%101/100.0;
    
    //随机填充色
    self.progressView.pathFillColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
}

@end
