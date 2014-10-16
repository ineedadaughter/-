//
//  OrderMenuBttton.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OrderMenuBttton.h"

@implementation OrderMenuBttton

@synthesize order = _order;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setOrder:(Order *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}


@end
