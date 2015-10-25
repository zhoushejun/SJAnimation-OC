//
//  SJView.m
//  SJAnimation-OC
//
//  Created by shejun.zhou on 15/10/25.
//  Copyright © 2015年 shejun.zhou. All rights reserved.
//

#import "SJView.h"
#import "SJLayer.h"

@implementation SJView

-(instancetype)initWithFrame:(CGRect)frame{
    
    NSLog(@"initWithFrame:");
    if (self=[super initWithFrame:frame]) {
        SJLayer *layer=[[SJLayer alloc] init];
        layer.bounds=CGRectMake(0, 0, frame.size.width, frame.size.height);
        layer.position=CGPointMake(frame.size.width/2, frame.size.height/2);
        layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        [layer setNeedsDisplay]; //显示图层
        
        [self.layer addSublayer:layer];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
}

@end
