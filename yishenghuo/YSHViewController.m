//
//  YSHViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHViewController.h"
#import "YSHBodyModel.h"
#import "YSHSubModel.h"

@interface YSHViewController ()

@end

@implementation YSHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request
{
//    NSString *url_string = @"https://api-v2.soundcloud.com/explore/world?tag=time-decay-experiment%3A4%3A1386571445&limit=10&offset=0&linked_partitioning=1";
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
// //       NSLog(@"JSON: %@", responseObject);
//        
//        //        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"Error: %@", error);
//    }];
//    
    
    NSString *url_string = @"https://api-v2.soundcloud.com/explore/world?tag=time-decay-experiment%3A4%3A1386571445&limit=10&offset=0&linked_partitioning=1";
    //@"http://115.29.232.128:7888/c/app.htm?code=1008&format=json&method=report&sign=feb37771434d6867416ef2be46e3f899&type=03"
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:CategaryListCode token:nil reportXML:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
               NSLog(@"JSON: %@", responseObject);
        
        //        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"response=%@",operation.responseString);
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        YSHBodyModel *bodyModel = [[YSHBodyModel alloc] initWithString:operation.responseString error:nil];
        [bodyModel.zBODY enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            YSHSubModel *sub = [[YSHSubModel alloc] initWithDictionary:obj error:nil];
            [array addObject:sub];
        }];
        NSLog(@"%@ ",array);
    }];
    
    

    
   
  
}

@end
