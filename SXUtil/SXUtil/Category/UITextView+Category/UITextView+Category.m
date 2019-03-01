//
//  UITextView+Category.m
//  SXUtil
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "UITextView+Category.h"
#import <objc/runtime.h>

static const char * NumberLb_Key = "numberLb_key";
static const char * Placeholder_Key = "placeholder_key";
@implementation UITextView (Category)

/**
 限制输入字数
 
 @param number number
 */
-(void)limitNumberOfWords:(int)number{
    if (self.text.length > number) {
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) {
            return;
        }
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:number];
        self.text = [self.text substringToIndex:range.location];
    }
}
/**
  设置placeholder
  
  @param placeholder placeholder
  */
-(void)setPlaceholder:(NSString *)placeholder {
    
    UILabel *property = objc_getAssociatedObject(self, &Placeholder_Key);
    if (property) {
        property.text = placeholder;
        [property sizeToFit];
        return;
    }
    
    property = [[UILabel alloc] init];
    objc_setAssociatedObject(self, &Placeholder_Key, property, OBJC_ASSOCIATION_RETAIN);
    
    property.frame = CGRectMake(10, 10, 10, 10);
    property.font = self.font;
    property.textColor = [UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1];
    property.text = placeholder;
    [property sizeToFit];
    
    [self addSubview:property];
    
    //监听textView键盘输入变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
    [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
}
/**
 添加右下角计数UILabel
 
 @param number 计数总数
 */
-(void)setNumberLabelWithNumber:(int)number {
    
    UILabel * property = objc_getAssociatedObject(self, &NumberLb_Key);
    
    if (property) {
        return;
    }
    property = [[UILabel alloc] init];
    objc_setAssociatedObject(self, &NumberLb_Key, property, OBJC_ASSOCIATION_RETAIN);

    property.textColor = [UIColor colorWithRed:99/255 green:99/255 blue:99/255 alpha:1];
    property.font = [UIFont systemFontOfSize:14];
    property.text = [NSString stringWithFormat:@"0/%d",number];
    [property sizeToFit];
    
    CGSize size = [property.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:property.font} context:nil].size;
    
    property.frame = CGRectMake(self.frame.size.width - size.width - 10, self.frame.size.height - size.height - 10, size.width, size.height);
    
    [self addSubview:property];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma - mark load方法重写
+(void)load {
    Method oldMethod = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method newMethod = class_getInstanceMethod([self class], @selector(newInitWithFrame:));
    method_exchangeImplementations(oldMethod, newMethod);
}
-(instancetype)newInitWithFrame:(CGRect)frame {
    
    UITextView *tv = [self newInitWithFrame:frame];
    
    //设置边距
    [tv setMargin];
    
    //监听键盘开启关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //键盘顶部添加完成按钮
    [tv p_addFinishBtn];
    
    return tv ;
}
#pragma mark - 键盘顶部添加完成按钮
-(void)p_addFinishBtn {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.5)];
    bgView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:99.0/255 green:99.0/255 blue:99.0/255 alpha:1];
    [bgView addSubview:line];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0.5, [UIScreen mainScreen].bounds.size.width, 44);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(p_clickFinishBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    self.inputAccessoryView = bgView;
}
/**
 设置边距
 */
-(void)setMargin {
    CGFloat xMargin =10;
    CGFloat yMargin = 10;
    // 使用textContainerInset设置top、left、right
    self.textContainerInset = UIEdgeInsetsMake(yMargin, xMargin, 0, xMargin);
    //当光标在最后一行时，始终显示低边距，需使用contentInset设置bottom.
    self.contentInset = UIEdgeInsetsMake(0, 0, yMargin, 0);
    //防止在拼音打字时抖动
    self.layoutManager.allowsNonContiguousLayout=NO;
}

#pragma mark - 键盘弹出自适应布局
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (!self.isFirstResponder) {
        return;
    }
    
    NSValue *value = [[aNotification userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    float keyEnd_y = [value CGRectValue].origin.y;
    float animationDuration = [[aNotification userInfo][@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    CGRect screenFrame = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    
    if (CGRectGetMaxY(screenFrame) <= keyEnd_y - 10) {
        return;
    }
    
    CGRect viewFrame = self.superview.frame;
    
    viewFrame.origin.y = (keyEnd_y - 10) - CGRectGetMaxY(screenFrame);
    
    [UIView animateWithDuration:animationDuration animations:^{
        [UIApplication sharedApplication].keyWindow.frame = viewFrame;
    }];
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    if (!self.isFirstResponder) {
        return;
    }
 
    float animationDuration = [[aNotification userInfo][@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        [UIApplication sharedApplication].keyWindow.frame = [[UIScreen mainScreen] bounds];
    }];
}
#pragma - mark 监听textView键盘输入变化
-(void)textViewTextDidChange {
    //设置placeholderLb显示与隐藏
    UILabel *placeholderLb = objc_getAssociatedObject(self, &Placeholder_Key);
    placeholderLb.hidden = self.text.length > 0;
    
    //右下角numberLb计数
    UILabel * numberLb = objc_getAssociatedObject(self, &NumberLb_Key);
    NSArray *letterArr = [numberLb.text componentsSeparatedByString:@"/"];
    numberLb.text = [NSString stringWithFormat:@"%ld/%@", self.text.length, letterArr.lastObject];
    [numberLb sizeToFit];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //设置font的时候更新placeholderLb的font
    if ([keyPath isEqualToString:@"font"]) {
        UILabel *placeholderLb = objc_getAssociatedObject(self, &Placeholder_Key);
        placeholderLb.font = change[@"new"];
        [placeholderLb sizeToFit];
    }
}
-(void)p_clickFinishBtnAction {
    [self endEditing:YES];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"font"];
}
@end
