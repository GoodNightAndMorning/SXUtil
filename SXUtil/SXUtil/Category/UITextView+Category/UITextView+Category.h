//
//  UITextView+Category.h
//  SXUtil
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Category)
/**
 限制输入字数
 
 @param number number
 */
-(void)limitNumberOfWords:(int)number;

/**
 设置placeholder

 @param placeholder placeholder
 */
-(void)setPlaceholder:(NSString *)placeholder;

/**
 添加右下角计数UILabel

 @param number 计数总数
 */
-(void)setNumberLabelWithNumber:(int)number;
@end

