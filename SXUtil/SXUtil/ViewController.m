//
//  ViewController.m
//  SXUtil
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"
#import "SXStringCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 30)];
    lb.font = [UIFont systemFontOfSize:16];
    lb.textColor = UIColor.orangeColor;
    [self.view addSubview:lb];
    
    NSString *str = @"积分外面佛哦我就没干嘛";
    
    lb.attributedText = [str addAttribute:^(SXAttribute *attribute) {
        attribute.add(NSForegroundColorAttributeName, UIColor.redColor, NSMakeRange(0, 5));
        attribute.add(NSFontAttributeName, [UIFont systemFontOfSize:20], NSMakeRange(0, 5));
    }];
}


@end
