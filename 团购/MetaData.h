//
//  MetaData.h
//  团购
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Order.h"

@class City;
@interface MetaData : NSObject

singleton_interface(MetaData)
//管理所有城市数据
@property (nonatomic,readonly,strong)NSArray *allCitySections;//不用NSMutableArray，避免外界修改
@property (nonatomic, strong) City *currentCity;

@property (nonatomic, strong) NSString *currentCategory;//当前选中的类别
@property (nonatomic, strong) NSString *currentDistrict;//当前选中的区
@property (nonatomic, strong) Order *currentOrder;

@property (nonatomic, strong, readonly) NSDictionary *totalCities;
//管理所有分类
@property (nonatomic,strong,readonly)NSArray *allCategories;
//所有排序数据
@property (nonatomic,strong,readonly)NSArray *allOrders;

- (Order *)orderToName:(NSString *)name;
- (void)addCityData;
- (void)addCategoryData;
- (void)addOrderData;

@end
