//
//  YSHActivityViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-16.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHActivityViewController.h"
#import "YSHPhotoCollectionViewCell.h"
#import "YSHActivityTableCell.h"
#import "YSHTagCollectionViewCell.h"
#import "YSHDatePickerViewController.h"

@interface YSHActivityViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UICollectionViewDelegateFlowLayout,
UITableViewDataSource,
UITableViewDelegate
>

{
    /// 图片数组
    NSMutableArray *contentArray;
    
    /// 标签数组
    NSMutableArray *tagArray;
    
    
    
    ///date VC
    YSHDatePickerViewController *_datePickerVC;
    
    ///记录是开始事件还是结束
    BOOL _isStartTime;
    
    
    NSDate *_startDate;
    
    NSDate *_endDate;

}

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *subHead1;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;


@property (weak, nonatomic) IBOutlet UIView *widSepView1;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *subHead2;

@property (weak, nonatomic) IBOutlet UITextField *textFileld1;
@property (weak, nonatomic) IBOutlet UIView *sepView1;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *subHead3;




@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *endButton;
- (IBAction)endBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *sepView2;
@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell1;

@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;

@property (weak, nonatomic) IBOutlet UITextView *textView1;

@property (weak, nonatomic) IBOutlet UILabel *currentNum;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;

@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell2;
@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell3;

@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell4;
@property (weak, nonatomic) IBOutlet YSHActivityTableCell *tableViewCell5;

@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView3;
@property (weak, nonatomic) IBOutlet UITableView *tableView4;
@property (weak, nonatomic) IBOutlet UITableView *tableView5;


@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

/// photo的 collectionView的高度
@property (strong, nonatomic) NSLayoutConstraint *collectHeight;
/// 标签的 collectionView d的高度
@property (strong, nonatomic) NSLayoutConstraint *tagCollectionHeight;

@property (strong, nonatomic) NSLayoutConstraint *contentHeight;


///
@property (strong, nonatomic) UIButton *tagButton;

/// 弹出选择日期的 datapicker 的背景

@property (strong, nonatomic) UIView *dateBackView;


@end

@implementation YSHActivityViewController

static NSString *const kCollectCell = @"photoCell";
static NSString *const kTagCell = @"tagCell";


///  date viewController 的 story identifier
static  NSString *const kDateVCIdentifier = @"dateIdentifier";

static NSString *const kActivityInfo = @"activityInfo";

static NSString *const kActivityDetail = @"activityDetail";

static NSString *const kActivityTableCellIdentifier = @"activityTableCellIdentifier";



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
    
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    _tagCollectionView.delegate = self;
    _tagCollectionView.dataSource = self;
    _photoCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _tagCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    contentArray = [[NSMutableArray alloc] init];
    tagArray = [@[@"美女",@"帅哥",@"永久免费",@"ssssssssssss"] mutableCopy];
    
    _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _tagButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_tagButton setContentEdgeInsets:UIEdgeInsetsMake(5, 20, 5, 20)];
   
    [[_tagButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    _tagButton.hidden = YES;
//    [self.view addSubview:_tagButton];
    
    _dateBackView = [[UIView alloc] init];
    _dateBackView.backgroundColor = [UIColor darkGrayColor];
    _dateBackView.alpha = 0.5;
    _dateBackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_dateBackView];
    _dateBackView.hidden = YES;
    NSArray *conArr1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_dateBackView]-0-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_dateBackView,self.view)];
     NSArray *conArr2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_dateBackView]-0-|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(_dateBackView,self.view)];
    [self.view addConstraints:conArr1];
    [self.view addConstraints:conArr2];
    
    
    NSLog(@"appear %f",_photoCollectionView.contentSize.height);
    _collectHeight = [NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_photoCollectionView.contentSize.height];
    [self.contentView addConstraint:_collectHeight];
    
    
    _tagCollectionHeight =  [NSLayoutConstraint constraintWithItem:_tagCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:Nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_tagCollectionView.contentSize.height];
    [self.contentView addConstraint:_tagCollectionHeight];
    
    
    CGFloat height = [_contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    _contentHeight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    NSLayoutConstraint *contentWid = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    [self.view addConstraint:contentWid];
    [self.view addConstraint:_contentHeight];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    
    
    self.TitleLabel1.text = @"上传活动海报";
    self.subHead1.text = @"(必填)可发多张海报";
    
    self.titleLabel2.text = @"活动标题";
    self.subHead2.text = @"(必填)";
    
    self.titleLabel3.text = @"活动时间";
    self.subHead3.text = @"(必填)";
    
    self.titleLabel4.text = @"更多益处";
    
    __weak typeof(self) wself = self;
    
    
    self.tableViewCell1.translatesAutoresizingMaskIntoConstraints = NO;
     self.tableViewCell2.translatesAutoresizingMaskIntoConstraints = NO;
     self.tableViewCell3.translatesAutoresizingMaskIntoConstraints = NO;
     self.tableViewCell4.translatesAutoresizingMaskIntoConstraints = NO;
     self.tableViewCell5.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tableViewCell1.mainTitleLabel.text = @"活动地址";
    self.tableViewCell1.subHead.text = @"(必填)";
    self.tableViewCell1.rightLabel.text = @"福州市";
    self.tableViewCell1.mySwitch.hidden = YES;
    self.tableViewCell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.tableViewCell1.contentView updateConstraintsIfNeeded];
    [self.tableViewCell1.contentView layoutIfNeeded];
    self.tableViewCell1.tableCellSelectBlock = ^{
        
    };
    
    
    self.tableViewCell2.mainTitleLabel.text = @"活动详情";
    self.tableViewCell2.subHead.text =  nil;
    self.tableViewCell2.rightLabel.text = nil;
    self.tableViewCell2.mySwitch.hidden = YES;
    self.tableViewCell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tableViewCell2.tableCellSelectBlock = ^{
        [wself performSegueWithIdentifier:kActivityDetail sender:wself];
    };

    self.tableViewCell3.mainTitleLabel.text = @"费用、人数、联系方式";
    self.tableViewCell3.subHead.text =  nil;
    self.tableViewCell3.rightLabel.text = nil;
    self.tableViewCell3.mySwitch.hidden = YES;
    self.tableViewCell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tableViewCell3.tableCellSelectBlock = ^{
        [wself performSegueWithIdentifier:kActivityInfo sender:wself];
        
    };

    self.tableViewCell4.mainTitleLabel.text = @"活动类别";
    self.tableViewCell4.subHead.text = @"(添加类别标签系统会帮你找人！）";
    self.tableViewCell4.rightLabel.text = nil;
    self.tableViewCell4.mySwitch.hidden = YES;
    self.tableViewCell4.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tableViewCell4.tableCellSelectBlock = ^{
        
    };

    self.tableViewCell5.mainTitleLabel.text = @"系统帮忙找人";
    self.tableViewCell5.subHead.text =  nil;
    self.tableViewCell5.rightLabel.text = nil;
    self.tableViewCell5.mySwitch.hidden = NO;
    self.tableViewCell5.accessoryType = UITableViewCellAccessoryNone;

    
    [_tableView1 registerNib:[UINib nibWithNibName:NSStringFromClass([YSHActivityTableCell class]) bundle:nil] forCellReuseIdentifier:kActivityTableCellIdentifier];
    [_tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([YSHActivityTableCell class]) bundle:nil] forCellReuseIdentifier:kActivityTableCellIdentifier];

    [_tableView3 registerNib:[UINib nibWithNibName:NSStringFromClass([YSHActivityTableCell class]) bundle:nil] forCellReuseIdentifier:kActivityTableCellIdentifier];

    [_tableView4 registerNib:[UINib nibWithNibName:NSStringFromClass([YSHActivityTableCell class]) bundle:nil] forCellReuseIdentifier:kActivityTableCellIdentifier];

    [_tableView5 registerNib:[UINib nibWithNibName:NSStringFromClass([YSHActivityTableCell class]) bundle:nil] forCellReuseIdentifier:kActivityTableCellIdentifier];

    
    
    
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView3.delegate = self;
    _tableView3.dataSource = self;
    _tableView4.delegate = self;
    _tableView4.dataSource = self;
    _tableView5.delegate = self;
    _tableView5.dataSource = self;
    

    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _collectHeight.constant = _photoCollectionView.contentSize.height;
    
    
    NSLog(@"appear %f",_photoCollectionView.contentSize.height);
    
    _tagCollectionHeight.constant = _tagCollectionView.contentSize.height;
    
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    CGFloat height = [_contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    _contentHeight.constant = height;
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  根据 date 返回字符串

- (NSString *)dateStrWithDate:(NSDate *)date
{
    if (date == Nil) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];//[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

/// 加载 date VC

- (void)loadDatePickerVC
{
    if (_datePickerVC == nil) {
         UIStoryboard *story = [UIStoryboard  storyboardWithName:@"Main"   bundle:nil];
        _datePickerVC = [story instantiateViewControllerWithIdentifier:kDateVCIdentifier];
        _datePickerVC.view.backgroundColor = [UIColor whiteColor];
//        [_datePickerVC.datePicker setLocale:[NSLocale currentLocale]];
        _datePickerVC.view.layer.masksToBounds = YES;
        _datePickerVC.view.layer.cornerRadius = 10;
        [self.view addSubview:_datePickerVC.view];
        _datePickerVC.view.bounds = self.view.bounds;
        
        _datePickerVC.view.translatesAutoresizingMaskIntoConstraints = NO;
        [_datePickerVC.view updateConstraintsIfNeeded];
        [_datePickerVC.view layoutIfNeeded];
       
        
        
        NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:_datePickerVC.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:_datePickerVC.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        
        
        NSLayoutConstraint *con4 = [NSLayoutConstraint constraintWithItem:_datePickerVC.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:280];
        [self.view addConstraints:@[con1,con2,con4]];
        [self.view updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];

        
         CGSize dateSize = [_datePickerVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        NSLog(@"size=%@",NSStringFromCGSize(dateSize));
        NSLayoutConstraint *con3 = [NSLayoutConstraint constraintWithItem:_datePickerVC.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:dateSize.height];
        
        [self.view addConstraint:con3];
        }
    
    _datePickerVC.view.hidden = NO;
    _dateBackView.hidden = NO;
    
    if (_isStartTime) {
        _datePickerVC.titleLabel.text = @"活动开始时间";
    }
    else
    {
        _datePickerVC.titleLabel.text = @"活动结束时间";
    }
    
    __weak typeof(self) wself = self;
    _datePickerVC.buttonActionBlock = ^(int num){
        
        __strong typeof(wself) swself = wself;
        switch (num) {
            case 0: /// cancel
            {
                
            }
                break;
            case 1: //// 确定
            {
                if (swself->_isStartTime) { /// 开始时间
                    
                    
                    swself->_startDate = swself->_datePickerVC.datePicker.date;
                    [swself.startButton setTitle:[swself dateStrWithDate:swself->_startDate] forState:UIControlStateNormal];
                    
                }
                else
                {
                    
                     swself->_endDate = swself->_datePickerVC.datePicker.date;
                    [swself.endButton setTitle:[swself dateStrWithDate:swself->_endDate] forState:UIControlStateNormal];
                    
                }
            }
                break;
                
            default:
                break;
        }
        [swself.view layoutIfNeeded];
        
        [wself hiddenDatePicker];
    };
}

- (void)hiddenDatePicker
{
    _datePickerVC.view.hidden = YES;
    _dateBackView.hidden = YES;
}

- (IBAction)startBtnAction:(id)sender {
    
    _isStartTime = YES;
    [self loadDatePickerVC];
    
    /*
     static  NSString *controllerId =@"newViewController";
     
     //2.获取UIStoryboard对象
    c
     
     //3.从storyboard取得newViewCtroller对象，通过Identifier区分
     newViewController *nvc = [story instantiateViewControllerWithIdentifier:controllerId];
     */
}
- (IBAction)endBtnAction:(id)sender {
    _isStartTime = NO;
    [self loadDatePickerVC];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _tagCollectionView) {
        return [tagArray count];
    }
    return [contentArray count]+1;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _tagCollectionView) {
        
         YSHTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTagCell forIndexPath:indexPath];
//        cell.tagButton.titleEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 20);
        [[cell.tagButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
        [cell.tagButton setTitle:tagArray[indexPath.row] forState:UIControlStateNormal];
       
        cell.tagButton.layer.masksToBounds = YES;
        cell.tagButton.layer.cornerRadius = 10;
        cell.tagButton.backgroundColor = [UIColor purpleColor];
        
        return cell;
    }
   
    
    
    
    YSHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectCell forIndexPath:indexPath];
    
    if (indexPath.row < [contentArray count]) {
        cell.imgView.image = contentArray[indexPath.row];
    }
    return cell;
}


#pragma mark flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.photoCollectionView) {
        return CGSizeMake(50, 50);
    }
    [_tagButton setTitle:tagArray[indexPath.row] forState:UIControlStateNormal];
    [_tagButton sizeToFit];
    [_tagButton layoutIfNeeded];
    
    CGSize size = [_tagButton systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _tagCollectionView) {
        return;
    }
    
    
    if (indexPath.row == [contentArray count]) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select from" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo library",@"Phots album", nil];
        
        //        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [sheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //    imagePicker.modalInPopover = YES;
   
    
    switch (buttonIndex) {
        case 0:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"支持相机");
                
                
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.showsCameraControls = YES;
                
                
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            
            
            
        }
            
            break;
        case 1:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                NSLog(@"支持图库");
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               [self presentViewController:imagePicker animated:YES completion:nil];
                
                
            }
            
        }
            break;
        case 2:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                NSLog(@"支持相片库");
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                //                [self dismissViewControllerAnimated:YES completion:nil];
                //                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                //                    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                //
                //                    [popover presentPopoverFromRect:self.view.bounds inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                //                    self.popOver = popover;
                //
                //                } else {
                [self presentViewController:imagePicker animated:YES completion:nil];
                //                }
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

# pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil) {
        
        NSData *imageData = UIImageJPEGRepresentation(image,0.00001); /// 122955 ,resultData=10835   1516975 ,resultData=10835
        UIImage *result = [self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
        NSData *resultData = UIImageJPEGRepresentation(result, 1.0);
        UIImage *img = [UIImage imageWithData:imageData];
        
        NSLog(@"%lu ,resultData=%lu",(unsigned long)imageData.length,(unsigned long)resultData.length);
        
        [contentArray addObject:img];
        [self.photoCollectionView reloadData];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSHActivityTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivityTableCellIdentifier forIndexPath:indexPath];
    if ([tableView isEqual:_tableView1]) {
        
        cell.mainTitleLabel.text = @"活动地址";
        cell.subHead.text = @"(必填)";
        cell.rightLabel.text = @"福州市";
        cell.mySwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    else if ([tableView isEqual:_tableView2])
    {
        
        cell.mainTitleLabel.text = @"活动详情";
        cell.subHead.text = nil;
        cell.rightLabel.text = nil;
        cell.mySwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([tableView isEqual:_tableView3])
    {
        cell.mainTitleLabel.text = @"费用、人数、联系方式";
        cell.subHead.text = nil;
        cell.rightLabel.text = nil;
        cell.mySwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([tableView isEqual:_tableView4])
    {
        cell.mainTitleLabel.text = @"活动类别";
        cell.subHead.text = @"(添加类别标签系统会帮你找人！）";
        cell.rightLabel.text = nil;
        cell.mySwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([tableView isEqual:_tableView5])
    {
        cell.mainTitleLabel.text = @"系统帮忙找人";
        cell.subHead.text = nil;
        cell.rightLabel.text = nil;
        cell.mySwitch.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.rightBtnTrailConstraint.constant -= cell.mySwitch.intrinsicContentSize.width;
    }


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView1]) {
        
    }
    else if ([tableView isEqual:_tableView2])
    {
        
    }
    else if ([tableView isEqual:_tableView3])
    {
        
    }
    else if ([tableView isEqual:_tableView4])
    {
        
    }
    else if ([tableView isEqual:_tableView5])
    {
        
    }

}
@end
