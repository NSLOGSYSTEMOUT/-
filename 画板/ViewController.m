//
//  ViewController.m
//  画板
//
//  Created by leotao on 16/7/19.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ViewController.h"
#import "MyPaintView.h"
#import "ZSHandleImageView.h"
 
@interface ViewController ()<UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet MyPaintView *paintView;

@end

@implementation ViewController
- (IBAction)valueChangeSlider:(UISlider *)slider {
    
    self.paintView.lineWidth = slider.value;
    
}
- (IBAction)redButton:(id)sender {
    
    self.paintView.lineColor = [UIColor redColor];
}
- (IBAction)clearButton:(id)sender {
    
    [self.paintView clearScreen];
}
- (IBAction)undoButton:(id)sender {
    [self.paintView undo];
}
- (IBAction)eraserButton:(id)sender {
    
    self.paintView.lineWidth = 20;
    self.paintView.lineColor = [UIColor whiteColor];
}

//用户相册照片
- (IBAction)photoButton:(id)sender {
    
//    相片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
//    数据源
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark -- imagePickerDelegate
//选中相册图片的时候调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *photoImage = info[UIImagePickerControllerOriginalImage];
//    _paintView.image = photoImage;

    ZSHandleImageView *imageView = [[ZSHandleImageView alloc] initWithFrame:self.paintView.frame];
    
    imageView.blockImage = ^(UIImage *image){
    
        _paintView.image = image;
    };
    
    imageView.image = photoImage;
    [self.view addSubview:imageView];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)saveButton:(id)sender {
//    画板截屏
    UIGraphicsBeginImageContextWithOptions(_paintView.bounds.size, NO, 0.0);
//    获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    把画板上的内容渲染到上下文
    [_paintView.layer renderInContext:contextRef];
//    获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    关闭上下文
    UIGraphicsEndImageContext();
    
//    保存到相册中
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    if (error) {
        NSLog(@"%@失败", error);
    
    } else{
        NSLog(@"成功");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
