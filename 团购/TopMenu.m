//
//  TopMenu.m
//  团购
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TopMenu.h"
#import "TopButton.h"
#import "DropView.h"
#import "CategoryMenu.h"
#import "ShoppingMenu.h"
#import "OrderMenu.h"
#import "MetaData.h"

@implementation TopMenu
{
    TopButton *lastSelect;
    CategoryMenu *drop1;
    ShoppingMenu *drop2;
    OrderMenu *drop3;
    DropView *_showMenu;//之前显示的菜单
    
    TopButton *_districtBtn;
    TopButton *_categoryBtn;
    TopButton *_orderBtn;
}
@synthesize contentView = _contentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _categoryBtn = [[TopButton alloc]init];
        _categoryBtn.title = @"全部分类";
        _categoryBtn.tag = 1;
        [_categoryBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_categoryBtn];
        
        _districtBtn = [[TopButton alloc]init];
        _districtBtn.title = @"全部商区";
        _districtBtn.tag = 2;
        _districtBtn.frame = CGRectMake(kTopMenuButtonW, 0, 0, 0);
        [_districtBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_districtBtn];
        
        _orderBtn = [[TopButton alloc]init];
        _orderBtn.title = @"默认排序";
        _orderBtn.tag = 3;
        _orderBtn.frame = CGRectMake(kTopMenuButtonW * 2, 0, 0, 0);
        [_orderBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_orderBtn];
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:@"cityChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:@"districtChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:@"categoryChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:@"orderChange" object:nil];
    }
    return self;
}

- (void)changeName:(TopButton *)button
{

    
    lastSelect.selected = NO;
    lastSelect = nil;
    //分类按钮
    NSString *string1 = [MetaData sharedMetaData].currentCategory;
    if (string1) {
        _categoryBtn.title = string1;
    }
    //商区按钮
    NSString *string2 = [MetaData sharedMetaData].currentDistrict;
    if (string2) {
        _districtBtn.title = string2;
    }
    //默认排序按钮
    NSString *string3 = [MetaData sharedMetaData].currentOrder.name;
    if (string3) {
        _orderBtn.title = string3;
    }
    
    [_showMenu hideAnimation];
    _showMenu = nil;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)change:(TopButton *)button
{
    
    lastSelect.selected = NO;
    if (lastSelect == button) 
    {
        lastSelect = nil;
        //隐藏底部菜单
        
        [_showMenu hideAnimation];
        //清空选中按钮
        _showMenu = nil;
    }
    else
    {
        button.selected = YES;
        lastSelect = button;
        
        
        BOOL animate = _showMenu == nil;
        //移出之前的菜单
        [_showMenu removeFromSuperview];
        
        //显示底部菜单
        if (button.tag == 1) {
            if (drop1 == nil) {
                drop1 = [[CategoryMenu alloc]init];
            }
            drop1.frame = _contentView.bounds;
            [_contentView addSubview:drop1];
            _showMenu = drop1;
        }else if (button.tag == 2){
            if (drop2 == nil) {
                drop2 = [[ShoppingMenu alloc]init];
            }
            drop2.frame = _contentView.bounds;
            [_contentView addSubview:drop2];
            _showMenu = drop2;
        }else{
            if (drop3 == nil) {
                drop3 = [[OrderMenu alloc]init];
            }
            drop3.frame = _contentView.bounds;
            [_contentView addSubview:drop3];
            _showMenu = drop3;
        }
        //执行菜单出现时的动画
        if (animate) {
            [_showMenu showAnimation];
        }
        //block取消选中
        //解决循环调用
        __unsafe_unretained TopMenu *top = self;
        _showMenu.block = ^{
            top->lastSelect.selected = NO;
            top->lastSelect = nil;
            top->_showMenu = nil;
            
        };

    
    }

}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuButtonW * 3, kTopMenuButtonH);
    [super setFrame:frame];
}

@end
