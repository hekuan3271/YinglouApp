//
//  HomePageTableViewCell.h
//  易汇智
//
//  Created by Jason on 16/3/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contenlabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
