//  ViewController.m
//  iOS版本时钟
//
//  Created by chenxinju on 16/3/5.
//  Copyright © 2016年 chenxinju-a2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//秒针
@property (nonatomic, weak) CALayer *scondlayer;
//分针
@property (nonatomic, weak) CALayer *Minutelayer;
//时针
@property (nonatomic, weak) CALayer *hourLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加表盘
    [self addwoch];
    //添加时针
    [self addHour];
    //添加分针
    [self addMinute];
    //添加秒针
    [self addsecond];
    //刷新秒钟的方法
    [self run];
}



//分针转动的定时器方法
- (void)run{
    
    //注册一个定时器
    [NSTimer  scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

#pragma mark - 秒调用的方法

//角度转弧度的公式
#define angle2Arc(angle) (angle * M_PI /180)
- (void)updateView{
    
    //    //获得当地时间
    //    NSDateFormatter *offdate = [[NSDateFormatter alloc]init];
    //
    //    NSDate *data = [NSDate date];
    
    //    NSLog(@"%@",data);
    //获取时间的工具类   对时间操作 比较时间 可获得时间里面任意一个
    NSCalendar *cal = [NSCalendar currentCalendar];
    //秒针转动
    NSDateComponents *comps = [cal components:kCFCalendarUnitSecond|kCFCalendarUnitMinute|kCFCalendarUnitHour fromDate:[NSDate date]];
    //旋转秒针
    CGFloat angle = comps.second *6;
    self.scondlayer.transform = CATransform3DMakeRotation(angle2Arc(angle), 0, 0, 1);
    //分针旋转 一分钟也要转6度
    CGFloat annleMiute = comps.minute *6;
    
    self.Minutelayer.transform = CATransform3DMakeRotation(angle2Arc(annleMiute), 0, 0, 1);
    //时针旋转
    //360 /12 = 30度
    //一个小时 要转 30 /60 没分钟要让时针旋转0.5度
    CGFloat anglehour = comps.hour *30;
    CGFloat angleHourMinute = comps.minute *0.5;
    anglehour = anglehour + angleHourMinute;
    self.hourLayer.transform = CATransform3DMakeRotation(angle2Arc(anglehour), 0, 0, 1);
}

//时针
- (void)addHour{
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    //设置大小
    layer.bounds = CGRectMake(0, 0, 7, 160);
    ////设置position + 和 anchorPoint
    layer.position = self.view.center;
    layer.anchorPoint = CGPointMake(0.5,1);
    //设置圆角
    //    layer.cornerRadius = 10;
    //添加
    [self.view.layer addSublayer:layer];
    self.hourLayer = layer;
}

//添加分针
- (void)addMinute{
    
    CALayer *layerMinute = [[CALayer alloc]init];
    
    layerMinute.bounds = CGRectMake(0, 0, 6, 170);
    
    layerMinute.anchorPoint = CGPointMake(0.5, 1);
    
    layerMinute.position = self.view.center;
    
    layerMinute.backgroundColor = [UIColor yellowColor].CGColor;
    
    [self.view.layer addSublayer:layerMinute];
    self.Minutelayer = layerMinute;
    
}

//添加秒针
- (void)addsecond{
    CALayer *layerMins = [[CALayer alloc]init];
    //颜色
    layerMins.backgroundColor = [UIColor redColor].CGColor;
    //位置和某点
    layerMins.anchorPoint = CGPointMake(0.5, 1);
    //设置位置
    layerMins.position = self.view.center;
    //尺寸
    layerMins.bounds = CGRectMake(0, 0, 4, 180);
    //添加
    [self.view.layer addSublayer:layerMins];
    self.scondlayer = layerMins;
}

//添加表盘
- (void)addwoch{
    CALayer *layer = [[CALayer alloc]init];
    UIImage *image = [UIImage imageNamed:@"clockBg"];
    //大小
    layer.bounds = CGRectMake(0, 0, image.size.width,image.size.height);
    //设置position + 和 anchorPoint
    layer.position = self.view.center;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    //设置图片
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    //加入到view中
    [self.view.layer addSublayer:layer];
}

@end
