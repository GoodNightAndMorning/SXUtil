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
@end

