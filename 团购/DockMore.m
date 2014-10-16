//
//  DockMore.m
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DockMore.h"
#import "MoreViewController.h"
#import "NavigationController.h"

@implementation DockMore
{
    BOOL change;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这个button距离顶部伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

        [self setIcon:@"ic_more.png"];
        [self setSelectedIcon:@"ic_more_hl.png"];
        
        [self addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}


- (void)moreAction
{
    //模态视图浮现设置不能点，在dismiss中设置属性，让其能点
    self.enabled = NO;
    
    MoreViewController *more = [[MoreViewController alloc]initWithStyle:UITableViewStylePlain];
    //设置button1属性为当前按钮
    more.button1 = self;
    
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:more];
    
    //模态视图FormSheet样式，因为跳转的是导航控制器所以要用导航控制器的modalPresentationStyle方法
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    //动画样式
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
