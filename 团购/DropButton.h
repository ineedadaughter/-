//
//  DropButton.h
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealBottomMenuItem.h"

@class FoodCategory;
@interface DropButton : DealBottomMenuItem
@property (nonatomic,strong)FoodCategory *category;

@end
