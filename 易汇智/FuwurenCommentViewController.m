//
//  FuwurenCommentViewController.m
//  易汇智
//
//  Created by App on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "FuwurenCommentViewController.h"
#import "FuwurenCommentTableViewCell.h"

@interface FuwurenCommentViewController ()
@property (strong, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIButton *checkViewbtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *headerViewCommentBtn;

@end

@implementation FuwurenCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.checkView;
    [self.checkViewbtn bk_whenTapped:^{
        [self pushViewController:@"HistoryCommentViewController"];
    }];
}
- (IBAction)commentBtnClick:(id)sender {
    [self pushViewController:@"CommentContentViewController"];
}
#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"cell";
    FuwurenCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[FuwurenCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
 
    return cell;
}

@end
