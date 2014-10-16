//
//  Dock.m
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//



#import "Dock.h"
#import "DockMore.h"
#import "LocationButton.h"
#import "ItemButton.h"
#import "City.h"
#import "MetaData.h"
#import "LocationController.h"

@implementation Dock
{
    //当前被选中按钮
    ItemButton *_selectedButton;
    UIPopoverController *popover;
}

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自动伸缩,底部伸缩和右边间距的伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        //设置背景图片，平铺图片的模式
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        
        //添加logo
        [self addLogo];
        
        //添加选项标签
        [self addTabs];
        
        //添加定位
        [self addLocation];
        
        //添加更多
        [self addMore];
        
 
        

    }
    return self;
}

- (void)addTabs
{
    //添加4个标签按钮
    [self addTab:@"ic_deal" setSelectedIcon:@"ic_deal_hl" index:1];
    [self addTab:@"ic_map" setSelectedIcon:@"ic_map_hl" index:2];
    [self addTab:@"ic_collect" setSelectedIcon:@"ic_collect_hl" index:3];
    [self addTab:@"ic_mine" setSelectedIcon:@"ic_mine_hl" index:4];
    
    //底部设置分割线
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5 * kDOckItemH, kDockItemW, 4)];
    line.image = [UIImage imageNamed:@"separator_tabbar_item"];
    [self addSubview:line];
}

- (void)addTab:(NSString *)icon setSelectedIcon:(NSString *)setSelectedIcon index:(NSInteger)index
{
    ItemButton *itemButton = [[ItemButton alloc]init]; 
    //宽和高内部封装好，不用再设置
    itemButton.frame = CGRectMake(0, kDOckItemH * index, 0, 0);
    [itemButton setIcon:icon];
    [itemButton setSelectedIcon:setSelectedIcon];
    
    //UIControlEventTouchDown只需点击就会触发监听事件
    [itemButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:itemButton];
    
    itemButton.tag = index - 1;
    
    //默认选中第一个
    if (index == 1) {
        [self clickAction:itemButton];
    }
}

//监听点击事件   更换当前被选中按钮，即使更换以后也不能被重复点击
- (void)clickAction:(ItemButton *)btn
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dock:tabChangeFrom:to:)]) {
        [_delegate dock:self tabChangeFrom:_selectedButton.tag to:btn.tag];
    }

    _selectedButton.enabled = YES;
    btn.enabled = NO;
    _selectedButton = btn;
}

- (void)addLocation
{
    LocationButton *button = [[LocationButton alloc]init];
    button.tag = 11;
    button.frame = CGRectMake(0, self.frame.size.height - kDOckItemH * 2, 0, 0);
    
    //[button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

//- (void)change:(UIButton *)btn
//{
//    LocationController *location = [[LocationController alloc]init];
//    popover = [[UIPopoverController alloc]initWithContentViewController:location];
//    popover.popoverContentSize = CGSizeMake(320, 480);
//    popover.delegate = self;
//    //或者传self.bounds 和 self
//    [popover presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//    
//    //监听屏幕旋转的通知
////    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:UIDeviceOrientationDidChangeNotification object:nil];
//}
//
//- (void)nameChange
//{
//    UIButton *btn = (UIButton *)[self viewWithTag:11];
//    City *city = [MetaData sharedMetaData].currentCity;
//    btn.titleLabel.text = city.name;
//    [popover dismissPopoverAnimated:YES];
//    btn.enabled = YES;
//}

- (void)addMore
{
    DockMore *more = [[DockMore alloc]init];
    more.frame = CGRectMake(0, self.frame.size.height - kDOckItemH, 0, 0);

    [self addSubview:more];
    
}

- (void)addLogo
{
    UIImageView *logoImage = [[UIImageView alloc]init];
    logoImage.image = [UIImage imageNamed:@"ic_logo.png"];
//    logoImage.frame = CGRectMake(0, 0, 118, 56);
    
    float scale = 0.7;
    CGFloat logoW = logoImage.image.size.width * scale;
    CGFloat logoH = logoImage.image.size.height * scale;
    
    logoImage.bounds = CGRectMake(0, 0, logoW, logoH);
    logoImage.center = CGPointMake(kDockItemW*0.5, kDOckItemH*0.5);

    [self addSubview:logoImage];
    
}

#pragma mark 重写setFrame方法，内定自己的宽
-(void)setFrame:(CGRect)frame
{
    frame.size.width = kDockItemW;
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
