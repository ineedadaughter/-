//
//  LineLabel.m
//  团购
//
//  Created by  on 14-10-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//
//自定义添加删除线的文字

#import "LineLabel.h"

@implementation LineLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.设置颜色
    [self.textColor setStroke];
    
    // 3.画线
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    // 4.渲染
    CGContextStrokePath(ctx);
}

@end
