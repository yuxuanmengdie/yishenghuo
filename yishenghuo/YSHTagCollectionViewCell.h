//
//  YSHTagCollectionViewCell.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHTagCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *tagButton;

- (IBAction)tagBtnAction:(id)sender;
@end
