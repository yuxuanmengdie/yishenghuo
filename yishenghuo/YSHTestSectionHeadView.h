//
//  YSHTestSectionHeadView.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RightBtnActionBlock)(void);

@interface YSHTestSectionHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)rightBtnAction:(id)sender;

@property (copy, nonatomic) RightBtnActionBlock rightBtnActionBlock;

@end
