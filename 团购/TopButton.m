//
//  TopButton.m
//  团购
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#define SCALE 0.8
#import "TopButton.h"

@implementation TopButton
@synthesize title = _title;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        
        //设置图片居中模式
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        //不设置高亮状态
        self.adjustsImageWhenHighlighted = NO;
        //分割线
        UIImageView *lineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"separator_topbar_item.png"]];
        lineImage.center = CGPointMake(kTopMenuButtonW, kTopMenuButtonH * 0.5);
        [self addSubview:lineImage];
        
        //选中背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"bgTop"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuButtonW, kTopMenuButtonH);
    [super setFrame:frame];
}


//下面的两个方法返回按钮文字和图片的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
   return CGRectMake(0, 0, kTopMenuButtonW * SCALE, kTopMenuButtonH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(kTopMenuButtonW * SCALE, 0, kTopMenuButtonW * (1 - SCALE), kTopMenuButtonH);
}

@end
