//
//  ZQPickViewController.m
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ZQPickViewController.h"

#define space 4

@interface ZQPickViewController ()

@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, copy) SelectedCallBack selectedCallBack;

@end

@implementation ZQPickViewController

+ (instancetype)initWithTitleButton:(UIButton *)titleButton titleList:(NSArray<NSString *> *)titleList {
    
    ZQPickViewController *pickVC = [[ZQPickViewController alloc] init];
    pickVC.view.backgroundColor = [UIColor clearColor];

    NSString *titleButtonText = titleButton.titleLabel.text;
    
    pickVC.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pickVC.titleButton.frame = titleButton.frame;
    pickVC.titleButton.backgroundColor = titleButton.backgroundColor;
    [pickVC.titleButton setTitle:titleButtonText forState:UIControlStateNormal];
    [pickVC.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pickVC.titleButton addTarget:pickVC action:@selector(pickTitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickVC.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [pickVC.view addSubview:pickVC.titleButton];
    
    pickVC.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"botton"]];
    pickVC.arrowImageView.center = CGPointMake(CGRectGetWidth(pickVC.titleButton.frame)-20, CGRectGetHeight(pickVC.titleButton.frame)/2);
    [pickVC.titleButton addSubview:pickVC.arrowImageView];
    
    pickVC.scorllView = [[UIScrollView alloc] initWithFrame:pickVC.titleButton.frame];
    pickVC.scorllView.backgroundColor = [UIColor colorWithRed:0.99 green:0.50 blue:0.15 alpha:1.00];
    pickVC.scorllView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [pickVC.view insertSubview:pickVC.scorllView atIndex:0];
    
    pickVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    int i = 0;
    CGFloat width = CGRectGetWidth(pickVC.scorllView.frame);
    CGFloat height = CGRectGetHeight(pickVC.scorllView.frame);
    for (NSString *title in titleList) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        CGFloat topHeight = height+space;
        CGFloat buttonHeight = (height-2*space);
        button.frame = CGRectMake(6, topHeight+(6+buttonHeight)*i, width-12, buttonHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:pickVC action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = floorf(CGRectGetHeight(button.frame)/2);
        button.layer.masksToBounds = YES;
        [pickVC.scorllView addSubview:button];
        
        if ([title isEqualToString:titleButtonText]) {
            button.backgroundColor = [UIColor colorWithRed:0.99 green:0.66 blue:0.16 alpha:1.00];
        }
        i++;
    }
    pickVC.scorllView.contentSize = CGSizeMake(1, (i+1)*height);
    
    // default values
    if (titleList.count > 3) {
        [pickVC setBackViewHeight:height*4];
    } else {
        [pickVC setBackViewHeight:height*(titleList.count+1)];
    }
    [pickVC setCornerRadius:floorf(height/2)];
    return pickVC;
}

+ (UIButton *)arrowButtonWithTitle:(NSString *)title frame:(CGRect)frame {
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = frame;
    titleButton.backgroundColor = [UIColor colorWithRed:0.99 green:0.66 blue:0.16 alpha:1.00];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    titleButton.layer.cornerRadius = floorf(CGRectGetHeight(frame)/2);
    titleButton.layer.masksToBounds = YES;

    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"botton"]];
    arrowImageView.center = CGPointMake(CGRectGetWidth(titleButton.frame)-20, CGRectGetHeight(titleButton.frame)/2);
    [titleButton addSubview:arrowImageView];

    return titleButton;
}

- (void)setBackViewHeight:(CGFloat)backViewHeight {
    
    self.defaultHeight = backViewHeight;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.scorllView.layer.cornerRadius = cornerRadius;
    self.scorllView.layer.masksToBounds = YES;
    self.titleButton.layer.cornerRadius = cornerRadius;
    self.titleButton.layer.masksToBounds = YES;
}

- (void)setBackViewColor:(UIColor *)backViewColor {
    
    self.scorllView.backgroundColor = backViewColor;
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:NO completion:^{
        
        self.titleButton.selected = YES;
        [self pickTitleBtnAction:self.titleButton];
    }];
}

- (void)hidden {
    
    if (self.titleButton.selected) {
        
        [self hiddenScrollView:^{
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }

}

#pragma mark - Animation

- (void)hiddenScrollView:(void(^)())completion {
    
    CGRect frame = self.scorllView.frame;
    frame.size.height = CGRectGetHeight(self.titleButton.frame);
    [UIView animateWithDuration:0.2 animations:^{
        self.scorllView.frame = frame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
    self.arrowImageView.image = [UIImage imageNamed:@"botton"];
}

- (void)showScrollView:(void(^)())completion {
    
    CGRect frame = self.scorllView.frame;
    frame.size.height = self.defaultHeight;
    [UIView animateWithDuration:0.2 animations:^{
        self.scorllView.frame = frame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
    self.arrowImageView.image = [UIImage imageNamed:@"top"];
}

#pragma mark - UIButton

- (void)pickTitleBtnAction:(UIButton *)sender {
    
    if (sender.selected) {
        [self showScrollView:nil];
    } else {
        [self hiddenScrollView:nil];
        [self hidden];
    }
    sender.selected = !sender.selected;
}

- (void)buttonAction:(UIButton *)sender {
    
    [self.titleButton setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    if (self.selectedCallBack) {
        self.selectedCallBack(self,sender.tag);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    if (self.view == touch.view) {
        [self hidden];
    }
}

- (void)selectedCallBack:(SelectedCallBack)callBack {
    
    if (callBack) {
        self.selectedCallBack = callBack;
    }
}

@end
