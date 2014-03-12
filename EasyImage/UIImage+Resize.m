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
    
    
  CGRect  cropRect = CGRectMake(ceilf(originX * scaledImage.scale),
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

@end
