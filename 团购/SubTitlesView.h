//
//  SubTitlesView.h
//  团购
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^complentBlock)(NSString*);

@interface SubTitlesView : UIImageView
{
    UIButton *_selectButton;
}

@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,copy)complentBlock block;
@property(nonatomic,copy)NSString *(^getTitleBlock)();
@property(nonatomic,copy)NSString *mainTitle;

- (void)showAnimation;

- (void)hideAnimation;

@end
