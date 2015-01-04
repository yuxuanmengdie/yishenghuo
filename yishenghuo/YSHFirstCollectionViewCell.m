//
//  YSHFirstCollectionViewCell.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-17.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHFirstCollectionViewCell.h"

@implementation YSHFirstCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)awakeFromNib
{
    _titleLabel.preferredMaxLayoutWidth = 40;
}

@end
