//
//  MyPaintView.h
//  画板
//
//  Created by leotao on 16/7/19.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPaintView : UIView

@property(nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * lineColor;

@property (nonatomic, strong) UIImage * image;

-(void)clearScreen;
-(void)undo;

@end
