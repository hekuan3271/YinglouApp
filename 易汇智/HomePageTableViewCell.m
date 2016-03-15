//
//  HomePageTableViewCell.m
//  易汇智
//
//  Created by Jason on 16/3/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HomePageTableViewCell" owner:self options:nil];
            self = [arrayOfViews objectAtIndex:0];
            [self awakeFromNib];
        }
        return self;
//        self.headImageView.layer.cornerRadius = 10;//设置那个圆角的有多圆
//        self.headImageView.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
//        self.headImageView.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
//        self.headImageView.layer.masksToBounds = YES;
    }
    return self;
}

@end
