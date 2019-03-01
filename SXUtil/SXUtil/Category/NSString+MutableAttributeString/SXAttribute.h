//
//  SXAttribute.h
//  SXUtil
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SXAttribute : NSObject
-(instancetype)initWithMutableAttributeString:(NSMutableAttributedString *)attrStr;

@property(nonatomic,copy)void (^add)(NSAttributedStringKey key, id value, NSRange range);
@end

NS_ASSUME_NONNULL_END
