//
//  HKRefreshViewController.m
//  易汇智
//
//  Created by App on 16/3/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "HKRefreshViewController.h"
#import "MJRefresh.h"
//#import "WTRManager.h"
#import "BaseModel.h"

typedef void (^RequestSuccessed)(id responseObject);
typedef void (^RequestFailure)(NSInteger errorCode, NSString *errorMessage);

@interface HKRefreshViewController ()
@property (nonatomic, assign) BOOL isTipsViewHidden;        //设置没有数据的提示view是否隐藏

@end

@implementation HKRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否需要刷新
    if ([self refreshEnable]) {
        [self addRefreshHeadView];
        if ([self shouldEnableRefresh]) {
            [self.contentScrollView.header beginRefreshing];
        }
    }
    
    //判断是否需要刷新更多
    if ([self loadMoreEnable]) {
        [self addRefreshFootView];
    }

}
#pragma mark  ---------------------------------------------------------------
- (void)addRefreshHeadView{
    WeakSelfType blockSelf=self;
    [self.contentScrollView addLegendHeaderWithRefreshingBlock:^{
        [blockSelf refreshBlocks:blockSelf.successBlock andRefreshFailer:blockSelf.failedBlock];
    }];
}
- (void)addRefreshFootView{
    WeakSelfType blockSelf=self;
    [self.contentScrollView addLegendFooterWithRefreshingBlock:^{
        [blockSelf loadMoreRefreshBlocks:blockSelf.successBlock andRefreshFailer:blockSelf.failedBlock];
    }];
}
//-----
//刷新更多
- (void)loadMoreRefreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer{
    [self loadMoreRefreshBlocks:refreshSuccess andRefreshFailer:refreshFailer withRequestType:RequestTypeGET];
}

- (void)loadMoreRefreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer withRequestType:(RequestType) requestType{
    WeakSelfType blockSelf=self;
    RequestSuccessed requestSuccessed=^(id responseObject){
        //停止刷新
        [blockSelf.contentScrollView.footer endRefreshing];
        [blockSelf hideHUDLoading];
        
        //获取结果
        NSArray *dataArray=nil;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            dataArray=(NSArray *)responseObject;
        }else if([responseObject isKindOfClass:[BaseDataModel class]]){
            dataArray=@[responseObject];
        }
        //2. 根据组装后的数组刷新列表
        NSArray *newDataArray = nil;
        if ([dataArray count] > 0) {
            blockSelf.currentPageIndex++;//只要返回有数据就自增
            newDataArray = [blockSelf preProcessData:dataArray];
        }
        if ([newDataArray count] > 0) {
            blockSelf.isTipsViewHidden=YES;
            [blockSelf reloadByAdding:newDataArray];
        }
        else {
            if ([blockSelf.dataArray count] == 0) {//判断总的数组是否为空
                blockSelf.isTipsViewHidden=NO;
            }
            [blockSelf showResultThenHide:@"没有更多了"];
        }
        if (refreshSuccess) {
            refreshSuccess();
        }
    };
    
    RequestFailure requestFailureBlock = ^(NSInteger errorCode, NSString *errorMessage){
        [blockSelf.contentScrollView.footer endRefreshing];
        //[blockSelf alertViewTitleMessage:errorMessage];
        blockSelf.isTipsViewHidden = ([blockSelf.dataArray count] > 0);//判断总的数组是否为空
        if (refreshFailer) {
            refreshFailer();
        }
    };
//    if (requestType==RequestTypeGET) {
//        [WTRManager getDataWithAPI:[self methodWithPath]
//                     withDictParam:[self dictParamWithPage:self.currentPageIndex+1]
//                     withModelName:[self modelOfName]
//                           isModel:YES
//                  requestSuccessed:requestSuccessed
//                     requestFailer:requestFailureBlock];
//        
//    }else if(requestType==RequestTypePOST){
//        
//        [WTRManager postDataWithAPI:[self methodWithPath]
//                      withDictParam:[self dictParamWithPage:self.currentPageIndex+1]
//                      withModelName:[self modelOfName]
//                            isModel:YES
//                   requestSuccessed:requestSuccessed
//                      requestFailer:requestFailureBlock];
//    }
}

//正常刷新
- (void)refreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer{
    [self refreshBlocks:refreshSuccess andRefreshFailer:refreshFailer withRequestType:RequestTypeGET];
}
- (void)refreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer withRequestType:(RequestType) requestType{
    WeakSelfType blockSelf=self;
    RequestSuccessed requestSuccessed= ^(id responseObject){
        //停止刷新
        [blockSelf.contentScrollView.header endRefreshing];
        [blockSelf hideHUDLoading];
        NSArray *dataArray=nil;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            dataArray=(NSArray *)responseObject;
        }else if([responseObject isKindOfClass:[BaseDataModel class]]){
            dataArray = @[responseObject];
        }
        //2. 根据组装后的数组刷新列表
        NSArray *newDataArray = nil;
        if ([dataArray count] > 0) {
            newDataArray = [blockSelf preProcessData:dataArray];
        }
        blockSelf.isTipsViewHidden = ([newDataArray count] > 0);
        if ([newDataArray count] > 0) {
//            [blockSelf reloadByReplacing:newDataArray];
        }
        else {
            //清空已有的数据
            [blockSelf.dataArray removeAllObjects];
        }
        if (refreshSuccess) {
            refreshSuccess();
        }
        [blockSelf reloadData];
    };
    RequestFailure requestFailure=^(NSInteger index,NSString *errorMessage){
        [blockSelf.contentScrollView.header endRefreshing];
        //[blockSelf alertViewTitleMessage:errorMessage];
        blockSelf.isTipsViewHidden = ([blockSelf.dataArray count] > 0);//判断总的数组是否为空
    };
//    if (requestType==RequestTypeGET) {
//        [WTRManager getDataWithAPI:[self methodWithPath]
//                     withDictParam:[self dictParamWithPage:0]
//                     withModelName:[self modelOfName]
//                           isModel:YES
//                  requestSuccessed:requestSuccessed
//                     requestFailer:requestFailure];
//    }
//    else if(requestType==RequestTypePOST){
//        [WTRManager postDataWithAPI:[self methodWithPath]
//                      withDictParam:[self dictParamWithPage:0]
//                      withModelName:[self modelOfName]
//                            isModel:YES
//                   requestSuccessed:requestSuccessed
//                      requestFailer:requestFailure];
//    }
}
- (NSString *)methodWithPath{
    return @"";
}
- (NSDictionary *)dictParam{
    return @{};
}

- (NSDictionary *)dictParamWithPage:(NSInteger)page{
    return @{};
}
- (NSArray *)preProcessData:(NSArray *)anArray{
    return anArray;
}
//是否已经来就开始刷新
- (BOOL)shouldEnableRefresh{
    return YES;
}
//是否加载更多刷新
- (BOOL)loadMoreEnable{
    return YES;
}
//是否开启刷新功能
-(BOOL)refreshEnable{
    return YES;
}
- (NSUInteger)cellCount{
    return self.dataArray.count;
}
- (NSString *)nibNameOfCell{
    return @"";
}
- (NSString *)modelOfName{
    return @"";
}
- (NSString *)hitWhenEndData{
    return @"暂时没有内容";
}
- (BOOL)tipsViewEnable{
    return YES;
}
- (BOOL)isEnableButton{
    return YES;
}
- (UIScrollView *)contentScrollView{
    return nil;
}

- (void)reloadData{
    
}

- (UIView *)layoutCellWithData:(id)object atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (void)clickedCell:(id)object atIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)shouldCacheArray{
    return NO;
}
//下拉刷新特有的缓存加载方法被基类的loadCache方法调用
//- (NSArray *)loadCacheArray {
//    NSArray *cachedArray = [self cachedObjectForKey:KeyOfCachedArray];
//    if ([cachedArray isKindOfClass:[NSArray class]] && [NSArray isNotEmpty:cachedArray]) {
//        return cachedArray;
//    }
//    else { //没有缓存内容
//        return nil;
//    }
//}
//
//- (void)reloadByReplacing:(NSArray *)anArray{
//    [self.dataArray removeAllObjects];
//    [self.dataArray addObjectsFromArray:anArray];
//    //同意缓存数据
//    if ([self shouldCacheArray]) {
//        [self saveObject:anArray forKey:KeyOfCachedArray];
//    }
//}
- (void)reloadByAdding:(NSArray *)anArray{
    
    
}

@end
