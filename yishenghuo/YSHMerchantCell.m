//
//  YSHMerchantCell.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-19.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHMerchantCell.h"

@implementation YSHMerchantCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _detail.preferredMaxLayoutWidth = CGRectGetWidth(self.frame)-CGRectGetMinX(_detail.frame)-8;
}

@end
