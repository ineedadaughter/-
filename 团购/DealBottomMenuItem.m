//
//  DealBottomMenuItem.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DealBottomMenuItem.h"

@implementation DealBottomMenuItem

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *lineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"separator_filter_item.png"]];
        lineImage.frame = CGRectMake(kDropButtonW, 0, 2, kDropButtonH * 0.7);
        lineImage.center = CGPointMake(kDropButtonW, kDropButtonH * 0.5);
        lineImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:lineImage];

        [self setBackgroundImage:[UIImage imageNamed:@"background.png"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDropButtonW, kDropButtonH);
    [super setFrame:frame];
}

-(NSArray *)titles
{
    return nil;
}

@end
