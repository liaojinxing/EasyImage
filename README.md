
EasyImage
================

This library provides a category for UIImage with support for processing image.

It provides:
- Scale and clip image to best fill specific size.
- Crop image in a rectangle.
- Make rectangle image to ellipse, usually used to show circular avatars.
- Gaussian blur image.

If your iOS project needs to show image, use this library will reduce a lot of repetitive work.

Installation
-------------------------
Cocoapod is really great. Here is an example of your podfile:

`
    pod 'EasyImage'
`


How to use it?
--------------
This library is a category of UIImage, so UIImage instances can call the methods directly. The followings are some examples:
- Scale an image:


```
UIImage *originalImage;
UIImage *scaledImage = [originalImage scaleImageToSize:CGSizeMake(320, 480)];
```
    
- Circular avatar:

```
UIImage *rectAvatar;
UIImage *ellipseAvatar = [rectAvatar ellipseImageWithDefaultSetting];
```

Other
-----
If you like it, please star this repo, thanks. Waiting for your pull request.
