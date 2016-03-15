//
//  HistoryCommentViewController.m
//  易汇智
//
//  Created by App on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HistoryCommentViewController.h"
#import "HistoryCommentTableViewCell.h"

@interface HistoryCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIButton *checkViewAllCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkViewPicktureBtn;
@property (weak, nonatomic) IBOutlet UIView *checkViewLineView;

@end

@implementation HistoryCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.checkView;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.checkViewAllCommentBtn bk_whenTapped:^{
       [self.checkViewAllCommentBtn setTitleColor:color(13, 95, 255, 1) forState:UIControlStateNormal];
        [self.checkViewPicktureBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        self.tableView.hidden=NO;
    }];
    [self.checkViewPicktureBtn bk_whenTapped:^{
        [self.checkViewAllCommentBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [self.checkViewPicktureBtn setTitleColor:color(13, 95, 255, 1) forState:UIControlStateNormal];
//        self.tableView.hidden=YES;
    }];
}
#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 299;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"cell";
    HistoryCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[HistoryCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
