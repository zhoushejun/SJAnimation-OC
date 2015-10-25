//
//  SJLayer.m
//  SJAnimation-OC
//
//  Created by shejun.zhou on 15/10/25.
//  Copyright © 2015年 shejun.zhou. All rights reserved.
//

#import "SJLayer.h"

@implementation SJLayer

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"CGContext:%@", ctx);
//    CGContextRotateCTM(ctx, M_PI_4);
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
//    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
//    CGContextFillEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    
    // Star Drawing
    CGContextAddLineToPoint(ctx,104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);
    
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
