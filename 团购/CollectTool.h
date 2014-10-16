//
//  CollectTool.h
//  团购
//
//  Created by  on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Deal.h"

@interface CollectTool : NSObject
{
    NSMutableArray *_collectDeals;
}

singleton_interface(CollectTool)
//获得所有数据信息
@property (nonatomic,strong) NSArray *collectDeals;

//添加收藏
- (void)collectDeal:(Deal *)deal;
//取消收藏
- (void)uncollectDeal:(Deal *)deal;

//判断团购是否收藏
- (void)handleDeal:(Deal *)deal;

+(CollectTool*)share;

@end
