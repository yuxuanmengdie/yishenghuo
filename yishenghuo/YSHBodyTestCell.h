//
//  YSHBodyTestCell.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 选项的block
 **/
typedef void(^SegmentActionBlock)(int select);

@interface YSHBodyTestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectSegmentControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)segmentAction:(id)sender;

@property (copy, nonatomic) SegmentActionBlock segmentActionBlock;
@end
