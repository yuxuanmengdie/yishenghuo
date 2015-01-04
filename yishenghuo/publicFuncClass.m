//
//  publicFuncClass.m
//  yishenghuo
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "publicFuncClass.h"

@implementation publicFuncClass


#pragma mark 添加不要备份 属性
+ (BOOL)addSkipBAckupAttributeItemAtURL:(NSURL *)URL
{
    //    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    //    static int i = 0;
    //    i++;
    //    NSLog(@"i=%d",i);
    if (![[NSFileManager defaultManager] fileExistsAtPath:[URL path]])
    {
        NSLog(@"%s,file not exsit",__func__);
        return NO;
    }
    
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    //    BOOL success = NO;
    
    if (!success)
    {
        NSLog(@"%s,faile!,error=%@",__FUNCTION__,error);
    }
    return success;
    
}

+ (UIImage *)TransformWithImage:(UIImage *)oriImage toSize:(CGSize)Newsize
{
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(Newsize);
    // 绘制改变大小的图片
    [oriImage drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return TransformedImg;
}



//修改图片的尺寸
+ (UIImage*) drawInRectImage:(UIImage*)startImage size:(CGSize)imageSize
{
    float  w = CGImageGetWidth(startImage.CGImage);
    
    float  h = CGImageGetHeight(startImage.CGImage);
    
    float wt = imageSize.width/w;
    
    float ht = imageSize.height/h;
    
    CGRect targetRect;
    
    if (wt<ht) {
        
        targetRect = CGRectMake(0, (imageSize.height-h*wt)/2, imageSize.width, h*wt);
    }else {
        
        targetRect = CGRectMake((imageSize.width-w*ht)/2, 0, w*ht, imageSize.height);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, imageSize.width, imageSize.height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    //    CGContextRef
    //    bitmap = CGBitmapContextCreate(NULL,
    //
    //
    //                                   destW,
    //
    //
    //                                   destH,
    //
    //
    //                                   CGImageGetBitsPerComponent(imageRef),
    //
    //
    //                                   4*destW,
    //
    //
    //                                   CGImageGetColorSpace(imageRef),
    //
    //
    //                                   (kCGBitmapByteOrder32Little
    //                                    | kCGImageAlphaPremultipliedFirst));
    
    
    
    
    CGContextDrawImage(context, targetRect, startImage.CGImage);
    
    CGContextSaveGState(context);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    
    UIImage* resultImage =[UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return  resultImage;
    
}

+ (UIImage *) ImageWithColor: (UIColor *) color
{
//    aFrame = CGRectMake(0, 0, aFrame.size.width, aFrame.size.height);
    //    if (CGRectEqualToRect(aFrame, CGRectZero))
    //    {
    //         aFrame =
    //    }
    
    CGRect aFrame = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




+ (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame
{
    aFrame = CGRectMake(0, 0, aFrame.size.width, aFrame.size.height);
    //    if (CGRectEqualToRect(aFrame, CGRectZero))
    //    {
    //         aFrame = CGRectMake(0, 0, 1, 1);
    //    }
    
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



#pragma mark 判断是否是邮箱
+ (BOOL)isEmaliRegex:(NSString *)email
{
    NSString *red = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", red];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

+ (void)addHiddenItemOnkeyboardWithView:(id)Responder delegate:(id)delegate sel:(SEL)method
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:delegate action:method forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateNormal];
    [btn setTitle:@"收起" forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn sizeToFit];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    @try {
        [Responder setInputAccessoryView:topView];
    }
    @catch (NSException *exception) {
        NSLog(@"%s",__PRETTY_FUNCTION__);
    }
    @finally {
        
    }
    
}


@end
