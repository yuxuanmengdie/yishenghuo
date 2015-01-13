//
//  YSHBodyTestChartView.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-7.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHBodyTestChartView.h"

@implementation YSHBodyTestChartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_hightScore == 0) {
        return;
    }
    
    CGRect viewRect = _typeView1.frame;
    CGFloat hei = CGRectGetMaxY(_typeView1.frame);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, KMainColor.CGColor);
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0,hei*(1-30.0/_hightScore));
    CGContextAddLineToPoint(context, rect.size.width,hei*(1-30.0/_hightScore));
    CGContextStrokePath(context);
//    CGContextClosePath(context);

    
    CGContextRef context1 =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context1);
    CGContextSetLineWidth(context1, 0.5);

    CGContextSetStrokeColorWithColor(context1, [UIColor orangeColor].CGColor);
    
    CGContextSetLineDash(context1, 0, lengths,2);
    CGContextMoveToPoint(context1, 0,hei*(1-40.0/_hightScore));
    CGContextAddLineToPoint(context1, rect.size.width,hei*(1-40.0/_hightScore));
    CGContextStrokePath(context1);
//    CGContextClosePath(context1);
    
}



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
    
    
    UIView *subView = [self viewWithTag:500];
    
//    subView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [subView setNeedsDisplay];
}


@end
