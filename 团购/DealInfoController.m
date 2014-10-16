//
//  DealInfoController.m
//  团购
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DealInfoController.h"
#import "Deal.h"
#import "WebCach.h"

@implementation DealInfoController
@synthesize deal = _deal;

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)addLabel
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(25, 0, 450, self.view.frame.size.height)];
    
    //添加图片
    WebCach *imageView = [[WebCach alloc] initWithFrame:CGRectMake(25, 100, 450, 280)];
    imageView.image = [UIImage imageNamed:@"placeholder_deal"];
    [imageView setImageWithURL:[NSURL URLWithString:_deal.image_url]];
    [scrollView addSubview:imageView];

    //添加文字desc
    UILabel *label = [[UILabel alloc] init];
    //size.height自动获取文本高度
    CGSize size = [_deal.desc sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(450, 10000)];
    label.numberOfLines = 0;
    label.frame = CGRectMake(25, 380, 450, size.height + 40);
    label.backgroundColor = [UIColor clearColor];
    [label setText:_deal.desc];    
    [scrollView addSubview:label];
    
    //添加分割线
    UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(25, 420+size.height, 450, 2)];
    separator.image = [UIImage imageNamed:@"separator_dotline_item"];
    [scrollView addSubview:separator];
    
    //添加文字desc
    UILabel *detail = [[UILabel alloc] init];
    //size.height自动获取文本高度
    CGSize size1 = [_deal.details sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(450, 10000)];
    detail.numberOfLines = 0;
    detail.frame = CGRectMake(25, 422+size.height, 450, size1.height + 40);
    detail.backgroundColor = [UIColor clearColor];
    [detail setText:_deal.details];
    [detail setTextColor:[UIColor grayColor]];
    [scrollView addSubview:detail];
    
    UIImageView *separator1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 462+size.height+size1.height, 450, 2)];
    separator1.image = [UIImage imageNamed:@"separator_dotline_item"];
    [scrollView addSubview:separator1];
    
    //附加信息
    UILabel *restriction = [[UILabel alloc] init];
    //size.height自动获取文本高度
    CGSize size2 = [_deal.restrictions.special_tips sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(450, 10000)];
    restriction.numberOfLines = 0;
    restriction.frame = CGRectMake(25, 464 + size.height + size1.height, 450, size2.height + 40);
    restriction.backgroundColor = [UIColor clearColor];
    [restriction setText:_deal.restrictions.special_tips];
    [restriction setTextColor:[UIColor grayColor]];
    [scrollView addSubview:restriction];
    
    UIImageView *separator2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 504+size.height+size1.height+size2.height, 450, 2)];
    separator1.image = [UIImage imageNamed:@"separator_dotline_item"];
    [scrollView addSubview:separator2];
    
    //重要通知
    UILabel *notice = [[UILabel alloc] init];
    //size.height自动获取文本高度
    CGSize size3 = [_deal.notice sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(450, 10000)];
    notice.numberOfLines = 0;
    notice.frame = CGRectMake(25, 506 + size.height + size1.height+size2.height, 450, size3.height + 40);
    notice.backgroundColor = [UIColor clearColor];
    [notice setText:_deal.notice];
    [notice setTextColor:[UIColor grayColor]];
    [scrollView addSubview:notice];
    
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(450, 546 + size.height + size1.height +size2.height+size3.height);
    [self.view addSubview: scrollView];
}


@end
