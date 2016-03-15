//
//  HomePageViewController.m
//  易汇智
//
//  Created by App on 16/3/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HomePageViewController.h"
#import <UIBarButtonItem+BlocksKit.h>
#import "HomePageTableViewCell.h"
#import "KxMenu.h"

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *imageArray;
    NSArray *titleArray;
    NSArray *contenArray;
    UIButton *btn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *checkView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
    imageArray=@[@"00消息--签到_10",@"00消息--签到_30",@"00消息--签到_24",@"00消息--签到_26",@"00消息--签到_28",@"00消息--签到_30",@"00消息--签到_32"];
    titleArray=@[@"我的服务进度",@"我的产品",@"会员积分",@"我的服装",@"我的照片",@"我的圈子",@"嗨嗨嗨"];
    contenArray=@[@"通知拍照日期:2016-02-14 上午11：10",@"追踪产品制作状态",@"消费、介绍积分信息",@"拍照礼服服务信息",@"拍照照片查询、分享",@"推广+交流=收益福利",@"一张优质照片背后？"];
}
- (void)setViews{
//    UIBarButtonItem *RightButton=[[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"00消息--签到_03"] style:nil handler:^(id sender) {
//        NSLog(@"dsdas");
//    }];
    btn=[UIButton new];
    [btn setBackgroundImage:[UIImage imageNamed:@"00消息--签到_03"] forState:UIControlStateNormal];
    btn.frame=makeFrame(0, 0, 5,15);
    [btn bk_whenTapped:^{
        [self showMenu];
    }];
    UIBarButtonItem *RightButton=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=RightButton;
    self.title=@"消息";
    
    self.tableView.tableHeaderView=self.checkView;
//    self.tableView.separatorColor=[UIColor whi];
}
#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"cell";
    HomePageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.headImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[indexPath.row]]];
    cell.titleLabel.text=titleArray[indexPath.row];
    cell.contenlabel.text=contenArray[indexPath.row];
    return cell;
}
- (void)showMenu{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"签到"
                     image:[UIImage imageNamed:@"00消息--签到_07"]
                    target:self
                    action:@selector(signPush)],
      
      [KxMenuItem menuItem:@"好友推广"
                     image:[UIImage imageNamed:@"00消息--签到_14"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"扫一扫"
                     image:[UIImage imageNamed:@"00消息--签到_20"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(165, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)
                 menuItems:menuItems];
}
- (void)signPush{
    [self pushViewController:@"SignViewController"];
}



//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self pushViewController:@"MyProgressMainViewController"];
            break;
            
        default:
            break;
    }
}
@end
