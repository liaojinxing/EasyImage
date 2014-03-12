//
//  EasyImage.m
//  EasyImage
//
//  Created by liaojinxing on 14-3-6.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)scaleAndClipToFillSize:(CGSize)destSize
{
  CGFloat showWidth = destSize.width;
  CGFloat showHeight = destSize.height;
  CGFloat scaleWidth = showWidth;
  CGFloat scaleHeight = showHeight;

  scaleWidth = ceilf(scaleHeight / self.size.height * self.size.width);
  if (scaleWidth < destSize.width) {
    scaleWidth = destSize.width;
    scaleHeight = ceilf(scaleWidth / self.size.width * self.size.height);
  }

  //scale
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaleWidth, scaleHeight), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  //clip
  CGFloat originX = ceilf((scaleWidth - showWidth) / 2);
  CGFloat originY = ceilf((scaleHeight - showHeight) / 2);


  CGRect cropRect = CGRectMake(ceilf(originX * scaledImage.scale),
                               ceilf(originY * scaledImage.scale),
                               ceilf(showWidth * scaledImage.scale),
                               ceilf(showHeight * scaledImage.scale));
  return [scaledImage cropImageInRect:cropRect];
}

- (UIImage *)cropImageInRect:(CGRect)rect
{
  CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
  UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return cropImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size
{
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return scaledImage;
}

- (UIImage *)gaussianBlurWithRadius:(CGFloat)radius
{
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
  
  CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
  [filter setValue:inputImage forKey:kCIInputImageKey];
  [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
  CIImage *result = [filter valueForKey:kCIOutputImageKey];
  
  CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
  
  return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)ellipseImageWithDefaultSetting
{
  return [self ellipseImage:self
                  withInset:0
                borderWidth:0
                borderColor:[UIColor clearColor]];
}

- (UIImage *)ellipseImage:(UIImage *)image
                withInset:(CGFloat)inset
              borderWidth:(CGFloat)width
              borderColor:(UIColor *)color
{
  UIGraphicsBeginImageContext(image.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGRect rect = CGRectMake(inset,
                           inset,
                           image.size.width - inset * 2.0f,
                           image.size.height - inset * 2.0f);
  
  CGContextAddEllipseInRect(context, rect);
  CGContextClip(context);
  [image drawInRect:rect];
  
  if (width > 0) {
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, width);
    CGContextAddEllipseInRect(context, CGRectMake(inset + width / 2,
                                                  inset +  width / 2,
                                                  image.size.width - width - inset * 2.0f,
                                                  image.size.height - width - inset * 2.0f));
    
    CGContextStrokePath(context);
  }
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

@end
