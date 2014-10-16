//
//  CollectViewController.m
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectTool.h"
#import "DPAPI.h"
#import "NSObject+Value.h"
#import "NavigationController.h"
#import "Cover.h"
#import "DPRequest.h"
#import "DetailViewController.h"

@implementation CollectViewController
{
    UIInterfaceOrientation deviceDirection;
    UILabel *label;
    NSMutableArray *resultArr;
    NSMutableDictionary *params;
    UITableView *_tableView;
    UIActivityIndicatorView *refreshSpinner;
    Cover *_cover;
    NavigationController *nav;
    DPRequest * request1;
    DPRequest * req;
    Deal *deal1;
    DetailViewController *detailController;
    UIImageView *imageView;
}

- (void)loadView
{
    [super loadView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addData];
    [_tableView reloadData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    [self.view addSubview:_tableView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 250;
    
    //获取当前设备的方向
    deviceDirection= self.interfaceOrientation;

    [self addData];
    [_tableView reloadData];
    self.title = @"收藏";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addData];
    [_tableView reloadData];
    [super viewWillAppear:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return resultArr.count;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //调用cell内部的init方法
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier withDirection:deviceDirection];
        cell.delagate=self;
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
    
    
    //    Deal *d = [_deals objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - 频幕即将旋转的时候调用（控制器监听旋转）
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"screenChange" object:[NSNumber numberWithInt:self.interfaceOrientation]];
    deviceDirection = toInterfaceOrientation;
    [self addData];
    [_tableView reloadData];
    
}


- (void)addData
{
    
    NSMutableArray *arr = nil;
    resultArr = [NSMutableArray array];

    
    if (deviceDirection == 3 || deviceDirection == 4) 
    {
        [arr removeAllObjects];
        [resultArr removeAllObjects];
        
        for (int index = 0; index<[CollectTool share].collectDeals.count; index++)
        {
            if (index%3 == 0)
            {
                arr = [NSMutableArray array];
                [resultArr addObject:arr];
            }
            [arr addObject:[[CollectTool share].collectDeals objectAtIndex:index]];
        }
        
    }
    else if (deviceDirection == 1 || deviceDirection == 2)
    {
        [arr removeAllObjects];
        [resultArr removeAllObjects];
        
        for (int index = 0; index<[CollectTool share].collectDeals.count; index++)
        {
            if (index%2 == 0)
            {
                arr = [NSMutableArray array];
                [resultArr addObject:arr];
            }
            [arr addObject:[[CollectTool share].collectDeals objectAtIndex:index]];
        }
    }

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
            //            NSLog(@"title%@",deal1.title);
            //            NSLog(@"%@",deal1.details);
        }
        
        
        
    }
    
}

-(void)addcover:(NSString *)string
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
