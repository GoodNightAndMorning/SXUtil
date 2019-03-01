//
//  UIImage+Category.m
//  SXUtil
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

-(UIImage *)circle {
    UIImage *image = self;
    
    CGFloat length = image.size.width;
    
    if (length > image.size.height) {
        length = image.size.height;
    }
    
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(length, length), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置头像frame
  
    
    //绘制圆形头像范围
    CGContextAddArc(context, length / 2, length / 2, length / 2, 0, M_PI * 2, 0);
//    CGContextAddEllipseInRect(context, CGRectMake(0, 0, iconW, iconH));
    
    //剪切可视范围
    CGContextClip(context);
    
    CGFloat iconX = length == image.size.width ? 0 : (length - image.size.width) / 2;
    CGFloat iconY = image.size.height ? 0 : (length - image.size.height) / 2;
    CGFloat iconW = image.size.width;
    CGFloat iconH = image.size.height;
    
    //绘制头像
    [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return iconImage;
}
@end
