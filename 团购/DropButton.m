//
//  DropButton.m
//  团购
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DropButton.h"
#import "FoodCategory.h"

#define kScale 0.3

@implementation DropButton
@synthesize category = _category;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        

        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

-(void)setCategory:(FoodCategory *)category
{
    _category = category;
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];

    [self setTitle:category.name forState:UIControlStateNormal];
}

-(NSArray *)titles
{
    return _category.subcategories;
}

#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleHeight = contentRect.size.height * kScale;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width,  titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kScale));
}

@end
