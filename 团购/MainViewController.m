//
//  MainViewController.m
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "Dock.h"
#import "CollectViewController.h"
#import "MyViewController.h"
#import "DealViewController.h"
#import "MapViewController.h"
#import "NavigationController.h"

@implementation MainViewController
{
    UIView *_contentView;
    
//    UIInterfaceOrientation uiiit;
}


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
  
    
//    This method can be used to transition between sibling child view controllers. The receiver of this method is
//    their common parent view controller.
//    [self transitionFromViewController:nil toViewController:nil duration:nil options:nil animations:nil completion:nil];
    
    Dock *dock = [[Dock alloc]init];
    
    dock.delegate = self;
    
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    
    [self.view addSubview:dock];
    
    [self addSubViewController];
    
    //在load之初就创建好一个contentView，再将视图控制器的view充满整个自动伸缩的contentView中，就不用每次点击创建，造成错误的做法
    _contentView = [[UIView alloc]init];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemW, 0, self.view.frame.size.width - kDockItemW, self.view.frame.size.height);
    [self.view addSubview:_contentView];
    
    //默认选中团购
    [self dock:nil tabChangeFrom:0 to:0];
 
    
    
}

- (void)addSubViewController
{
    DealViewController *deal = [[DealViewController alloc]init];

    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:deal];
    [self addChildViewController:nav];
    
    
    MapViewController *map = [[MapViewController alloc]init];
    

    nav = [[NavigationController alloc]initWithRootViewController:map];
    [self addChildViewController:nav];
    
    CollectViewController *collect = [[CollectViewController alloc]init];

    nav = [[NavigationController alloc]initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    MyViewController *mine = [[MyViewController alloc]init];

    nav = [[NavigationController alloc]initWithRootViewController:mine];
    [self addChildViewController:nav];
}

- (void)dock:(Dock *)dock tabChangeFrom:(int)from to:(int)to
{
    //先移出旧的控制器
    UIViewController *old = [self.childViewControllers objectAtIndex:from];
    [old.view removeFromSuperview];
    
    //添加新的控制器
    UIViewController *new = [self.childViewControllers objectAtIndex:to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
}

//自动旋转屏幕的方法
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
//    uiiit = toInterfaceOrientation; 
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"screenChange" object:[NSNumber numberWithInt:toInterfaceOrientation]];
    return YES;
}

@end
