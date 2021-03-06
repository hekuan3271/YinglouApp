//
//  HKRefreshTableViewController.m
//  易汇智
//
//  Created by App on 16/3/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HKRefreshTableViewController.h"
#import "Categories/ColorClass.h"

@interface HKRefreshTableViewController ()

@end

@implementation HKRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerNib:[UINib nibWithNibName:[self nibNameOfCell] bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kDefaultViewColor;
    
}
#pragma mark -- 私有方法 子类无需重写
- (void)reloadByAdding:(NSArray *)anArray{
    [super reloadByAdding:anArray];
    NSInteger displayedSectionIndex = [self.dataArray count];
    NSMutableArray *insertedIndexPaths = [NSMutableArray array];
    for (int insertedIndex = 0, insertedCount = [anArray count]; insertedIndex < insertedCount; insertedIndex ++) {
        [insertedIndexPaths addObject:[NSIndexPath indexPathForRow:displayedSectionIndex + insertedIndex inSection:0]];
    }
    NSIndexSet *insertedIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(displayedSectionIndex, [anArray count])];
    [self.tableView beginUpdates];
    [self.dataArray insertObjects:anArray atIndexes:insertedIndexSet];
    [self.tableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (UIScrollView *)contentScrollView {
    return self.tableView;
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - 子类必须重写的方法

- (UIView *)layoutCellWithData:(id)object atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    return cell;
}

#pragma mark - UITableView特有的方法

- (CGFloat)tableViewCellHeightForData:(id)object atIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self cellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id objectModel = nil;
    if (indexPath.row < [self.dataArray count]) {
        objectModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    UITableViewCell *cell = (UITableViewCell *)[self layoutCellWithData:objectModel atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id objectModel = nil;
    if (indexPath.row < [self.dataArray count]) {
        objectModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    CGFloat rowHeight = [self tableViewCellHeightForData:objectModel atIndexPath:indexPath];
    return rowHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id objectModel = nil;
    if (indexPath.row < [self.dataArray count]) {
        objectModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    [self clickedCell:objectModel atIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id objectModel = nil;
    if (indexPath.row < [self.dataArray count]) {
        objectModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    [self removeCell:objectModel atIndexPath:indexPath];
}


@end
