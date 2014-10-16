//
//  MetaData.m
//  团购
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//


//作为一个工具类，可以任意添加数据
#import "MetaData.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "City.h"
#import "FoodCategory.h"
#import "Order.h"
#import "Common.h"

@implementation MetaData
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key是城市名  value是城市对象
    
    CitySection *_visitedSection; // 最近访问的城市组数组
}
singleton_implementation(MetaData)//单例类
@synthesize allCitySections = _allCitySections;
@synthesize currentCity = _currentCity;
@synthesize totalCities = _totalCities;
@synthesize allOrders = _allOrders;
@synthesize currentCategory = _currentCategory;
@synthesize currentDistrict = _currentDistrict;
@synthesize currentOrder = _currentOrder;

@synthesize allCategories = _allCategories;
- (id)init
{
    self = [super init];
    if (self) {
        [self addCityData];
        
        [self addCategoryData];
        
        [self addOrderData];
    }
    return self;
}

- (void)addOrderData
{
    NSString *string = [[NSBundle mainBundle]pathForResource:@"Orders" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:string];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        Order *order = [[Order alloc] init];
        order.name = [array objectAtIndex:i];
        order.index = i + 1;
        [temp addObject:order];
    }
    
    _allOrders = temp;
}

- (Order *)orderToName:(NSString *)name
{
    for (Order *order in _allOrders) {
        if ([order.name isEqualToString:name]) {
            return order;
        }
    }
    return nil;
}

- (void)addCityData
{
    
    _totalCities = [NSMutableDictionary dictionary];
    // 加载plist数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Cities" ofType:@"plist"];
    NSArray *cities1 = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temp = [NSMutableArray array];
    
    //添加热门城市组
    NSMutableArray *hotCities = [NSMutableArray array];
    CitySection *hotSection = [[CitySection alloc]init];
    hotSection.name = @"热门城市";
    [temp addObject:hotSection];
    
    for (NSDictionary *dic in cities1) 
    {
        CitySection *citySection = [[CitySection alloc]init]; 
        [citySection setValues:dic];
        [temp addObject:citySection];
        //添加热门city
        for (City *city in citySection.cities) 
        {
            if (city.hot) 
            {
                [hotCities addObject:city];
            }
            [_totalCities setObject:city forKey:city.name];
        }
    }
    hotSection.cities = hotCities;
    
    // 从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"visitedCityNames.data"]];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 添加最近访问城市组
    CitySection *visitedSection = [[CitySection alloc]init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    //        [temp insertObject:visitedSection atIndex:0];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        City *city = [[City alloc]init];
        [visitedSection.cities addObject:city];
        
    }
    
    
    _allCitySections = temp;
}

//加载分类数据
- (void)addCategoryData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temp = [NSMutableArray array];
    
    //添加全部分类
    FoodCategory *all = [[FoodCategory alloc] init];
    all.name = @"全部分类";
    all.icon = @"ic_filter_category_-1";
    [temp addObject:all];
    
    for (NSDictionary *dic in array) {
        FoodCategory *f = [[FoodCategory alloc]init];
        [f setValues:dic];
        [temp addObject:f];
    }
    _allCategories = temp;
}

- (void)setCurrentCity:(City *)currentCity
{
    _currentCity = currentCity;
    
    //城市改变后修改当前商区
    _currentDistrict = @"全部商区";
    
    // 1.移除之前的城市名
//    [_visitedCityNames removeObject:currentCity.name];
    
    // 2.将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 3.将新的城市放到_visitedSection的最前面
//    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];

    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"visitedCityNames.data"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChange" object:nil];
   
}

-(void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryChange" object:nil];
}

- (void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"districtChange" object:nil];
}

- (void)setCurrentOrder:(Order *)currentOrder
{
    _currentOrder = currentOrder;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderChange" object:nil];
}

@end
