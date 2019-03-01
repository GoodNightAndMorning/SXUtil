//
//  SXAttribute.m
//  SXUtil
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "SXAttribute.h"

@interface SXAttribute()
@property(nonatomic,strong)NSMutableAttributedString *attrStr;
@end

@implementation SXAttribute
-(instancetype)initWithMutableAttributeString:(NSMutableAttributedString *)attrStr {
    self = [super init];
    if (self) {
        self.attrStr = attrStr;
    }
    return self;
}
-(void (^)(NSAttributedStringKey _Nonnull, id _Nonnull, NSRange))add {
    __weak typeof(self) weakSelf = self;
    void (^block)(NSAttributedStringKey _Nonnull, id _Nonnull, NSRange) = ^(NSAttributedStringKey key, id value ,NSRange range) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.attrStr addAttribute:key value:value range:range];
    };
    
    return block;
}
@end
