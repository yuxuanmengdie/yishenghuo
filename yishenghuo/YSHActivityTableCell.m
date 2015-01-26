//
//  YSHActivityTableCell.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-16.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHActivityTableCell.h"

@implementation YSHActivityTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self addGestureRecognizer:tap];
    
    oriConstant = _rightBtnTrailConstraint.constant;
}

- (void)tapAction
{
    NSLog(@"tap");
    
    
    
    if (self.tableCellSelectBlock) {
        self.selected = YES;
        self.tableCellSelectBlock();
    }
}


//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if ([super initWithCoder:aDecoder]) {
//        
//        UITableViewCell *subView = [[[NSBundle mainBundle] loadNibNamed:@"YSHActivityTableCell" owner:self options:nil] firstObject];
//        [self.contentView addSubview:subView.contentView];
//        
////        [self。co addSubview:subView.contentView];
//        
//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//        subView.contentView.translatesAutoresizingMaskIntoConstraints = NO;
////        
//        NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:subView.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
//        NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:subView.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
//        NSLayoutConstraint *con3 = [NSLayoutConstraint constraintWithItem:subView.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *con4 = [NSLayoutConstraint constraintWithItem:subView.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        [self.contentView addConstraints:@[con1,con2,con3,con4]];
////
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    NSLog(@"selected!!!");
//
//    if (selected) {
//        self.selected = NO;
//    }
    
    // Configure the view for the selected state
}

- (IBAction)switchAction:(id)sender {
    
    if (self.switchActionBlock) {
        self.switchActionBlock(self.mySwitch.isOn);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    static int j = 0;
    if (_mySwitch.hidden) {
//        if (_rightBtnTrailConstraint.secondItem == self) {
//            return;
//        }
//        [self removeConstraint:_rightBtnTrailConstraint];
//        self.rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        _rightBtnTrailConstraint  = [NSLayoutConstraint constraintWithItem:self.rightLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-8];
//        [self addConstraint:_rightBtnTrailConstraint];
        
//        if (_rightBtnTrailConstraint.constant != -8) {
//            return;
//        }
        
        if (_rightBtnTrailConstraint.constant == oriConstant)
        {
//            isIn = YES;
            NSLog(@"%d",++j);
            _rightBtnTrailConstraint.constant -=  _mySwitch.intrinsicContentSize.width-8;
            NSLog(@"%f",_rightBtnTrailConstraint.constant);
            [self.contentView updateConstraintsIfNeeded];
            [self.contentView layoutIfNeeded];


        }
            }
}
@end
