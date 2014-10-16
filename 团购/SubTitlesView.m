//
//  SubTitlesView.m
//  团购
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SubTitlesView.h"
#import "MetaData.h"
#define kTitleW 100
#define kTitleH 40

@implementation SubTitlesView

@synthesize titles = _titles;//所有子标题
@synthesize block = _block; 
@synthesize getTitleBlock = _getTitleBlock;
@synthesize mainTitle = _mainTitle;//当前子标题的父标题

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        self.clipsToBounds = YES;
        //设置可以点击
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"全部"];
    [array addObjectsFromArray:titles];
    _titles = array;

    int count = _titles.count;
    for (int i  = 0; i < count; i++) {//button不够，创建新的，有多的直接用
        UIButton *btn= nil;
        if (i >= self.subviews.count) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];

            //设置大小
            btn.bounds = CGRectMake(0, 0, kTitleW, kTitleH);
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_subfilter_other"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:btn];
        }
        else
        {
            btn = [self.subviews objectAtIndex:i];
        }
        btn.hidden = NO;
        //设置按钮文字
        [btn setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
        
        //避免重复选中
        if (_getTitleBlock) {
            NSString *string = _getTitleBlock();
            
            //选中主标题
            if ([string isEqualToString:_mainTitle] && i == 0) {
                btn.selected = YES;
                _selectButton = btn;
            }
            else
            {
                btn.selected = [[_titles objectAtIndex:i] isEqualToString:string];
                if (btn.selected) 
                {
                    _selectButton = btn;
                }
            }

        }
        
        
    }
    //隐藏多余的按钮
    for (int i= count; i < self.subviews.count; i++) {
        UIButton *btn = [self.subviews objectAtIndex:i];
        btn.hidden = YES;
    }
    [self layoutSubviews];
    
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];全部销毁
}

//监听点击小标题点击事件
- (void)chooseAction:(UIButton *)button
{
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    //用titleForState拿到button的title
//    [MetaData sharedMetaData].currentCategory = [button titleForState:UIControlStateNormal];
    if (_block) {
        
        NSString *title = [button titleForState:UIControlStateNormal];
        if ([title isEqualToString:@"全部"]) {
            title = _mainTitle;
        }
        _block(title);
    }


}

//自身宽高发生改变的时候调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int columns = self.frame.size.width/kTitleW;
    for (int i = 0; i <_titles.count; i++) {
        
        UIButton *btn = [self.subviews objectAtIndex:i];
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH); 
    }

    
//    [UIView animateWithDuration:0.3 animations:^() {
        int rows = (_titles.count + columns - 1)/columns;//行数
        CGRect frame = self.frame;
        frame.size.height = kTitleH * rows;
        
        //创建视图的frame
        self.frame = frame;
//    }];
}

- (void)showAnimation
{
    //强制先拿到高度
    [self layoutSubviews];
    //先向上横移kDropButtonH
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^() {
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hideAnimation
{

    [UIView animateWithDuration:0.4 animations:^() {
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        CGRect frame = self.frame;
        frame.size.height = 0;
        self.frame = frame;
        
        [self removeFromSuperview];
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

@end
