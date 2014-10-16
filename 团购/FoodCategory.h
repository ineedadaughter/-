//
//  FoodCategory.h
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseName.h"

@interface FoodCategory : BaseName

@property (nonatomic,strong)NSArray *subcategories;
@property (nonatomic,copy)NSString *icon;

@end
