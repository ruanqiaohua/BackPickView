//
//  ZQPickButton.h
//  IQEQOnline
//
//  Created by 阮巧华 on 2017/5/22.
//  Copyright © 2017年 iqeq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQPickButton : UIControl

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL imageViewIsHidden;

- (void)setImageViewHidden;

@end
