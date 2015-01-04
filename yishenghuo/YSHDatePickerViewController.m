//
//  YSHDatePickerViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHDatePickerViewController.h"

@interface YSHDatePickerViewController ()

@end

@implementation YSHDatePickerViewController

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
    
    
    self.datePicker.timeZone = [NSTimeZone localTimeZone];
    self.datePicker.date = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftBtnAction:(id)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(0);
    }
}

- (IBAction)rightBtnAction:(id)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(1);
    }

}
@end
