//
//  ZQPickViewController.h
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQPickViewController : UIViewController

typedef void(^SelectedCallBack)(ZQPickViewController *pickViewController, NSInteger index);
/** 初始化 */
+ (instancetype)initWithTitleButton:(UIButton *)titleButton titleList:(NSArray <NSString *> *)titleList;
/** 圆角 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 底部试图的高 */
@property (nonatomic, assign) CGFloat backViewHeight;
/** 底部试图的颜色 */
@property (nonatomic, strong) UIColor *backViewColor;
/** 选中的回调 */
- (void)selectedCallBack:(SelectedCallBack)callBack;
/** 显示 */
- (void)show;
/** 隐藏 */
- (void)hidden;
/**
 返回一个带箭头的按钮

 @param title 标题
 @param frame 坐标
 @return 按钮
 */
+ (UIButton *)arrowButtonWithTitle:(NSString *)title frame:(CGRect)frame;
/**
 xib设置的button可以调用以下方法设置箭头图片

 @param button 传入按钮
 */
+ (void)addArrowImageView:(UIButton *)button;
@end
