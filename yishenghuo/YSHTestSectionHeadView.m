//
//  YSHTestSectionHeadView.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHTestSectionHeadView.h"

@implementation YSHTestSectionHeadView

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

- (IBAction)rightBtnAction:(id)sender {
    if (self.rightBtnActionBlock) {
        self.rightBtnActionBlock();
    }
}
@end
