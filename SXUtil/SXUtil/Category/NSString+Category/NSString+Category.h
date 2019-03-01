//
//  NSString+Category.h
//  SXUtil
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SXAttribute;

@interface NSString (Category)

/**
 添加富文本属性

 @param block block
 @return NSMutableAttributedString
 */
-(NSMutableAttributedString *)addAttribute:(void(^)(SXAttribute *attribute))block;
/**
 是否全是数字
 
 @return 是否是数字
 */
- (BOOL)isAllNumber;

//判断全字母：
- (BOOL)isAllLetter;

//判断仅输入字母或数字：
- (BOOL)inputShouldLetterOrNum;

//判断全汉字
- (BOOL)inputShouldChinese;

/**
 验证身份证合法性
 
 @return 是否合法
 */
- (BOOL)judgeselfValid;
/**
 检验银行卡的合法性
 
 @param cardNo 银行卡
 @return 是否合理
 */
+ (BOOL)checkBankCardNo:(NSString*)cardNo;


/**
 是否是合法的手机号
 
 @param mobile 手机号
 @return 是否合法
 */
+ (BOOL)valiMobile:(NSString *)mobile;
@end

