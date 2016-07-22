//
//  ZSBezierPath.m
//  画板
//
//  Created by leotao on 16/7/21.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ZSBezierPath.h"

@implementation ZSBezierPath

+(instancetype)paintLineWithWidth:(CGFloat)lineWidth color:(UIColor *)lineColor startPoint:(CGPoint)startPoint{

    ZSBezierPath *path = [[self alloc] init];
    path.lineWidth = lineWidth;
    path.lineColor = lineColor;
    [path moveToPoint:startPoint];
    return  path;
}

@end
