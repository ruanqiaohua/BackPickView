//
//  ZQPickViewController.h
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQPickViewController : UIViewController

+ (instancetype)initWithTitleButton:(UIButton *)titleButton titleList:(NSArray <NSString *> *)titleList;

- (void)setBottonViewHeight:(CGFloat)height;

- (void)show;

@end
