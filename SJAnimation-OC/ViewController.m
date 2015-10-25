//
//  ViewController.m
//  SJAnimation-OC
//
//  Created by shejun.zhou on 15/10/25.
//  Copyright © 2015年 shejun.zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *basicView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawCustomLayer];
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

- (void)drawCustomLayer {
    CGFloat width = 60.0f;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CALayer *subLayer = [[CALayer alloc] init];//创建子layer
    subLayer.backgroundColor = [UIColor orangeColor].CGColor;//设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    subLayer.position = CGPointMake(size.width/2.0, size.height/2.0);//设置中心点
    subLayer.bounds = CGRectMake(0, 0, width, width);//设置大小
    subLayer.cornerRadius = width/2.0;//设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    subLayer.shadowColor = [UIColor grayColor].CGColor;//设置阴影
    subLayer.shadowOffset = CGSizeMake(2, 2);//设置阴影偏移量
    subLayer.shadowOpacity = 0.8f;//设置阴影透明度
    [self.view.layer addSublayer:subLayer];
}

@end
