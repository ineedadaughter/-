//
//  LocationButton.m
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//
#define kImageScale 0.6
#import "LocationButton.h"
#import "LocationController.h"
#import "City.h"
#import "MetaData.h"

@implementation LocationButton
{
    UIPopoverController *popover;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这个button距离顶部伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self setIcon:@"ic_district"];
        [self setSelectedIcon:@"ic_district_hl"];
        
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        //让图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //文字也要跟着图片一起变色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //让文字居中
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        
        [self addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchDown];
        
        
        //监听城市改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChange) name:@"cityChange" object:nil];

        
    }
    return self;
}

- (void)nameChange
{
    City *city = [MetaData sharedMetaData].currentCity;
    [self setTitle:city.name forState:UIControlStateNormal];
    [popover dismissPopoverAnimated:YES];
    self.enabled = YES;
}

- (void)change
{
    if ([popover isPopoverVisible]) {
        //dismiss之前的
        [popover dismissPopoverAnimated:NO];
        //创建新的0.4s后
        [self performSelector:@selector(location) withObject:nil afterDelay:0.4];
    }

}

- (void)location
{
    //以UIPopoverController显示
    LocationController *location = [[LocationController alloc]init];
    popover = [[UIPopoverController alloc]initWithContentViewController:location];
    popover.popoverContentSize = CGSizeMake(320, 480);
    popover.delegate = self;
    //或者传self.bounds 和 self
    [popover presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    //监听屏幕旋转的通知
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

//popover的代理方法，popover dismiss的时候取消通知
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//返回title的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, self.frame.size.height * kImageScale, self.frame.size.width, self.frame.size.height * (1 - kImageScale));
}

//返回image的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height * kImageScale;
    return  CGRectMake(0, 0, W, H);
}

@end
