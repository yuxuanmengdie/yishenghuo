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
