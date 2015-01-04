//
//  YSHActivityTableCell.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-16.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 点击的响应
typedef void(^TableCellSelectBlock)(void);

typedef  void(^SwitchActionBlock)(BOOL isOn);

@interface YSHActivityTableCell : UITableViewCell
{
    float oriConstant;
}

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subHead;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
- (IBAction)switchAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnTrailConstraint;

@property (copy, nonatomic) TableCellSelectBlock tableCellSelectBlock;

@property (copy, nonatomic) SwitchActionBlock switchActionBlock;

@end
