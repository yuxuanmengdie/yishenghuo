//
//  YSHDatePickerViewController.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonActionBlock)(int num);

@interface YSHDatePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *topSepView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSepHeight;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;


@property (copy, nonatomic) ButtonActionBlock buttonActionBlock;

- (IBAction)leftBtnAction:(id)sender;

- (IBAction)rightBtnAction:(id)sender;


@end
