//
//  UIImage+Additions.h
//  MobileCRM
//
//  Created by wangweishun on 7/22/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

@interface UIImage (BaseAdditions)

- (UIImage *)resizableImage;
+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size;
+ (UIImage *)roundedImageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size shape:(UIBezierPath *)shape;
- (UIImage *)fixOrientation;

+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

//图片默认压缩
- (UIImage *)defultScale;


/// 截取圆形图片
- (UIImage *)cutImageWithRadius:(CGFloat)radius;

/**
 *  重设图片大小
 */
- (UIImage *)reSizeImage:(CGSize)reSize;

/**
 *  等比率缩放
 */
- (UIImage *)scaleImage:(CGFloat)scaleSize;

@end
