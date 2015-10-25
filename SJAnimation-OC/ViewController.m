//
//  ViewController.m
//  SJAnimation-OC
//
//  Created by shejun.zhou on 15/10/25.
//  Copyright © 2015年 shejun.zhou. All rights reserved.
//

#import "ViewController.h"
#import "SJView.h"

/** @name 获取屏幕 宽度、高度 及 状态栏 高度 */
// @{
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// @}end of 获取屏幕 宽度、高度 及 状态栏 高度

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *basicView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self drawCustomLayer];
//    [self drawIconLayer];
    SJView *sjView = [[SJView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    sjView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sjView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    CALayer *layer=[self.view.layer.sublayers lastObject];
    layer.position=[touch locationInView:self.view];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CALayer *layer=[self.view.layer.sublayers lastObject];
    layer.position=[touch locationInView:self.view];
}

- (IBAction)tappedButtonAction:(id)sender {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basicAnimation.duration = 0.5;
    basicAnimation.repeatCount = 1;
    basicAnimation.autoreverses = YES;
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    basicAnimation.toValue = [NSNumber numberWithFloat:1.2];
    [self.basicView.layer addAnimation:basicAnimation forKey:nil];
}

/** 在根图层上添加一个图层 */
- (void)drawCustomLayer {
    CGFloat width = 60.0f;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CALayer *subLayer = [[CALayer alloc] init];//自定义图层
    subLayer.backgroundColor = [UIColor orangeColor].CGColor;//设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    subLayer.position = CGPointMake(size.width/2.0, size.height/2.0);//设置中心点
    subLayer.bounds = CGRectMake(0, 0, width, width);//设置大小
    subLayer.cornerRadius = width/2.0;//设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    subLayer.shadowColor = [UIColor grayColor].CGColor;//设置阴影
    subLayer.shadowOffset = CGSizeMake(2, 2);//设置阴影偏移量
    subLayer.shadowOpacity = 0.8f;//设置阴影透明度
    [self.view.layer addSublayer:subLayer];//添加图层到根图层
}

CGFloat iconHeight = 200.0f;
/** 在根图层上添加一个图像图层 */
- (void)drawIconLayer {
    
    CGRect bounds = CGRectMake(0, 0, iconHeight, iconHeight);
    CGPoint position = CGPointMake(SCREEN_WIDTH/2.0, 150);
    CGFloat cornerRadius = iconHeight/2.0;
    CGFloat borderWidth = 2;
    
    //阴影图层，将图像图层添加到阴影图层，再将阴影图层添加到根图层，这样移动阴影图层时图像图层也会一起移动
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = bounds;
    layerShadow.position = position;
    layerShadow.cornerRadius = cornerRadius;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = borderWidth;
    
    //图像图层
    CALayer *iconLayer = [[CALayer alloc] init];//自定义图层
    iconLayer.bounds = bounds;
    iconLayer.position = CGPointMake(iconHeight/2, iconHeight/2);
    iconLayer.backgroundColor = [UIColor orangeColor].CGColor;
    iconLayer.cornerRadius = cornerRadius;
    iconLayer.masksToBounds = YES;
    iconLayer.borderColor = [UIColor orangeColor].CGColor;
    iconLayer.borderWidth = 2.f;
    iconLayer.delegate = self;
//    iconLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    UIImage *image = [UIImage imageNamed:@"IMG_0508"];
//    [iconLayer setContents:(id)image.CGImage];
    [iconLayer setValue:@M_PI forKeyPath:@"transform.rotation.x"];

    [iconLayer setNeedsDisplay];//调用图层setNeedDisplay,否则代理方法不会被调

    [layerShadow addSublayer:iconLayer];
    [self.view.layer addSublayer:layerShadow];
}

#pragma mark - 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -iconHeight);
    
    UIImage *image = [UIImage imageNamed:@"IMG_0508"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, iconHeight, iconHeight), image.CGImage);//注意这个位置是相对于图层而言的不是屏幕
    CGContextRestoreGState(ctx);
}

@end
