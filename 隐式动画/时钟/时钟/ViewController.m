//
//  ViewController.m
//  时钟
//
//  Created by niuwan on 16/8/5.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "ViewController.h"

#define kClockW _clokV.bounds.size.width

// 一秒钟秒针转6°
#define perSecondA 6

// 一分钟分针转6°
#define perMinuteA 6


// 一小时时针转30°
#define perHourA 30

// 每分钟时针转多少度
#define perMinuteHourA 0.5

#define angle2radion(a) ((a) / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clokV;

/**  秒针  */
@property (nonatomic, weak) CALayer *secondLayer;
/**  分针  */
@property (nonatomic, weak) CALayer *minuterLayer;
/**  时针  */
@property (nonatomic, weak) CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //时针
    [self setupHourLayer];
    
    //分针
    [self setupMinuteLayer];
    
    //秒针
    [self setupSecondLayer];
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [self timeChange];
    
}

- (void)timeChange {
    
    //获取系统时间
    
    //当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [NSDate date];
    //时间单元
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:date];
    
    //秒数
    NSInteger second = cmp.second;
    
    //分数
    NSInteger minuter = cmp.minute;
    
    //时数
    NSInteger hour = cmp.hour;
    
    //秒针转动的度数
    CGFloat secondA = second * perSecondA;
    
    //分针转动的度数
    CGFloat minuterA = minuter * perMinuteA;
    
    //时针转动的度数
    CGFloat hourA = hour * perHourA + minuter * perMinuteHourA;
    
    //旋转秒针
    self.secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    //旋转分针
    self.minuterLayer.transform = CATransform3DMakeRotation(angle2radion(minuterA), 0, 0, 1);
    
    //旋转时针
    self.hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
    
}

#pragma mark - 时针
- (void)setupHourLayer {

    _hourLayer = [self crearLayer];
    
    _hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    _hourLayer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 40);
    
    [self.clokV.layer addSublayer:_hourLayer];
}
#pragma mark - 分针
- (void)setupMinuteLayer {
    
    _minuterLayer = [self crearLayer];
    
    _minuterLayer.backgroundColor = [UIColor blackColor].CGColor;
    _minuterLayer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    
    [self.clokV.layer addSublayer:_minuterLayer];
    
}
#pragma mark - 秒针
- (void)setupSecondLayer {
    
    _secondLayer = [self crearLayer];
    
    [self.clokV.layer addSublayer:_secondLayer];
    
}


#pragma mark - layer
- (CALayer *)crearLayer {

    CALayer *layer = [CALayer layer];
    
    layer.backgroundColor = [[UIColor redColor] CGColor];
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    
    //设置position
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 2, kClockW * 0.5 - 20);
    
    
    return layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
