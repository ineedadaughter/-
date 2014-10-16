//
//  CategoryMenu.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CategoryMenu.h"
#import "MetaData.h"
#import "FoodCategory.h"


@implementation CategoryMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //在scrollView上添加
        NSArray *array = [MetaData sharedMetaData].allCategories;
        
        for (int i = 0; i < array.count; i++) {
            FoodCategory *f = [array objectAtIndex:i];
            DropButton *drop = [[DropButton alloc]init];
            drop.category = f;
            drop.frame = CGRectMake(i * kDropButtonW, 0, 0, 0);
            
            [drop addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
            [_scrollView addSubview:drop];
            
            if (i == 0) {
                drop.selected = YES;
                selectButton = drop;
            }
            
        }
        _scrollView.contentSize = CGSizeMake(array.count * kDropButtonW, 0);
    }
    return self;
}


//重写父类hideAnimation方法
-(void)hideAnimation
{
    [super hideAnimation];
    [_subTitlesView hideAnimation];
}

-(void)setSubTitlesView
{
    //通过block拿到小标题的文字
    _subTitlesView.block = ^(NSString *title){
        [MetaData sharedMetaData].currentCategory = title;
    };
    _subTitlesView.getTitleBlock = ^{
        return [MetaData sharedMetaData].currentCategory;
    };
}

@end
