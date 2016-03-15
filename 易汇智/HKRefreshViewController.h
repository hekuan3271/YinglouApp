//
//  HKRefreshViewController.h
//  易汇智
//
//  Created by App on 16/3/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "BaseViewController.h"
#import "EnumClass.h"

typedef void(^PullToRefreshSuccessed)(void);
typedef void(^PullToRefreshFailed)(void);
@interface HKRefreshViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *dataArray;//数据源
@property (nonatomic, assign) NSInteger currentPageIndex;   //分页的页码指针
@property (nonatomic, copy) PullToRefreshFailed failedBlock;
@property (nonatomic, copy) PullToRefreshSuccessed successBlock;

//正常刷新
- (void)refreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer;
- (void)refreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer withRequestType:(RequestType) requestType;

//刷新更多
- (void)loadMoreRefreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer;
- (void)loadMoreRefreshBlocks:(PullToRefreshSuccessed) refreshSuccess andRefreshFailer:(PullToRefreshFailed) refreshFailer withRequestType:(RequestType) requestType;
//添加新内容刷新列表
- (void)reloadByAdding:(NSArray *)anArray;


- (void)addRefreshHeadView;
- (void)addRefreshFootView;


- (NSString *)methodWithPath;                                          //接口方法
- (NSDictionary *)dictParam;
- (NSDictionary *)dictParamWithPage:(NSInteger)page;
- (NSArray *)preProcessData:(NSArray *)anArray;              //对数组进行预处理


- (BOOL)shouldEnableRefresh;                                          //界面初始化的时候是否刷新
- (BOOL)loadMoreEnable;                                                //是否开启更多刷新
- (BOOL)refreshEnable;                                                  //是否支持刷新

- (NSUInteger)cellCount;                                                 //cell的数量
- (NSString *)nibNameOfCell;                                           //cell的名称
- (NSString *)modelOfName;                                            //实体类的名称
- (NSString *)hitWhenEndData;                                        //没有数据的时候，一个文本提示
- (BOOL)tipsViewEnable;                             //当没有数据的时候是否显示tipsview（默认YES）

- (UIScrollView *)contentScrollView;
- (void)reloadData;

- (UIView *)layoutCellWithData:(id)object atIndexPath:(NSIndexPath *)indexPath;     //根据数据来布局界面
- (void)clickedCell:(id)object atIndexPath:(NSIndexPath *)indexPath;                     //cell点击事件
- (void)removeCell:(id)object atIndexPath:(NSIndexPath *)indexPath;                 //cell删除事件
- (BOOL)shouldCacheArray;      //是否缓存
- (NSArray *)loadCacheArray;
@end
