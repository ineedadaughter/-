//
//  CitySection.m
//  团购
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CitySection.h"
#import "City.h"
#import "NSObject+Value.h"

@implementation CitySection
@synthesize cities=_cities;
-(void)setCities:(NSMutableArray *)cities
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in cities) {
        
        //如果dic是City类型就直接退出
        if ([dic isKindOfClass:[City class]]) {
            _cities = cities;
            return;
        }
        City *city = [[City alloc] init];
        [city setValues:dic];
        [array addObject:city];
    }
    _cities = array;
}


////
//-(NSMutableArray*) city22
//{
//    return city22;
//}

@end
