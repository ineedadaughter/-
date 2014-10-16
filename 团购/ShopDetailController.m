//
//  ShopDetailController.m
//  团购
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailController.h"
#import "Deal.h"

@implementation ShopDetailController
{
    UIWebView *_webView;
    UIView *_cover;
}
@synthesize deal = _deal;



- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.backgroundColor = [UIColor clearColor];
    self.view = _webView;
    _webView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cover = [[UIView alloc] initWithFrame:_webView.bounds];
    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _cover.backgroundColor = [UIColor whiteColor];
    [_webView addSubview:_cover];
    
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    act.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    act.center = CGPointMake(250, _cover.frame.size.height/2);
    [_cover addSubview:act];
    [act startAnimating];
    NSString *Id = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/shoplist/%@",Id];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //删除webView中scrollView的自带图片
    for (UIView *view in webView.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    //移出遮盖
    [_cover removeFromSuperview];
    _cover = nil;
    //给额外的区域
    webView.scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0 );
    //偏移区域
    webView.scrollView.contentOffset = CGPointMake(0, -70);
    
    
}

@end
