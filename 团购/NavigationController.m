//
//  NavigationController.m
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

//写在这个类中只会调用一次里面的方法，写在viewDidLoad中会调用4次（看创建多少次）
+(void)initialize
{
    
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"img.png"] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏文字的主题
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetZero],UITextAttributeTextShadowOffset , nil]];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *btn = [UIBarButtonItem appearance];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    //修改item上的文字样式
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetZero],UITextAttributeTextShadowOffset,[UIFont systemFontOfSize:16],UITextAttributeFont, nil];
    [btn setTitleTextAttributes:dic forState:UIControlStateNormal];
    [btn setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    
    
    //设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}


@end
