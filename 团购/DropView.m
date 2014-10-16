//
//  DropView.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DropView.h"
#import "SubTitlesView.h"
#import "DealBottomMenuItem.h"
#import "SubTitlesView.h"
#import "MetaData.h"
#import "DropButton.h"
#import "ShoppingMenuButton.h"
#import "OrderMenuBttton.h"

@implementation DropView
{
    UIView *_cover;
    UIView *_contentView;
    
}
@synthesize block = _block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;;
        //增加蒙板
        
        _cover = [[UIView alloc] init];
        _cover.frame = self.bounds;
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAnimation)];
        [_cover addGestureRecognizer:tap];
        _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_cover];
        
        //增加内容
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kDropButtonH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        //增加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width,kDropButtonH);
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.backgroundColor = [UIColor lightGrayColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

//所有子类的button都调用这个方法
- (void)buttonAction:(DealBottomMenuItem *)button
{
    //控制button状态
    selectButton.selected = NO;
    button.selected = YES;
    selectButton = button;
    
    //查看是否有子分类
    if (button.titles.count) //显示子标题
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        if (_subTitlesView == nil) {
            _subTitlesView = [[SubTitlesView alloc]init];
            
            [self setSubTitlesView];
        }
        
        _subTitlesView.frame = CGRectMake(0, kDropButtonH, self.frame.size.width, _subTitlesView.frame.size.height);
        
        //当前文字
        _subTitlesView.mainTitle = [button titleForState:UIControlStateNormal];
        
        //设置要显示的标题
        _subTitlesView.titles = button.titles;


        //当没有子标题视图的父视图时才调用动画
        if (_subTitlesView.superview == nil) {
            [_subTitlesView showAnimation];
        }
        //        [self addSubview:_subTitlesView];
        
        CGRect frame = _contentView.frame;
        frame.size.height = kDropButtonH + _subTitlesView.frame.size.height;
        _contentView.frame = frame;
        
        
        //添加到_scrollView的下面，避免遮住
        [_contentView insertSubview:_subTitlesView belowSubview:_scrollView];
        
        [UIView commitAnimations];
    }
    else//隐藏子分类
    {
        [_subTitlesView hideAnimation];
        CGRect frame = _contentView.frame;
        frame.size.height = kDropButtonH;
        _contentView.frame = frame;
        //如果没有子标题就隐藏
        [self hideAnimation];

        //通过get方法到MetaData的set方法中运行
        if ([button isKindOfClass:[DropButton class]]) {
            [MetaData sharedMetaData].currentCategory = [button titleForState:UIControlStateNormal];
        }
         else if ([button isKindOfClass:[ShoppingMenuButton class]]) {
            [MetaData sharedMetaData].currentDistrict = [button titleForState:UIControlStateNormal];
        }
        else {
            [MetaData sharedMetaData].currentOrder = [[MetaData sharedMetaData] orderToName:[button titleForState:UIControlStateNormal]];
        }
    }
}

- (void)setSubTitlesView{}

//显示动画
- (void)showAnimation
{   
    //先向上横移kDropButtonH
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _cover.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^() {
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = 0.4;
    }];
}

- (void)hideAnimation
{
    if (_block) {
        _block();
    }
    
    [UIView animateWithDuration:0.4 animations:^() {
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        _contentView.alpha = 0 ;
        _cover.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = 0.4;

    }];
    
}

@end
