//
//  YSHTagLabelView.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-7.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHTagLabelView.h"

@implementation YSHTagLabelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        subView.tag = 500;
        subView.backgroundColor = [UIColor clearColor];
        [self addSubview:subView];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSString *svf1 = @"H:|-0-[subView]-0-|";
        NSString *svf2 = @"V:|-0-[subView]-0-|";
        NSDictionary *dic = NSDictionaryOfVariableBindings(subView,self);
        NSArray *arr1 = [NSLayoutConstraint constraintsWithVisualFormat:svf1 options:0 metrics:nil views:dic];
        NSArray *arr2 = [NSLayoutConstraint constraintsWithVisualFormat:svf2 options:0 metrics:nil views:dic];
        [self addConstraints:arr1];
        [self addConstraints:arr2];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tagView.layer.masksToBounds = YES;
    _tagView.backgroundColor = KMainColor;
    _tagView.layer.cornerRadius = _tagView.frame.size.width/2.0;
    
    _textLabel.preferredMaxLayoutWidth = _textLabel.frame.size.width;
}

@end
