//
//  Cover.m
//  团购
//
//  Created by  on 14-9-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "Cover.h"

@implementation Cover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.alpha = 0.5;
    }
    return self;
}

+(id)cover
{
    return [[self alloc] init];
}

@end
