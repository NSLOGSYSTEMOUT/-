//
//  MyPaintView.m
//  画板
//
//  Created by leotao on 16/7/19.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "MyPaintView.h"
#import "ZSBezierPath.h"

@interface MyPaintView ()

@property (nonatomic, strong) ZSBezierPath *path;

@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation MyPaintView

- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    
    return _paths;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{

    _lineWidth = 2;
}

- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}

#warning 确定起点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // 获取触摸点
    CGPoint pos = [self pointWithTouches:touches];

    // 创建路径
    ZSBezierPath *path = [ZSBezierPath paintLineWithWidth:_lineWidth color:_lineColor startPoint:pos];
//    path.lineWidth = _lineWidth;
//    path.lineColor = _lineColor;
    _path = path;
    [self.paths addObject:path];

    // 确定起点
    [path moveToPoint:pos];

    
  }


#warning 确定路径终点
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 确定终点
    [_path addLineToPoint:pos];
    
    // 重绘
    [self setNeedsDisplay];
    
}


// 把之前的全部清空 重新绘制
- (void)drawRect:(CGRect)rect
{
    if (!self.paths.count) {
        return;
    }
    // 遍历所有的路径绘制
    for (ZSBezierPath *path in self.paths) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            
            [image drawAtPoint:CGPointZero];
        } else{
            [path.lineColor set];
            
            [path stroke];

        }
        
    }
    
}

-(void)setImage:(UIImage *)image{

    _image = image;
    
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

-(void)clearScreen{

    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)undo{

    [self.paths removeLastObject];
    [self setNeedsDisplay];
}


//- (CGPoint)pointWithTouches:(NSSet *)touches
//{
//    UITouch *touch = [touches anyObject];
//    
//    return [touch locationInView:self];
//}
////-(CGPoint )pointWithTouches:(NSSet *)touches{
////
////    UITouch *touch = [touches anyObject];
////    
////    return [touch locationInView:self];
////}
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//////    创建路径
////    UIBezierPath *path = [UIBezierPath bezierPath];
////    _path = path;
//////    确定画笔的起点
////    CGPoint pointBegin = [self pointWithTouches:touches];
////    [path moveToPoint:pointBegin];
//    
//    // 创建路径
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    _path = path;
//    
//    // 获取触摸点
//    CGPoint pos = [self pointWithTouches:touches];
//    
//    // 确定起点
//    [path moveToPoint:pos];
//
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//
//    // 获取触摸点
//    CGPoint pos = [self pointWithTouches:touches];
//    
//    // 确定终点
//    [_path addLineToPoint:pos];
//    
//    // 重绘
//    [self setNeedsDisplay];
//
//}
//
//- (void)drawRect:(CGRect)rect {
//
//    for (UIBezierPath *path in self.paths) {
//        
//    }
//    
//    [_path stroke];
//}

@end
