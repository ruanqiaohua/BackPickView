//
//  UIImage+Add.m
//  IQEQOnline
//
//  Created by 阮巧华 on 2017/4/12.
//  Copyright © 2017年 iqeq. All rights reserved.
//

#import "UIImage+Add.h"

@implementation UIImage (Add)

- (instancetype)circleImage {
    
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)writeBorderCircleImage {
    
    CGFloat borderWidth = 16.0;
    UIColor *borderColor = [UIColor whiteColor];
    // 2.开启上下文
    CGFloat imageW = 200 + 2 * borderWidth;
    CGFloat imageH = 200 + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    // 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, 200, 200)];
    // 7.取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 8.结束上下文
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)writeBorderCircleImage:(CGRect)bounds borderWidth:(CGFloat)borderWidth {
    
    UIColor *borderColor = [UIColor whiteColor];
    // 2.开启上下文
    CGFloat imageW = bounds.size.width + 2 * borderWidth;
    CGFloat imageH = bounds.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    // 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, 200, 200)];
    // 7.取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 8.结束上下文
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)imageScaleToSize:(CGSize)size{
    
    // 设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (instancetype)defaultAvatar {
    
    UIImage *image = [UIImage imageNamed:@"联帮在线(TVapp)-图标-18"];
    return image;
}

+ (instancetype)backWriteImage:(CGSize)size radius:(CGFloat)radius {
    
    /*画圆角矩形*/
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat fw = size.width;
    CGFloat fh = size.height;

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, fw-radius, 0);
    CGContextAddArcToPoint(context, fw-radius, 0, fw, fh-radius, radius);
    CGContextAddArcToPoint(context, fw, radius, fw-radius, fh, radius);
    CGContextAddLineToPoint(context, 0, fh);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    // 7.取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 8.结束上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)screenshot:(UIView *)view {

    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
