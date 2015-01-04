//
//  YSHBodyTestCell.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHBodyTestCell.h"

@implementation YSHBodyTestCell

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
    
//    _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *rightCon = [NSLayoutConstraint constraintWithItem:_questionLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-8];
//    [self.contentView addConstraint:rightCon];
//    [self.contentView layoutIfNeeded];
    _questionLabel.preferredMaxLayoutWidth = self.frame.size.width-16;
    
    
}


- (IBAction)segmentAction:(id)sender {
    
    if (self.segmentActionBlock) {
        self.segmentActionBlock((int)_selectSegmentControl.selectedSegmentIndex);
    }
}


@end
