//
//  City.h
//  团购
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseName.h"

@interface City : BaseName

@property(nonatomic,strong)NSArray *districts;
@property (nonatomic, assign) BOOL hot;

@end
