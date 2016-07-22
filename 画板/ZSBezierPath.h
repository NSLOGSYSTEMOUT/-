//
//  ZSBezierPath.h
//  画板
//
//  Created by leotao on 16/7/21.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSBezierPath : UIBezierPath

@property (nonatomic, strong) UIColor * lineColor;

+(instancetype)paintLineWithWidth:(CGFloat)lineWidth color:(UIColor *)lineColor startPoint:(CGPoint)startPoint;
@end
