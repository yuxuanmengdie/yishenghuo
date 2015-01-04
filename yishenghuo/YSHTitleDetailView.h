//
//  YSHTitleDetailView.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHTitleDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@property (weak, nonatomic) IBOutlet UILabel *currentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;

@property (strong, nonatomic) NSLayoutConstraint *textViewHeightConstraint;
@end
