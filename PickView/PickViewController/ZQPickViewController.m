//
//  ZQPickViewController.m
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ZQPickViewController.h"

@interface ZQPickViewController ()

@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation ZQPickViewController

+ (instancetype)initWithTitleButton:(UIButton *)titleButton titleList:(NSArray<NSString *> *)titleList {
    
    ZQPickViewController *pickVC = [[ZQPickViewController alloc] init];
    
    NSString *titleButtonText = titleButton.titleLabel.text;
    
    pickVC.view.backgroundColor = [UIColor clearColor];
    pickVC.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pickVC.titleButton.frame = titleButton.frame;
    pickVC.titleButton.backgroundColor = [UIColor colorWithRed:0.99 green:0.66 blue:0.16 alpha:1.00];
    [pickVC.titleButton setTitle:titleButtonText forState:UIControlStateNormal];
    [pickVC.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pickVC.titleButton addTarget:pickVC action:@selector(pickTitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickVC.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [pickVC.view addSubview:pickVC.titleButton];
    
    pickVC.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"botton"]];
    pickVC.arrowImageView.center = CGPointMake(CGRectGetWidth(pickVC.titleButton.frame)-20, CGRectGetHeight(pickVC.titleButton.frame)/2);
    [pickVC.titleButton addSubview:pickVC.arrowImageView];
    
    pickVC.scorllView = [[UIScrollView alloc] initWithFrame:pickVC.titleButton.frame];
    pickVC.scorllView.backgroundColor = [UIColor yellowColor];
    [pickVC.view insertSubview:pickVC.scorllView atIndex:0];
    
    pickVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    int i = 1;
    CGFloat width = CGRectGetWidth(pickVC.scorllView.frame);
    CGFloat height = CGRectGetHeight(pickVC.scorllView.frame);
    for (NSString *title in titleList) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.frame = CGRectMake(0, height*i, width, height);
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:pickVC action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [pickVC.scorllView addSubview:button];
        i++;
    }
    pickVC.scorllView.contentSize = CGSizeMake(1, i*height);
    
    if (titleList.count > 3) {
        pickVC.defaultHeight = height*4;
    } else {
        pickVC.defaultHeight = height*(titleList.count+1);
    }

    return pickVC;
}

- (void)setBottonViewHeight:(CGFloat)height {
    
    
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:NO completion:^{
        
        self.titleButton.selected = YES;
        [self pickTitleBtnAction:self.titleButton];
    }];
}

- (void)hidden {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIButton

- (void)pickTitleBtnAction:(UIButton *)sender {
    
    CGRect frame = self.scorllView.frame;
    if (sender.selected) {
        
        frame.size.height = self.defaultHeight;
        [UIView animateWithDuration:0.2 animations:^{
            self.scorllView.frame = frame;
        }];
        self.arrowImageView.image = [UIImage imageNamed:@"botton"];
    } else {
        
        frame.size.height = CGRectGetHeight(sender.frame);
        [UIView animateWithDuration:0.2 animations:^{
            self.scorllView.frame = frame;
        }];
        self.arrowImageView.image = [UIImage imageNamed:@"top"];
    }
    sender.selected = !sender.selected;
}

- (void)buttonAction:(UIButton *)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    if (self.view == touch.view) {
        
        if (self.titleButton.selected) {
            
            [self pickTitleBtnAction:self.titleButton];
        }
        [self hidden];
    }
}

@end
