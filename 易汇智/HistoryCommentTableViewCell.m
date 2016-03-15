//
//  HistoryCommentTableViewCell.m
//  易汇智
//
//  Created by App on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HistoryCommentTableViewCell.h"

@implementation HistoryCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HistoryCommentTableViewCell" owner:self options:nil];
            self = [arrayOfViews objectAtIndex:0];
        }
        return self;
    }
    return self;
}
@end
