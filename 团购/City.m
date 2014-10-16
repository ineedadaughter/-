//
//  City.m
//  团购
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "City.h"
#import "District.h"
#import "NSObject+Value.h"

@implementation City
@synthesize districts = _districts;
@synthesize hot = _hot;

- (void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];

    for (NSDictionary *dic in districts) {
        District *district = [[District alloc]init];
        [district setValues:dic];
        [array addObject:district];
                     
    }
   
    _districts = array;
}

@end
