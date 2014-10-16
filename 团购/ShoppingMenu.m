//
//  ShoppingMenu.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShoppingMenu.h"
#import "MetaData.h"
#import "FoodCategory.h"
#import "ShoppingMenuButton.h"
#import "City.h"
#import "District.h"
#import "SubTitlesView.h"

@implementation ShoppingMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuButton = [NSMutableArray array];
//        
//        //在scrollView上添加
//        City *city = [MetaData sharedMetaData].currentCity;
//        
//        NSMutableArray *districts = [NSMutableArray array];
//        District *all = [[District alloc] init];
//        all.name = @"全部商区";
//        [districts addObject:all];
//        //其他商区
//        [districts addObjectsFromArray:city.districts];
//        
//        int count = districts.count;
//        
//        for (int i = 0; i < count; i++) {
//            District *d = [districts objectAtIndex:i];
//            ShoppingMenuButton *drop = [[ShoppingMenuButton alloc]init];
//            drop.district = d;
//            drop.frame = CGRectMake(i * kDropButtonW, 0, 0, 0);
//            [drop addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
//            [_scrollView addSubview:drop];
//
//            
//            if (i == 0) {
//                drop.selected = YES;
//                selectButton = drop;
//            }
//            
//        }
//        _scrollView.contentSize = CGSizeMake(count * kDropButtonW, 0);
        
        [self changeCity];
        
        //监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity) name:@"cityChange" object:nil];
    }
    return self;
}

- (void)changeCity
{

    City *city = [MetaData sharedMetaData].currentCity;
    
    NSMutableArray *districts = [NSMutableArray array];
    District *all = [[District alloc] init];
    all.name = @"全部商区";
    [districts addObject:all];
    //其他商区
    [districts addObjectsFromArray:city.districts];
    
    int count = districts.count;
    for (int i = 0; i < count; i++) {
        ShoppingMenuButton *drop = nil;
        if (i >= _menuButton.count) {
            drop = [[ShoppingMenuButton alloc]init];
            [drop addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
            [_menuButton addObject:drop];
            [_scrollView addSubview:drop];
        }
        else
        {
            drop = [_menuButton objectAtIndex:i];
        }
        drop.hidden = NO;
        District *d = [districts objectAtIndex:i];
        drop.district = d;
        drop.frame = CGRectMake(i * kDropButtonW, 0, 0, 0);


        
        if (i == 0) {
            drop.selected = YES;
            selectButton = drop;
        }else
        {
            drop.selected = NO;
        }
    }
    
    //隐藏多余的按钮
    for (int i = count; i < _menuButton.count; i++) {
        ShoppingMenuButton *btn = [_scrollView.subviews objectAtIndex:i];
        btn.hidden = YES;
    }
    
    _scrollView.contentSize = CGSizeMake(count * kDropButtonW, 0);
    //隐藏子标题
    [_subTitlesView hideAnimation];
    
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setSubTitlesView
{
    //通过block拿到小标题的文字
    _subTitlesView.block = ^(NSString *title){
        [MetaData sharedMetaData].currentDistrict = title;
    };
    _subTitlesView.getTitleBlock = ^{
        return [MetaData sharedMetaData].currentDistrict;
    };
}

@end
