//
//  ZSHandleImageView.h
//  画板
//
//  Created by leotao on 16/7/22.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleImageBlock)(UIImage *image);

@interface ZSHandleImageView : UIView

@property (nonatomic, strong) UIImage * image;
@property(nonatomic, copy) HandleImageBlock  blockImage;

@end
