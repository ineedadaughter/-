//
//  DropView.h
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^hideBlock)();
@class SubTitlesView,DealBottomMenuItem;
@interface DropView : UIView
{
    UIScrollView *_scrollView;
    SubTitlesView *_subTitlesView;
    DealBottomMenuItem *selectButton;
}

@property (nonatomic,copy)hideBlock block;

- (void)showAnimation;

- (void)hideAnimation;

- (void)setSubTitlesView;

@end
