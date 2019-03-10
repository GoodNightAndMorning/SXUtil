//
//  ViewController.m
//  SXUtil
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"
#import "SXCategoryHeader.h"
@interface ViewController ()

@end
CGFloat const Width = 10;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 30)];
    [self.view addSubview:lb];
    
    NSString *str = @"积分外面佛哦我就没干嘛";
    
    lb.attributedText = [str addAttribute:^(SXAttribute *attribute) {
        attribute.add(NSForegroundColorAttributeName, UIColor.redColor, NSMakeRange(0, 5));
        attribute.add(NSFontAttributeName, [UIFont systemFontOfSize:20], NSMakeRange(0, 5));
    }];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 100, self.view.frame.size.width - 40, 30)];
    tf.font = [UIFont systemFontOfSize:16];
    tf.placeholder = @"请输入";
    [self.view addSubview:tf];
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width - 40, 80)];
    [tv setPlaceholder:@"请输入标题"];
    [tv setNumberLabelWithNumber:50];
    tv.font = [UIFont systemFontOfSize:16];
//    tv.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:tv];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 300, 300)];
    imageView.backgroundColor = UIColor.orangeColor;
    
    imageView.image = [[UIImage imageNamed:@"pic"] circle];
    
    [self.view addSubview:imageView];
    
//    [tf removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
