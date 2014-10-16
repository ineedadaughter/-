//
//  ItemButton.m
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ItemButton.h"

@implementation ItemButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

//点击时隐藏头部那条线
-(void)setEnabled:(BOOL)enabled
{
    self.line.hidden = !enabled;
    
    [super setEnabled:enabled];
}

@end
