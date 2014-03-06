//
//  EasyImage.h
//  EasyImage
//
//  Created by liaojinxing on 14-3-6.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

//高度固定，等比缩放
- (UIImage *)fixedHeightScaleAndClipToFillSize:(CGSize)destSize;
//宽度固定，等比缩放
- (UIImage *)fixedWidthScaleAndClipToFillSize:(CGSize)destSize;
//截图
- (UIImage *)cropImageInRect:(CGRect)rect;

@end
