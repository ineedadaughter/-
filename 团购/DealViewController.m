//
//  DealViewController.m
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DealViewController.h"
#import "TopMenu.h"
#import "DPAPI.h"
#import "MetaData.h"
#import "City.h"
#import "Deal.h"
#import "NSObject+Value.h"
#import "Order.h"
#import "Cover.h"
#import "DetailViewController.h"
#import "NavigationController.h"


@implementation DealViewController
{
    UIInterfaceOrientation deviceDirection;
        UILabel *label;
    NSMutableArray *resultArr;
    NSMutableDictionary *params;
    PullTableView *_tableView;
    UIActivityIndicatorView *refreshSpinner;
    Cover *_cover;
    NavigationController *nav;
    DPRequest * request1;
    DPRequest * req;
    Deal *deal1;
    DetailViewController *detailController;
    UIImageView *imageView;

}
@synthesize uiint = _uiint;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.pullDelegate = self;
    [self.view addSubview:_tableView];

}

- (void)screenChange: (NSNotification *)notification
{
    _uiint = [[notification object] intValue];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self addData];
//    [_tableView reloadData];
//    [super viewWillAppear:YES];
//}
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"cityChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"districtChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"categoryChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"orderChange" object:nil];
    
//    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    //右边搜索
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 0, 220, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    searchBar.placeholder = @"搜索: 商品名称、地址";
    //左边按钮 
    TopMenu *topMenu = [[TopMenu alloc]init];
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:topMenu];
    //不显示分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 250;

    //获取当前设备的方向
    deviceDirection= self.interfaceOrientation;
    _deals = [NSMutableArray array];
//    
//    refreshSpinner.frame = CGRectMake(100, -40, 20, 20);
//    [_tableView addSubview:refreshSpinner];
    
    //默认选中上海
    [MetaData sharedMetaData].currentCity = [[MetaData sharedMetaData].totalCities objectForKey:@"苏州"];

}

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static int page = 1;

- (void)dataChange
{
//    _deals = [NSMutableArray array];
//    DealToolURL *dealTool = [[DealToolURL alloc] init];
//    [dealTool dealWithPage:NULL success:^(NSArray *deals) {
//        [_deals addObjectsFromArray:deals];
//        [self.tableView reloadData];
//    } error:nil];

//    NSDictionary *dic = [NSDictionary dictionary];
//    dic = [NSDictionary dictionaryWithObjectsAndKeys:
//           [MetaData sharedMetaData].currentCity.name,@"city", 
//           [MetaData sharedMetaData].currentCategory,@"category",
//           [MetaData sharedMetaData].currentDistrict,@"region", 
//           [NSNumber numberWithInt:_page],@"page",
//           [NSNumber numberWithInt:[MetaData sharedMetaData].currentOrder.index],@"sort",
//           nil];
    
    //gcd只执行一次代码块
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //添加载入动画
        imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"20081102124624-1932814988.jpg"];
        [self.view addSubview:imageView];

        if ([UIDevice currentDevice].orientation == 3 || [UIDevice currentDevice].orientation == 4) 
        {
            imageView.frame = CGRectMake(400 , 300, 100, 62);
        }
        else if([UIDevice currentDevice].orientation == 1 || [UIDevice currentDevice].orientation == 2)
        {
            imageView.frame = CGRectMake(300 , 300, 100, 62);
        }

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [animation setToValue:[NSNumber numberWithFloat:M_PI*2]];
        [animation setDuration:0.8];
        [animation setRepeatCount:1000];
        [imageView.layer addAnimation:animation forKey:nil]; 
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view bringSubviewToFront:imageView];
    });

    
   
    [self addDictionary:1];
    _deals = [NSMutableArray array];
    
    request1 = [[DPAPI sharedDPAPI] requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        _tableView.contentOffset = CGPointMake(0, -80);
//
//    } completion:^(BOOL finished) {
//            [refreshSpinner startAnimating];
//            [self refreshTable];
//    }];

}

- (void)addDictionary:(int)page
{
    
    
    params = [NSMutableDictionary dictionary];
    // 1.1.添加城市参数
    NSString *city = [MetaData sharedMetaData].currentCity.name;
    [params setObject:city forKey:@"city"];
    
    // 1.2.添加区域参数
    NSString *district = [MetaData sharedMetaData].currentDistrict;
    if (district && ![district isEqualToString:@"全部商区"]) {
        [params setObject:district forKey:@"region"];
    }
    
    // 1.3.添加分类参数
    NSString *category = [MetaData sharedMetaData].currentCategory;
    if (category && ![category isEqualToString:@"全部分类"]) {
        [params setObject:category forKey:@"category"];
    }
    
    // 1.4.添加排序参数
    Order *order = [MetaData sharedMetaData].currentOrder;
    if (order) {
        [params setObject:[NSNumber numberWithInt:order.index] forKey:@"sort"];
    }
    
    //添加页码

    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    
    
}

#pragma mark - 请求网络代理方法
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    
    
    if (imageView) {
        [imageView removeFromSuperview];
    }
    if (request1 == request) {
        NSArray *array = [result objectForKey:@"deals"];
        
        for (NSDictionary *dic in array) {
            Deal *deal = [[Deal alloc]init];
            [deal setValues:dic];
            [_deals addObject:deal];

        }
        
        [self addData];
        [_tableView reloadData];
        
    }else if (req == request){                          //详细页面请求结束
        NSArray *array = [result objectForKey:@"deals"];
        
        for (NSDictionary *dic in array) {
            deal1 = [[Deal alloc]init];
            [deal1 setValues:dic];
            detailController.deal = deal1;
            detailController.info.deal = deal1;
            [detailController.info addLabel];

        }
        


    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return resultArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //调用cell内部的init方法
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier withDirection:deviceDirection];
    }
    //去掉分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //3 4代表横屏 1 2 代表竖屏
    if (deviceDirection == 3||deviceDirection == 4) 
    {
        [cell setCellWith:[resultArr objectAtIndex:indexPath.row]];
    }
    else if (deviceDirection == 1||deviceDirection == 2)
    {
        [cell setCellWith:[resultArr objectAtIndex:indexPath.row]];
    }
    
    cell.delagate=self;
//    Deal *d = [_deals objectAtIndex:indexPath.row];

    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"screenChange" object:[NSNumber numberWithInt:interfaceOrientation]];
    return YES;
}

- (void)addData
{
    
    NSMutableArray *arr = nil;
    resultArr = [NSMutableArray array];

    
//    
//    for (int index = 0; index<_deals.count; index++)
//    {
//        if (index%3 == 0)
//        {
//            arr = [NSMutableArray array];
//            [resultArr addObject:arr];
//        }
//        [arr addObject:[_deals objectAtIndex:index]];
//    }
//    
    
    if (deviceDirection == 4 || deviceDirection == 3) 
    {
        [arr removeAllObjects];
        [resultArr removeAllObjects];
        
        for (int index = 0; index<_deals.count; index++)
        {
            if (index%3 == 0)
            {
                arr = [NSMutableArray array];
                [resultArr addObject:arr];
            }
            [arr addObject:[_deals objectAtIndex:index]];
        }
        
    }
    else if (deviceDirection == 1 || deviceDirection == 2)
    {
        [arr removeAllObjects];
        [resultArr removeAllObjects];
        
        for (int index = 0; index<_deals.count; index++)
        {
            if (index%2 == 0)
            {
                arr = [NSMutableArray array];
                [resultArr addObject:arr];
            }
            [arr addObject:[_deals objectAtIndex:index]];
        }
    }
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat y = scrollView.contentOffset.y;
//    if (scrollView.contentSize.height - y - 100== self.view.frame.size.height) {
//        NSLog(@"到底部");
//    }
//}




#pragma mark - 频幕即将旋转的时候调用（控制器监听旋转）
//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self addData];
//    [_tableView reloadData];
//    
//}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    deviceDirection = toInterfaceOrientation;
    [self addData];
    [_tableView reloadData];
    
}
#pragma pullTableViewdelegate
#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
#pragma mark - Refresh and load more methods

- (void) refreshTable
{

    _tableView.pullLastRefreshDate = [NSDate date];
    _tableView.pullTableIsRefreshing = NO;
    [_tableView reloadData];
}

- (void) loadMoreDataToTable
{
    page++;

    
    [self addDictionary:page];
    
    
    request1 = [[DPAPI sharedDPAPI] requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    
    _tableView.pullTableIsLoadingMore = NO;
    
    [_tableView reloadData];
}
#pragma mark - 点击事件代理方法
- (void)addcover:(NSString *)string
{
    //增加蒙板
    if (_cover == nil) {
        _cover = [Cover cover];
    }
    [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetailFromCover)]];
    _cover.frame = self.navigationController.view.frame;
    _cover.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^() {
        _cover.alpha = 0.5;
    }];
    [self.navigationController.view addSubview:_cover];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:string forKey:@"deal_id"];
    req = [[DPAPI sharedDPAPI] requestWithURL:@"v1/deal/get_single_deal" params:dic delegate:self];
    
    //添加控制器
    detailController = [[DetailViewController alloc] init];

    //左边导航按钮
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:@"btn_nav_close"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"btn_nav_close_hl"] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(hideDetail) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(0, 0, 37, 34);
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:btn1];    
    detailController.navigationItem.leftBarButtonItem = leftBar;

    nav = [[NavigationController alloc] initWithRootViewController:detailController];
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, 550, _cover.frame.size.height);
    detailController.view.frame = CGRectMake(_cover.frame.size.width, 0, 550, _cover.frame.size.height);
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;

    
    //当两个控制器互为父子关系的时候，他们的view也是父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:0.3 animations:^() {
        nav.view.frame = CGRectMake(_cover.frame.size.width - 550, 0, 550, _cover.frame.size.height);
    }];

}

- (void)hideDetail
{
    if (detailController.isWeb) {
        [detailController.webView removeFromSuperview];
        detailController.isWeb = NO;
    } else{
        [UIView animateWithDuration:0.3 animations:^() {
            _cover.alpha = 0;
            nav.view.frame = CGRectMake(_cover.frame.size.width, 0, 550, _cover.frame.size.height);
        } completion:^(BOOL finished) {
            [_cover removeFromSuperview];
            
            [nav.view removeFromSuperview];
            [nav removeFromParentViewController];
        }];
    }

}

- (void)hideDetailFromCover
{
    [UIView animateWithDuration:0.3 animations:^() {
        _cover.alpha = 0;
        nav.view.frame = CGRectMake(_cover.frame.size.width, 0, 550, _cover.frame.size.height);
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

@end
