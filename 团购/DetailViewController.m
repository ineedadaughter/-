//
//  DetailViewController.m
//  团购
//
//  Created by  on 14-9-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Deal.h"
#import <QuartzCore/QuartzCore.h>
#import "LineLabel.h"
#import "MyButton.h"
#import "DealWebController.h"
#import "ShopDetailController.h"
#import "CollectTool.h"

@implementation DetailViewController
{
    UIImageView *imageView;
    UILabel *leftLabel;
    LineLabel *rightLabel;
    UIView *rightDock;
    MyButton *selectButton;
    DealWebController *web;
    UIView *_cover;
    ShopDetailController *shop;
    UILabel *label;
}
@synthesize deal = _deal;
@synthesize webView = _webView;
@synthesize isWeb = _isWeb;
@synthesize info = _info;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 550, 70)];
    myView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:0.7];
    [self.view addSubview:myView];
    
    //当前价格
    leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 150, 40)];
    [leftLabel setTextColor:[UIColor colorWithRed:0.32 green:0.62 blue:0.70 alpha:1.0]];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.font = [UIFont boldSystemFontOfSize:25];
    [myView addSubview:leftLabel];
    
    //过期价格
    rightLabel = [[LineLabel alloc]initWithFrame:CGRectMake(180, 15, 120, 40)];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.textColor = [UIColor grayColor];
    [myView addSubview:rightLabel];

    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"btn_share_pressed"] forState:UIControlStateHighlighted];
    btn2.frame = CGRectMake(0, 0, 37, 34);
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    
    //收藏按钮
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setImage:[UIImage imageNamed:@"ic_deal_collect"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"ic_deal_collect_pressed"] forState:UIControlStateHighlighted];
    btn3.frame = CGRectMake(0, 0, 37, 34);
    btn3.tag = 101;
    [btn3 addTarget:self action:@selector(collectDeal) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithCustomView:btn3];
    NSArray *arr = [NSArray arrayWithObjects: right1,right2, nil];
    self.navigationItem.rightBarButtonItems = arr;

    
    //购买按钮
    UIButton *buy = [[UIButton alloc] init];
    buy.frame = CGRectMake(400, 13, 138, 45);
    [buy setImage:[UIImage imageNamed:@"btn_buy"] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buySomeThing) forControlEvents:UIControlEventTouchUpInside];
    [buy setImage:[UIImage imageNamed:@"btn_buy_pressed"] forState:UIControlStateHighlighted];
    [myView addSubview:buy];
    

    rightDock  = [[UIView alloc] initWithFrame:CGRectMake(505, 170, 45, 450)];
    rightDock.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rightDock];
    //添加按钮
    [self setRightDock:@"btn_dealinfo" andSelect:@"btn_dealinfo_pressed" andIndex:0];    
    [self setRightDock:@"btn_dealweb" andSelect:@"btn_dealweb_pressed" andIndex:1];
    [self setRightDock:@"btn_merchant" andSelect:@"btn_merchant_pressed" andIndex:2];
    
    //添加3个视图控制器
    [self addAllChildViewController];
    
    //默认选中第一个视图控制器
    UIViewController *new = [self.childViewControllers objectAtIndex:0];
    new.view.frame = CGRectMake(0, 0,505, self.view.frame.size.height);
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:new.view atIndex:0];
    MyButton *firstBtn = (MyButton *)[rightDock viewWithTag:1000];
    firstBtn.enabled = NO;
    selectButton = firstBtn;

    [self.view bringSubviewToFront:myView];
    
    //添加载入动画
    imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"20081102124624-1932814988.jpg"];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(220, 300, 100, 62);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [animation setToValue:[NSNumber numberWithFloat:M_PI*2]];
    [animation setDuration:0.8];
    [animation setRepeatCount:1000];
    [imageView.layer addAnimation:animation forKey:nil]; 
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:imageView];
    
    CGRect frame = self.view.frame;
    frame.size.width = 550;
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - 收藏点击事件
- (void)collectDeal
{
    label = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 100, 40)];
    
    UIButton *btn = (UIButton *)[[self.navigationItem.rightBarButtonItems objectAtIndex:1] customView];
    if (_deal.collected) { // 取消
        [[CollectTool share] uncollectDeal:_deal];
        [btn setImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^() {
            label.text = @"取消收藏";
            label.alpha = 1;
            label.textAlignment = UITextAlignmentCenter;
            [self.view addSubview:label];
            [self performSelector:@selector(hide) withObject:nil afterDelay:1.0];
        }];

    } else { // 收藏
        [[CollectTool share] collectDeal:_deal];
        [btn setImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^() {
            label.text = @"收藏成功";
            label.alpha = 1;
            label.textAlignment = UITextAlignmentCenter;
            [self.view addSubview:label];
            [self performSelector:@selector(hide) withObject:nil afterDelay:1.0];
        }];

    }

}

- (void)hide
{        
    [UIView animateWithDuration:0.5 animations:^() {
        label.alpha = 0;
        [label removeFromSuperview];
}];

}

- (void)addAllChildViewController
{
    _info = [[DealInfoController alloc] init];
    [self addChildViewController:_info];
    
    web = [[DealWebController alloc] init];
    [self addChildViewController:web];
    
    shop = [[ShopDetailController alloc] init];
    [self addChildViewController:shop];
}

//添加右边dock按钮
- (void)setRightDock:(NSString *)icon andSelect:(NSString *)selectedIcon andIndex:(int)index;
{

    
    MyButton *button = [[MyButton alloc] init];
    button.frame = CGRectMake(0, 0 + 140*index, 45, 165);
    button.tag = index + 1000;
    [button addTarget:self action:@selector(changeDetail:) forControlEvents:UIControlEventTouchDown];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
    [rightDock addSubview:button];
}

- (void)changeDetail:(MyButton *)button
{
    //先移出旧的控制器
    UIViewController *old = [self.childViewControllers objectAtIndex:selectButton.tag-1000];
    [old.view removeFromSuperview];
    //在添加新的控制器
    UIViewController *new = [self.childViewControllers objectAtIndex:button.tag-1000];
    new.view.frame = CGRectMake(0, 0, 505, self.view.frame.size.height);
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:new.view atIndex:0];
    
    
    selectButton.enabled = YES;
    button.enabled = NO;
    selectButton = button;
    [rightDock bringSubviewToFront:button];
}

- (void)setDeal:(Deal *)deal
{ 
    _deal = deal;
    
    //处理团购是否有值
    [[CollectTool sharedCollectTool] handleDeal:_deal];
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";    
    UIButton *btn3 = (UIButton *)[[self.navigationItem.rightBarButtonItems objectAtIndex:1] customView];
    [btn3 setImage:[UIImage imageNamed:collectIcon] forState:UIControlStateNormal];
    


    web.deal = _deal;
    shop.deal = _deal;

    //移出风火轮
    [imageView removeFromSuperview];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    
    self.title = _deal.title;

    NSString *currentPrice = [NSString stringWithFormat:@"%.2f 元",self.deal.current_price];
    [leftLabel setText:currentPrice];
    NSString *listPrice = [NSString stringWithFormat:@"%.2f 元",self.deal.list_price];
    [rightLabel setText:listPrice];  
}

- (void)buySomeThing
{
//    _cover = [[UIView alloc] initWithFrame:_webView.bounds];
//    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [_webView addSubview:_cover];
//    
//    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    act.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    act.center = CGPointMake(250, _cover.frame.size.height/2);
//    [_cover addSubview:act];
//    [act startAnimating];
    


    NSString *Id = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/buy/%@",Id];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];


    [self.view addSubview:_webView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_cover removeFromSuperview];
    _cover = nil;
    _isWeb = YES;
}

@end
