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

#pragma mark - size
- (UIImage *)resizableImage {
    CGSize imageSize = self.size;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageSize.height / 2, imageSize.width / 2, imageSize.height / 2, imageSize.width / 2)];
}

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





//+ (UIImage *)drawRectWithSize:(CGSize)size text:(NSString *)text{
//    
//    
//    return [UIImage defaultAvatar];

    /*
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);

    
    CGFloat index = arc4random_uniform(5);
    if (index < 1) {
        [WWJColor(201, 198, 299) set];
    }else if (index < 2){
        [WWJColor(138, 175, 190) set];
    }else if (index < 3){
        [WWJColor(151, 218, 211) set];
    }else if (index < 4){
        [WWJColor(155, 194, 211) set];
    }else{
        [WWJColor(251, 201, 138) set];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:text];
    if (string.length > 2) {
        [string deleteCharactersInRange:NSMakeRange(0, string.length - 2)];
    }
    
    
    UIFont *font = [UIFont systemFontOfSize:(size.height / 2) - 2];
    CGSize fontSize = CGSizeMake([string sizeWithFont:font
                                              maxSize:CGSizeMake(MAXFLOAT, font.lineHeight)].width,
                                 font.lineHeight);
    
    [string drawAtPoint:CGPointMake((size.width - fontSize.width) / 2, (size.height - fontSize.height) / 2)
         withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    */
//}




+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
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
    UIImage *scaleImage = [self scaleImage:self toScale:sale];
    
    NSData *scaleImageData = UIImageJPEGRepresentation(scaleImage, 1.0);
    
    return [UIImage imageWithData:scaleImageData];
}

#pragma mark- 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize,image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize + 1, image.size.height *scaleSize + 1)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (UIImage *)cutImageWithRadius:(CGFloat)radius
{
    
//    UIGraphicsBeginImageContext(self.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2);
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGRect rect = CGRectMake(radius, radius, self.size.width - radius * 2.0f, self.size.height - radius * 2.0f);
//    CGContextAddEllipseInRect(context, rect);
//    CGContextClip(context);
//    
//    [self drawInRect:rect];
//    CGContextAddEllipseInRect(context, rect);
//    CGContextStrokePath(context);
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newimg;
    
    
    UIGraphicsBeginImageContext(self.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    CGFloat x1 = 0.;
    CGFloat y1 = 0.;
    CGFloat x2 = x1+self.size.width;
    CGFloat y2 = y1;
    CGFloat x3 = x2;
    CGFloat y3 = y1+self.size.height;
    CGFloat x4 = x1;
    CGFloat y4 = y3;
    radius = radius*2;
    
    CGContextMoveToPoint(gc, x1, y1+radius);
    CGContextAddArcToPoint(gc, x1, y1, x1+radius, y1, radius);
    CGContextAddArcToPoint(gc, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(gc, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(gc, x4, y4, x4, y4-radius, radius);
    
    
    CGContextClosePath(gc);
    CGContextClip(gc);
    
    CGContextTranslateCTM(gc, 0, self.size.height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    
    
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
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
