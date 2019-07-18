//
//  UIImage+Additions.m
//  MobileCRM
//
//  Created by wangweishun on 7/22/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import "UIImage+BaseAdditions.h"
#import <UIKit/UIGraphics.h>
@implementation UIImage (BaseAdditions)


#pragma mark - color
+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)roundedImageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [path fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size shape:(UIBezierPath *)shape {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    [shape fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)fixOrientation {

    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            case UIImageOrientationUp:
            case UIImageOrientationDown:
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(UIImage *)defultScale
{
    NSData *sendImageData = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;

    //    NSLog(@"压缩前大小：----%ld KB", sizeOriginKB);

    CGFloat sale;
    if (sizeOriginKB>=1024) {
        sale = 0.4f;
    }else if (sizeOriginKB>=800 && sizeOriginKB<1000)
    {
        sale = 0.5f;
    }else if (sizeOriginKB>=600 && sizeOriginKB<800)
    {
        sale = 0.6f;
    }else if (sizeOriginKB>=400 && sizeOriginKB<600)
    {
        sale = 0.7f;
    }else if (sizeOriginKB>=200 && sizeOriginKB<400)
    {
        sale = 0.8f;
    }else
    {
        sale = 0.9f;
    }

    //图片压缩，因为原图都是很大的，不必要传原图
    UIImage *scaleImage = [self scaleImage:sale];

    NSData *scaleImageData = UIImageJPEGRepresentation(scaleImage, 1.0);

    return [UIImage imageWithData:scaleImageData];
}


/**
 *  重设图片大小
 */
- (UIImage *)reSizeImage:(CGSize)reSize{
    if (CGSizeEqualToSize(reSize, CGSizeZero)) {
        return self;
    }
    CGSize newSize = reSize;

    CGSize drawSize;
    UIGraphicsBeginImageContext(newSize);
    if (newSize.width > newSize.height) {
        CGFloat scale = newSize.width / self.size.width;
        drawSize = CGSizeMake(newSize.width, self.size.height * scale);
    }else{
        CGFloat scale = newSize.height / self.size.height;
        drawSize = CGSizeMake(self.size.width * scale, newSize.height);
    }

    [self drawInRect:CGRectMake((newSize.width - drawSize.width) / 2,
                                (newSize.height - drawSize.height) / 2,
                                drawSize.width, drawSize.height)];

    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    if (reSizeImage == nil) {
        reSizeImage = self;
    }
    return reSizeImage;
}

/**
 *  等比率缩放
 */
- (UIImage *)scaleImage:(CGFloat)scaleSize{
    CGSize reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize);
    return [self reSizeImage:reSize];
}




@end
