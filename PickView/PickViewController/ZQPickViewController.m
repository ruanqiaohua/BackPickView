//
//  ZQPickViewController.m
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ZQPickViewController.h"

#define space 4
#define titleSpace 8

@interface ZQPickViewController ()

@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, strong) ZQPickButton *titleButton;
@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, copy) SelectedCallBack selectedCallBack;
@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) UIImage *bottonImage;

@end

@implementation ZQPickViewController

+ (instancetype)initWithTitleButton:(ZQPickButton *)titleButton titleList:(NSArray<NSString *> *)titleList {
    
    ZQPickViewController *pickVC = [[ZQPickViewController alloc] init];
    pickVC.view.backgroundColor = [UIColor clearColor];

    NSString *titleButtonText = titleButton.titleLabel.text;
    
    CGRect titleButtonFrame = [titleButton.superview convertRect:titleButton.frame toView:pickVC.view];
    ZQPickButton *pickButton = [ZQPickViewController buttonWithFrame:titleButtonFrame];
    pickButton.titleLabel.font = titleButton.titleLabel.font;
    pickButton.backgroundColor = titleButton.backgroundColor;
    pickButton.titleLabel.text = titleButtonText;
    pickButton.titleLabel.textColor = titleButton.titleLabel.textColor;
    pickButton.layer.borderWidth = titleButton.layer.borderWidth;
    pickButton.layer.borderColor = titleButton.layer.borderColor;
    pickButton.imageView.image = titleButton.imageView.image;
    if (titleButton.imageViewIsHidden) {
        [pickButton setImageViewHidden];
    }
    pickVC.titleButton = pickButton;
    [pickVC.view addSubview:pickVC.titleButton];

    [pickVC.titleButton addTarget:pickVC action:@selector(pickTitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    // default image
    pickVC.bottonImage = [UIImage imageNamed:@"botton"];
    pickVC.topImage = [UIImage imageNamed:@"top"];
    
    pickVC.scorllView = [[UIScrollView alloc] initWithFrame:pickVC.titleButton.frame];
    pickVC.scorllView.backgroundColor = [UIColor colorWithRed:0.99 green:0.50 blue:0.15 alpha:1.00];
    pickVC.scorllView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [pickVC.scorllView alwaysBounceHorizontal];
    [pickVC.view insertSubview:pickVC.scorllView atIndex:0];
    
    pickVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    int i = 0;
    CGFloat width = CGRectGetWidth(pickVC.scorllView.frame);
    CGFloat height = CGRectGetHeight(pickVC.scorllView.frame);
    CGFloat topHeight = height+space;
    CGFloat buttonHeight = (height-2*space);
    for (NSString *title in titleList) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.frame = CGRectMake(6, topHeight+(2*space+buttonHeight)*i, width-12, buttonHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:titleButton.titleLabel.textColor forState:UIControlStateNormal];
        [button addTarget:pickVC action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = floorf(CGRectGetHeight(button.frame)/2);
        button.layer.masksToBounds = YES;
        [pickVC.scorllView addSubview:button];
        
        if ([title isEqualToString:titleButtonText]) {
            button.backgroundColor = titleButton.backgroundColor;
        }
        i++;
    }
    // default values
    [pickVC setBackViewHeight:height*(titleList.count+1)];
    [pickVC setCornerRadius:floorf(height/2)];
    return pickVC;
}

+ (ZQPickButton *)buttonWithFrame:(CGRect)frame {
    
    ZQPickButton *titleButton = [[ZQPickButton alloc] initWithFrame:frame];
    titleButton.backgroundColor = [UIColor colorWithRed:0.99 green:0.66 blue:0.16 alpha:1.00];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    titleButton.titleLabel.textColor = [UIColor whiteColor];
    titleButton.layer.cornerRadius = floorf(CGRectGetHeight(frame)/2);
    titleButton.layer.masksToBounds = YES;
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

- (void)setTopImageName:(NSString *)topImageName {
    
    UIImage *image = [UIImage imageNamed:topImageName];
    if (image) {
        self.topImage = image;
    }
}

- (void)setBottonImageName:(NSString *)bottonImageName {
    
    UIImage *image = [UIImage imageNamed:bottonImageName];
    if (image) {
        self.bottonImage = image;
    }
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
    _titleButton.arrowImageView.image = self.bottonImage;
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
    _titleButton.arrowImageView.image = self.topImage;
}

#pragma mark - UIButton

- (void)pickTitleBtnAction:(ZQPickButton *)sender {
    
    if (sender.selected) {
        [self showScrollView:nil];
    } else {
        [self hiddenScrollView:nil];
        [self hidden];
    }
    sender.selected = !sender.selected;
}

- (void)buttonAction:(UIButton *)sender {
    
    self.titleButton.titleLabel.text = sender.titleLabel.text;
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
