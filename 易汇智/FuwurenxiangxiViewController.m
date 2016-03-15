//
//  FuwurenxiangxiViewController.m
//  易汇智
//
//  Created by App on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "FuwurenxiangxiViewController.h"
#import "FuwurenxiangxiTableViewCell.h"

@interface FuwurenxiangxiViewController ()<UITableViewDelegate,UITableViewDataSource>{

}

@end

@implementation FuwurenxiangxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"cell";
    FuwurenxiangxiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[FuwurenxiangxiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.headImageView.image=[UIImage imageNamed:@"00消息--签到_10"];
    [cell.comentBtn bk_whenTapped:^{
        [self pushViewController:@"FuwurenCommentViewController"];
    }];
    return cell;
}

@end
