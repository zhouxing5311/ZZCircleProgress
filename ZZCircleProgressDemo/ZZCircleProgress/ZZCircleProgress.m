//
//  ZZCircleProgress.m
//  ZZCircleProgressDemo
//
//  Created by 周兴 on 2018/5/16.
//  Copyright © 2018年 zhouxing. All rights reserved.
//

#import "ZZCircleProgress.h"

@interface ZZCircleProgress ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat realWidth;//实际边长
@property (nonatomic, assign) CGFloat radius;//半径
@property (nonatomic, assign) CGFloat lastProgress;/**<上次进度 0-1 */
@property (nonatomic, strong) CAAnimation *lastPointAnimation;

@end


@implementation ZZCircleProgress

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
                pathBackColor:(UIColor *)pathBackColor
                pathFillColor:(UIColor *)pathFillColor
                   startAngle:(CGFloat)startAngle
                  strokeWidth:(CGFloat)strokeWidth {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        self.pathBackColor = pathBackColor;
        self.pathFillColor = pathFillColor;
        _startAngle = ZZCircleDegreeToRadian(startAngle);
        _strokeWidth = strokeWidth;
    }
    return self;
}

//初始化数据
- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _pathBackColor = [UIColor lightGrayColor];
    _pathFillColor = [UIColor redColor];
    
    _strokeWidth = 10;//线宽默认为10
    _startAngle = ZZCircleDegreeToRadian(0);//圆起点位置
    _reduceAngle = ZZCircleDegreeToRadian(0);//整个圆缺少的角度
    
    _duration = 1.5;//动画时长
    _showPoint = YES;//小圆点
    _showProgressText = YES;//文字
    
    //初始化layer
    [self initSubviews];
}

#pragma Get
- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _backLayer.lineWidth = _strokeWidth;
        _backLayer.strokeColor = _pathBackColor.CGColor;
        _backLayer.lineCap = @"round";
    }
    return _backLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _progressLayer.lineWidth = _strokeWidth;
        _progressLayer.strokeColor = _pathFillColor.CGColor;
        _progressLayer.lineCap = @"round";
    }
    return _progressLayer;
}

- (UIImageView *)pointImage {
    if (!_pointImage) {
        _pointImage = [[UIImageView alloc] init];
        
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"ZZCircleProgress" ofType:@"bundle"]];
        _pointImage.image = [UIImage imageNamed:@"circle_point1" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    }
    return _pointImage;
}

- (ZZCountingLabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[ZZCountingLabel alloc] init];
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:22];
        _progressLabel.text = @"0%";
    }
    return _progressLabel;
}

- (CAAnimation *)pathAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = _duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:_increaseFromLast==YES?_lastProgress:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:_progress];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    return pathAnimation;
}

- (CAAnimation *)pointAnimation {
    CAKeyframeAnimation *pointAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pointAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pointAnimation.fillMode = kCAFillModeForwards;
    pointAnimation.calculationMode = @"paced";
    pointAnimation.removedOnCompletion = NO;
    pointAnimation.duration = _duration;
    pointAnimation.delegate = self;
    
    BOOL clockwise = NO;
    if (_progress<_lastProgress && _increaseFromLast == YES) {
        clockwise = YES;
    }
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_radius startAngle:_increaseFromLast==YES?(2*M_PI-_reduceAngle)*_lastProgress+_startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle)*_progress+_startAngle clockwise:!clockwise];
    pointAnimation.path = imagePath.CGPath;
    
    return pointAnimation;
}

#pragma Set
- (void)setStartAngle:(CGFloat)startAngle {
    if (_startAngle != ZZCircleDegreeToRadian(startAngle)) {
        _startAngle = ZZCircleDegreeToRadian(startAngle);
        [self setNeedsLayout];
    }
}

- (void)setReduceAngle:(CGFloat)reduceAngle {
    if (_reduceAngle != ZZCircleDegreeToRadian(reduceAngle)) {
        if (reduceAngle>=360) {
            return;
        }
        _reduceAngle = ZZCircleDegreeToRadian(reduceAngle);
        [self setNeedsLayout];
    }
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    if (_strokeWidth != strokeWidth) {
        _strokeWidth = strokeWidth;
        _radius = _realWidth/2.0 - _strokeWidth/2.0;
        [self setNeedsLayout];
    }
}

- (void)setPathBackColor:(UIColor *)pathBackColor {
    if (_pathBackColor != pathBackColor) {
        _pathBackColor = pathBackColor;
        self.backLayer.strokeColor = _pathBackColor.CGColor;
    }
}

- (void)setPathFillColor:(UIColor *)pathFillColor {
    if (_pathFillColor != pathFillColor) {
        _pathFillColor = pathFillColor;
        self.progressLayer.strokeColor = _pathFillColor.CGColor;
    }
}

- (void)setShowPoint:(BOOL)showPoint {
    if (_showPoint != showPoint) {
        _showPoint = showPoint;
        if (_showPoint) {
            self.pointImage.hidden = NO;
            [self updatePointPosition];
        } else {
            self.pointImage.hidden = YES;
        }
    }
}

-(void)setShowProgressText:(BOOL)showProgressText {
    if (_showProgressText != showProgressText) {
        _showProgressText = showProgressText;
        if (_showProgressText) {
            self.progressLabel.hidden = NO;
        } else {
            self.progressLabel.hidden = YES;
        }
    }
}

- (void)setProgress:(CGFloat)progress {
    _progress = MAX(MIN(1, progress), 0);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}

#pragma Methods
- (void)startAnimation {
    
    [self.progressLayer addAnimation:[self pathAnimation] forKey:@"strokeEndAnimation"];
    
    if (_showPoint) {
        CAAnimation *pointAnimation = [self pointAnimation];
        [self.pointImage.layer addAnimation:pointAnimation forKey:@"pointAnimation"];
        self.lastPointAnimation = pointAnimation;
        
        if (!_increaseFromLast && _progress == 0.0) {
            [self.pointImage.layer removeAllAnimations];
        }
    }
    
    if (_showProgressText && _increaseFromLast) {
        [self.progressLabel countingFrom:_lastProgress*100 to:_progress*100 duration:_duration];
    } else if (_showProgressText) {
        [self.progressLabel countingFrom:0 to:_progress*100 duration:_duration];
    }
    
    _lastProgress = _progress;
}

- (UIBezierPath *)getNewBezierPath {
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_radius startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle+_startAngle) clockwise:YES];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && anim == [self.pointImage.layer animationForKey:@"pointAnimation"]) {
        [self updatePointPosition];
    }
}

- (void)updatePointPosition {
    CGFloat currentEndAngle = (2*M_PI-_reduceAngle)*_progress+_startAngle;
    [_pointImage.layer removeAllAnimations];
    _pointImage.center = CGPointMake(_realWidth/2.0+_radius*cosf(currentEndAngle), _realWidth/2.0+_radius*sinf(currentEndAngle));
}

#pragma initSubviews
- (void)initSubviews {
    [self.layer addSublayer:self.backLayer];
    [self.layer addSublayer:self.progressLayer];
    
    [self addSubview:self.pointImage];
    [self addSubview:self.progressLabel];
}

#pragma layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.realWidth = MIN(ZZCircleSelfWidth, ZZCircleSelfHeight);
    self.radius = _realWidth/2.0 - _strokeWidth/2.0;
    
    self.backLayer.frame = CGRectMake(0, 0, _realWidth, _realWidth);
    self.backLayer.lineWidth = _strokeWidth;
    self.backLayer.path = [self getNewBezierPath].CGPath;

    self.progressLayer.frame = CGRectMake(0, 0, _realWidth, _realWidth);
    self.progressLayer.lineWidth = _strokeWidth;
    self.progressLayer.path = [self getNewBezierPath].CGPath;
    self.progressLayer.strokeEnd = 0.0;

    self.progressLabel.frame = CGRectMake(0, 0, _realWidth, _realWidth);
    
    self.pointImage.frame = CGRectMake(0, 0, _strokeWidth, _strokeWidth);
    [self updatePointPosition];
        
}

@end
