//
//  YSHTitleDetailView.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHTitleDetailView.h"

@implementation YSHTitleDetailView


static const float kTextViewDefaultHeight  = 50;

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        UIView *subView =  [[[NSBundle mainBundle] loadNibNamed:@"YSHTitleDetailView" owner:self options:nil] firstObject];
        
        [self addSubview:subView];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        NSString *vfl1 = @"H:|-0-[subView]-0-|";
        NSString *vfl2 = @"V:|-0-[subView]-0-|";
        NSDictionary *dic = NSDictionaryOfVariableBindings(self,subView);
        NSArray *arr1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:0 metrics:nil views:dic];
        NSArray *arr2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2 options:0 metrics:nil views:dic];
        [self addConstraints:arr1];
        [self addConstraints:arr2];
    }
    return self;
}

- (void)awakeFromNib
{
    _detailTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _textViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_detailTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kTextViewDefaultHeight];
    [_detailTextView addConstraint:_textViewHeightConstraint];
}




@end
