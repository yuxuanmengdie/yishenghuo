//
//  YSHActivityInfoViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHActivityInfoViewController.h"
#import "YSHTitleDetailView.h"
#import "YSHActivityTableCell.h"
#import "YSHActivityInfoView.h"

@interface YSHActivityInfoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollVIew;
@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) IBOutlet YSHActivityInfoView *infoView1;

@property (weak, nonatomic) IBOutlet YSHActivityInfoView *infoView2;;

@property (weak, nonatomic) IBOutlet YSHActivityInfoView *infoView3;;
@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell;
@end

@implementation YSHActivityInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    _containView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.backScrollVIew.translatesAutoresizingMaskIntoConstraints = NO;
    _infoView1.translatesAutoresizingMaskIntoConstraints = NO;
    _infoView2.translatesAutoresizingMaskIntoConstraints = NO;
    _infoView3.translatesAutoresizingMaskIntoConstraints = NO;
    _containView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_infoView1 updateConstraintsIfNeeded];
    [_infoView1 layoutIfNeeded];
    CGSize infoSize = [_infoView1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    NSLayoutConstraint *hei1 = [NSLayoutConstraint constraintWithItem:_infoView1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:infoSize.height];
    [_infoView1 addConstraint:hei1];
    
    NSLayoutConstraint *hei2 = [NSLayoutConstraint constraintWithItem:_infoView2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:infoSize.height];
    [_infoView2 addConstraint:hei2];

    
    NSLayoutConstraint *hei3 = [NSLayoutConstraint constraintWithItem:_infoView3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:infoSize.height];
    [_infoView3 addConstraint:hei3];

    
    
    
    
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:_containView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [_containView updateConstraintsIfNeeded];
    [_containView layoutIfNeeded];
    
    CGSize size = [_containView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:_containView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height];
    
   
        //13
    
    [self.view addConstraints:@[con1,con2]];
//    [self.view addConstraint:con2];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    
   
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
