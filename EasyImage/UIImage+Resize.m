//
//  EasyImage.m
//  EasyImage
//
//  Created by liaojinxing on 14-3-6.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)fixedHeightScaleAndClipToFillSize:(CGSize)destSize
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
  CGRect cropRect;
  if (scaleWidth > showWidth) {
    CGFloat originX = ceilf((scaleWidth - showWidth) / 2);
    cropRect = CGRectMake(ceilf(originX * scaledImage.scale),
                          0,
                          ceilf(showWidth * scaledImage.scale),
                          ceilf(showHeight * scaledImage.scale));
  } else {
    CGFloat height = scaleWidth / showWidth * showHeight;
    cropRect = CGRectMake(0,
                          0,
                          ceilf(scaleWidth * scaledImage.scale),
                          ceilf(height * scaledImage.scale));
  }
  return [scaledImage cropImageInRect:cropRect];
}

- (UIImage *)fixedWidthScaleAndClipToFillSize:(CGSize)destSize
{
  CGFloat scaleWidth = destSize.width;
  CGFloat scaleHeight = 0;
  scaleHeight = ceilf(scaleWidth / self.size.width * self.size.height);
  
  if (scaleHeight < destSize.height) {
    scaleHeight = destSize.height;
    scaleWidth = ceilf(scaleHeight / self.size.height * self.size.width);
  }
  
  //scale
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaleWidth, scaleHeight), NO, 0.0f);
  [self drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  //clip center
  CGFloat originX = ceilf((scaleWidth - destSize.width) / 2);
  CGFloat originY = ceilf((scaleHeight - destSize.height) / 2);
  CGRect cropRect = CGRectMake(originX,
                               originY,
                               ceilf(destSize.width * scaledImage.scale),
                               ceilf(destSize.height * scaledImage.scale));
  return [scaledImage cropImageInRect:cropRect];
}

- (UIImage *)cropImageInRect:(CGRect)rect
{
  CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
  UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return cropImage;
}

@end
