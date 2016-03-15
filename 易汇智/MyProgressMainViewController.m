//
//  MyProgressMainViewController.m
//  易汇智
//
//  Created by App on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "MyProgressMainViewController.h"
#import "FuwurenxiangxiViewController.h"

@interface MyProgressMainViewController ()

@end

@implementation MyProgressMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"预约" style:UIBarButtonItemStylePlain target:self action:@selector(yuyue)];
    self.navigationItem.rightBarButtonItem=rightItem;
}
- (IBAction)chakanxiangqingBtnClick:(id)sender {
     [self pushViewController:@"MyProgressViewController"];
    
}
- (IBAction)chakanfuwurenyuan:(id)sender {
    [self pushViewController:@"FuwurenxiangxiViewController"];
}
- (void)yuyue{
    
}
@end
