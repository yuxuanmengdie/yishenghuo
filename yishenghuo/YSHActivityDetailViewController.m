//
//  YSHActivityDetailViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHActivityDetailViewController.h"
#import "YSHTitleDetailView.h"

@interface YSHActivityDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) IBOutlet YSHTitleDetailView *detailView1;

@property (weak, nonatomic) IBOutlet YSHTitleDetailView *detailView2;
@end

@implementation YSHActivityDetailViewController

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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    
     self.backScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _detailView1.translatesAutoresizingMaskIntoConstraints = NO;
    _detailView2.translatesAutoresizingMaskIntoConstraints = NO;
     _containView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _detailView1.detailTextView.translatesAutoresizingMaskIntoConstraints = NO;
//    _detailView1.textViewHeightConstraint.constant = 200;
    [_detailView1 updateConstraintsIfNeeded];
    [_detailView1 layoutIfNeeded];
    /*
    CGSize size1 = [_detailView1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLayoutConstraint *hei1 = [NSLayoutConstraint constraintWithItem:_detailView1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size1.height];
    [_detailView1 addConstraint:hei1];
    NSLog(@"1hei=%f",size1.height);
    
    _detailView2.detailTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _detailView2.textViewHeightConstraint.constant = 100;
    [_detailView2 updateConstraintsIfNeeded];
    [_detailView2 layoutIfNeeded];
    CGSize size2 = [_detailView2 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLayoutConstraint *hei2 = [NSLayoutConstraint constraintWithItem:_detailView2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size2.height];
    [_detailView2 addConstraint:hei2];
    NSLog(@"2hei=%f",size2.height);
*/
    _detailView1.backgroundColor = [UIColor whiteColor];
    _detailView2.backgroundColor = [UIColor whiteColor];
    self.backScrollView.backgroundColor = [UIColor lightGrayColor];
    self.containView.backgroundColor = [UIColor redColor];
    
    
    
   
    
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:_containView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
//    [_containView updateConstraintsIfNeeded];
//    [_containView layoutIfNeeded];
//    
//    CGSize size = [_containView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:_containView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height];
//    NSLog(@"contain=%f",size.height);
    
    [self.view addConstraints:@[con1]];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",_detailView1);
    
}

@end
