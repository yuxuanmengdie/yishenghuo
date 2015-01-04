//
//  YSHCategaryListView.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-12.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHCategaryListView.h"


static const int kSubViewsTagOri = 400;
static const int kEdgeSpacing = 20;
static const float kSubSpacing = 8;
static NSString *const kBackImage = @"";
static const int kNumOfLine = 3;

@implementation YSHCategaryListView

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


- (void)subViewsWithArr:(NSArray *)arr
{
    if (arr == nil || arr.count == 0) {
        return;
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UIView *subView = [[UIView alloc] init];
        [subView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBackImage]]];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        subView.tag = kSubViewsTagOri + idx;
        [self addSubview:subView];
        
        NSLayoutConstraint *equal = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:subView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self addConstraint:equal];
        
        
    }];
    
    UIView *firstView = [self viewWithTag:kSubViewsTagOri];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kEdgeSpacing];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:kEdgeSpacing];
    [self addConstraint:left];
    [self addConstraint:top];
    
    
    for (int j=1; j<[arr count]; j++) {
        
        UIView *sub = [self viewWithTag:kSubViewsTagOri+j];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:sub attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        [self addConstraint:constraint];
        
        int i = (j+1)%kNumOfLine;
        
        if (i == 0) { /// 最右边
            
            NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:sub attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kEdgeSpacing];
            [self addConstraint:right];
        }
        else if (i == 1) /// 最左边的
        {
            NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:sub attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:firstView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
            [self addConstraint:lead];
        }
        
        
        if (j== [arr count] -1) { ///最底部的
            
            NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:sub attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kEdgeSpacing];
            [self addConstraint:bottom];

        }
        
    }
    
    
    
}
@end
