//
//  ShoppingMenuButton.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShoppingMenuButton.h"

@implementation ShoppingMenuButton
@synthesize district = _district;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setDistrict:(District *)district
{
    _district = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}

-(NSArray *)titles
{
    return _district.neighborhoods;
}

@end
