//
//  DockButton.m
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DockButton.h"

@implementation DockButton

@synthesize icon = _icon;
@synthesize selectedIcon = _selectedIcon;
@synthesize line = _line;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置分割线
        _line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDockItemW, 4)];
        _line.image = [UIImage imageNamed:@"separator_tabbar_item"];
        [self addSubview:_line];
        
    }
    return self;
}
//普通状态下的图片
- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

//没有高亮状态
- (void)setHighlighted:(BOOL)highlighted
{}

//设置不能选时的图片
- (void)setSelectedIcon:(NSString *)selectedIcon
{
    _selectedIcon = selectedIcon;
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}

//固定每个button的宽高
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemW, kDOckItemH);
    [super setFrame:frame];
}

@end
