//
//  KSWaveAnimationV.m
//  KSWaveAnimation
//
//  Created by 康帅 on 17/2/21.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSWaveAnimationV.h"

typedef NS_ENUM(NSInteger ,KSWaveAnimationStatue) {
    KSWaveAnimationStatueRemoved,
    KSWaveAnimationStatueAnimationing,
    KSWaveAnimationStatuePaused
};

@interface KSWaveAnimationV(){
    //周期，振幅，水平移动，垂直移动
    CGFloat cycle,amplitude,offsetX,offsetY;
}
@property(nonatomic,assign)KSWaveAnimationStatue animationStatue;
@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,assign)CGColorRef fillColor;
@end
@implementation KSWaveAnimationV
/*
 ** 构造方法
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
/*
 ** 初始化参数
 */
-(void)commonInit{
    self.backgroundColor=[UIColor whiteColor];
    self.fillColor=[UIColor redColor].CGColor;
    amplitude=70;
    cycle=1.2*M_PI/self.frame.size.width;
    offsetX=0;
    offsetY=self.frame.size.height*0.25;
//    self.fillColor=[UIColor redColor].CGColor;
    [self startWaveAnimation];
}
/*
 ** 开始执行动画
 */
-(void)startWaveAnimation{
    switch (self.animationStatue) {
        case KSWaveAnimationStatueAnimationing:
            return;
        case KSWaveAnimationStatuePaused:
            _displayLink.paused = NO;
            break;
        case KSWaveAnimationStatueRemoved:
            offsetX = 0;
            [_displayLink invalidate];
            _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkRefresh:)];
            [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            break;
        default:
            break;
    }
    self.animationStatue = KSWaveAnimationStatueAnimationing;
}
/*
 ** 暂停执行动画
 */
-(void)pauseWaveAnimation{
    if (self.animationStatue==KSWaveAnimationStatuePaused) {
        return;
    }
    _displayLink.paused = YES;
    self.animationStatue = KSWaveAnimationStatuePaused;
}
/*
 ** 移除动画，下次开始水平偏移为0，从头开始
 */
-(void)removeWaveAnimation{
    if (self.animationStatue==KSWaveAnimationStatueRemoved) {
        return;
    }
    [_displayLink invalidate];
    _displayLink = nil;
    self.animationStatue = KSWaveAnimationStatueRemoved;
}
/*
 ** 每一帧刷新动画，波浪的动画速度可以在这控制，触发drawRect方法
 */
- (void)displayLinkRefresh:(CADisplayLink *)displayLink {
    offsetX += 0.02;
    [self setNeedsDisplay];
}

/*
 ** 描绘正弦曲线
 */
-(void)drawRect:(CGRect)rect{
    UIBezierPath *path=[UIBezierPath bezierPath];
    float y = offsetY;
    [path moveToPoint:CGPointMake(0, y)];
    
    for (float roop=0.0f; roop<self.frame.size.width; roop++) {
        y = amplitude * sin(cycle * roop + offsetX) + offsetY;
        [path addLineToPoint:CGPointMake(roop, y)];
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];

    [path closePath];
    [path fill];
    _shapeLayer.path=path.CGPath;
}

#pragma 懒加载
-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer=[CAShapeLayer layer];
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}
@end
