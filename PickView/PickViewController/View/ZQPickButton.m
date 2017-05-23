//
//  ZQPickButton.m
//  IQEQOnline
//
//  Created by 阮巧华 on 2017/5/22.
//  Copyright © 2017年 iqeq. All rights reserved.
//

#import "ZQPickButton.h"

@implementation ZQPickButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageView];
        [self arrowImageView];
        [self titleLabel];
    }
    return self;
}

#define space 2

- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat width = CGRectGetHeight(self.frame)-2*space;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(space, space, width, width)];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        CGFloat height = CGRectGetHeight(self.frame)-2*space;
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-height-2*space, space, height/2, height)];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat origin_x = CGRectGetMaxX(_imageView.frame)+space;
        CGFloat width = CGRectGetMinX(_arrowImageView.frame)-origin_x-space;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, 0, width, CGRectGetHeight(self.frame))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setImageViewHidden {
    
    _imageViewIsHidden = YES;
    CGRect frame = _titleLabel.frame;
    frame.origin.x = _imageView.frame.origin.x;
    frame.size.width += CGRectGetMaxX(_imageView.frame);
    _titleLabel.frame = frame;
}

@end
