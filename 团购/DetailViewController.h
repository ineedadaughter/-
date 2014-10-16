//
//  DetailViewController.h
//  团购
//
//  Created by  on 14-9-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealInfoController.h"

@class Deal,MyButton;


@interface DetailViewController : UIViewController<UIWebViewDelegate>
{
    BOOL _isWeb;
}
@property (nonatomic,strong)Deal *deal;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,assign)BOOL isWeb;
@property (nonatomic,strong) DealInfoController *info;

- (void)setRightDock:(NSString *)icon andSelect:(NSString *)selectedIcon andIndex:(int)index;
- (void)addAllChildViewController;
- (void)changeDetail:(MyButton *)button;

@end
