//
//  HKRefreshTableViewController.h
//  易汇智
//
//  Created by App on 16/3/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HKRefreshViewController.h"

@interface HKRefreshTableViewController : HKRefreshViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (CGFloat)tableViewCellHeightForData:(id)object atIndexPath:(NSIndexPath *)indexPath;
@end
