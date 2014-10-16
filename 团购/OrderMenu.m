//
//  OrderMenu.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OrderMenu.h"
#import "MetaData.h"
#import "OrderMenuBttton.h"

@implementation OrderMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //在scrollView上添加
        NSArray *array = [MetaData sharedMetaData].allOrders;
        
        for (int i = 0; i < array.count; i++) {
            OrderMenuBttton *drop = [[OrderMenuBttton alloc]init];
            drop.order = [array objectAtIndex:i];
            drop.frame = CGRectMake(i * kDropButtonW, 0, 0, 0);
            
            [drop addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
            [_scrollView addSubview:drop];
            [_scrollView addSubview:drop];
            
            if (i == 0) {
                drop.selected = YES;
                selectButton = drop;
            }
        }
        _scrollView.contentSize = CGSizeMake(array.count * kDropButtonW, 0);
    }
    return self;
}


@end
