//
//  YSHTagLabelView.h
//  yishenghuo
//
//  Created by 张国俗 on 15-1-7.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHTagLabelView : UIView

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagWidthConstrait;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagTopConstraint;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end
