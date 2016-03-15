//
//  SignViewController.m
//  易汇智
//
//  Created by Jason on 16/3/12.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "SignViewController.h"

@interface SignViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webVIew;

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webVIew loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
