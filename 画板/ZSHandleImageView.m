//
//  ZSHandleImageView.m
//  画板
//
//  Created by leotao on 16/7/22.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ZSHandleImageView.h"

@interface ZSHandleImageView ()<UIGestureRecognizerDelegate>

@property(nonatomic, weak)UIImageView *imageView;

@end

@implementation ZSHandleImageView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addImageView];
        
//        添加手势
        [self addGesture];
    }
    
    return self;
}

-(void)addImageView{
    
    UIImageView *imageView  = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    _imageView = imageView;
    [self addSubview:imageView];
    
    [self addPin];
    [self addRotaion];
}

#pragma mark 手势
#pragma mark longGesture
-(void)addGesture{
    
//长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
   
    [_imageView addGestureRecognizer:longPress];
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress{

    if (longPress.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.5 animations:^{
        
            _imageView.alpha = 0.3;
        } completion:^(BOOL finished) {
           
            [UIView animateWithDuration:0.5 animations:^{
               
                _imageView.alpha = 1;
            } completion:^(BOOL finished) {
               
//                截屏
                //    画板截屏
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
                //    获取上下文
                CGContextRef contextRef = UIGraphicsGetCurrentContext();
                //    把画板上的内容渲染到上下文
                [self.layer renderInContext:contextRef];
                //    获取新的图片
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

//                图片传给控制器
                _blockImage(newImage);
//                销毁移除控制器
                [self removeFromSuperview];
            }];
        }];
        
        
    }
}

#pragma mark UIPinchGestureRecognizer
-(void)addPin{

    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pin.delegate = self;
    [_imageView addGestureRecognizer:pin];
}

-(void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

#pragma mark rotation
-(void)addRotaion{
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate =self;
    [_imageView addGestureRecognizer:rotation];
}
-(void)rotation:(UIRotationGestureRecognizer *)rotation{

    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotation.rotation);
    rotation.rotation = 0;
}


#pragma mark 支持多种手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)setImage:(UIImage *)image{

    _image = image;
    _imageView.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
