//
//  CollectTool.m
//  团购
//
//  Created by  on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

//处理收藏

#import "CollectTool.h"
#define kFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"collects.data"]

@implementation CollectTool 

singleton_implementation(CollectTool)
@synthesize collectDeals = _collectDeals;

static CollectTool *coll = nil;
+(CollectTool*)share
{
    if (coll==nil)
    {
        coll = [[CollectTool alloc] init];
        //1.加载沙盒中的收藏数据
        coll.collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        //2.初始化可变数组
        if (coll.collectDeals == nil) {
            coll.collectDeals = [NSMutableArray array];
        }
        
    }
    return coll;
}

- (id)init
{
    if (self = [super init]) {

        //1.加载沙盒中的收藏数据
        _collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        //2.初始化可变数组
        if (_collectDeals == nil) {
             _collectDeals = [NSMutableArray array];
        }
       
    }
    return self;
}
-(void)handleDeal:(Deal *)deal
{
    
    _collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    deal.collected = [_collectDeals containsObject:deal];
}

//添加收藏
- (void)collectDeal:(Deal *)deal
{
    deal.collected = YES;
    
    [_collectDeals insertObject:deal atIndex:0];
   
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kFilePath];
}

//取消收藏
- (void)uncollectDeal:(Deal *)deal
{
    deal.collected = NO;
    [_collectDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kFilePath];
}
@end
