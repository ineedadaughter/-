//
//  DealWebController.h
//  团购
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Deal;

@interface DealWebController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong)Deal *deal;
@property (nonatomic,strong)UIWebView *webView;

@end
