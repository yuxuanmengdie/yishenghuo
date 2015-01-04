//
//  YSHCategoryFilteView.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-3.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHCategoryFilteView.h"

@implementation YSHCategoryFilteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        
        [self addSubview:subView];
    }
    
    return self;
}


@end
