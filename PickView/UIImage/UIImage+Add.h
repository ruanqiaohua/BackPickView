//
//  UIImage+Add.h
//  IQEQOnline
//
//  Created by 阮巧华 on 2017/4/12.
//  Copyright © 2017年 iqeq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Add)

/** 圆角图片 */
- (instancetype)circleImage;
/** 白边圆角图片 */
- (instancetype)writeBorderCircleImage;
/** 默认头像 */
+ (instancetype)defaultAvatar;
+ (instancetype)backWriteImage:(CGSize)size radius:(CGFloat)radius;
+ (instancetype)screenshot:(UIView *)view;
- (instancetype)writeBorderCircleImage:(CGRect)bounds borderWidth:(CGFloat)borderWidth;
- (instancetype)imageScaleToSize:(CGSize)size;
@end
