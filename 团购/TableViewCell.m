//
//  TableViewCell.m
//  团购
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TableViewCell.h"
#import "Deal.h"
#import "WebCach.h"
#import "MyView.h"
#import "Cover.h"

@implementation TableViewCell
{
    MyView *_myView;
    int _currentDirection;
    WebCach *_imageView;
    UIButton *_button;
    UILabel *_price;
    UILabel *_priceLabel;
    UIImageView *_myImageView;
}
@synthesize label = _label;
@synthesize delagate = _delagate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDirection:(int)direction
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _currentDirection = direction;
        
//        if (_currentDirection == 3 || _currentDirection == 4) {
//            [self addheng];
//        }
//        else if(_currentDirection == 1|| _currentDirection == 2) {
//            [self addshu];
//        }
        
        //[self addheng];

    }
    return self;
}


- (void)addheng:(NSInteger)hang
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    for (int i = 0; i < hang; i++) {
        _myView = [[MyView alloc] init];
        _myView.tag = i + 100;
        _myView.frame = CGRectMake(70 + 40 * i + i * 265, 25, 200, 200);
        _myView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_myView];
        
        //添加描述
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 126, 200, 40)];
        _label.tag = i + 200;
        [_label setFont:[UIFont systemFontOfSize:14]];
        [_label setTextColor:[UIColor grayColor]];
        [_label setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        //设置自动换行
        _label.numberOfLines = 0;
        [_myView addSubview:_label];
        
        //添加图片
        _imageView = [[WebCach alloc] initWithFrame:CGRectMake(0, 0, 200, 126)];
        _imageView.tag = i + 300;
        _imageView.image = [UIImage imageNamed:@"placeholder_deal"];
        [_myView addSubview:_imageView];
        
        //添加button
        _button  = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 166, 100, 34);
        _button.tag = 400 + i;
//        [_button setBackgroundImage:[UIImage imageNamed:@"bg_button"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [_button setImage:[UIImage imageNamed:@"ic_deal_people.png"] forState:UIControlStateNormal];
        [_myView addSubview:_button];
        
        //添加价格
        _price = [[UILabel alloc] initWithFrame:CGRectMake(100, 166, 70, 34)];
        _price.tag = i + 500;
        [_price setTextAlignment:UITextAlignmentRight];
        _price.font = [UIFont boldSystemFontOfSize:18];
        [_price setTextColor:[UIColor colorWithRed:0.32 green:0.62 blue:0.70 alpha:1.0]];
        [_price setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [_myView addSubview:_price];
        
        //添加元
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 166, 30, 34)];
        [_priceLabel setText:@"元"];
        _priceLabel.textAlignment = UITextAlignmentCenter;
        [_priceLabel setFont:[UIFont systemFontOfSize:14]];
        [_priceLabel setTextColor:[UIColor grayColor]];
        [_priceLabel setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [_myView addSubview:_priceLabel];
        
        //添加徽标
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 94, 84)];
        _myImageView.tag = i + 600;
        _myImageView.backgroundColor = [UIColor clearColor];
        [_myView addSubview:_myImageView];
    }
}

/*
- (void)addshu
{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < 2; i++) {
        _myView = [[UIView alloc] init];
        _myView.tag = i + 100;
        _myView.frame = CGRectMake(50 + 40 * i + i * 265, 25, 250, 250);
        _myView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_myView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 250, 50)];
        _label.tag = i +200;
        [_myView addSubview:_label];
    }
}
*/

//
//- (void)click:(NSNotification *)notification
//{
//    NSNumber *a = (NSNumber*)[notification object];
//    _currentDirection = [a intValue];
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //去掉表示不能点击
    [super setSelected:selected animated:animated];
}

-(void)setCellWith:(NSArray*)array
{ 
    [self addheng:array.count];
    
    for (int i = 0; i< array.count; i++) 
    {
        
        Deal *dea = [array objectAtIndex:i];

        MyView *view = (MyView*)[self.contentView viewWithTag:100 + i];

        view.myid = dea.deal_id;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIntoDetail:)];
        [view addGestureRecognizer:tap];
        
        UILabel *label1 = (UILabel *)[view viewWithTag:200 +i];
        UIButton *button1 = (UIButton *)[view viewWithTag:400 + i];
        UILabel *label2 = (UILabel *)[view viewWithTag:500 +i];
        WebCach *mainImage = (WebCach *)[view viewWithTag:300 + i];
        UIImageView *little = (UIImageView *)[view viewWithTag:600 + i];
       
        label1.text = dea.desc;
        [button1 setTitle:[NSString stringWithFormat:@"%d",dea.purchase_count] forState:UIControlStateNormal];

        
        //裁剪到保留两位小数点
//        NSString *price = [[NSNumber numberWithDouble:dea.current_price] description];
//        NSUInteger location = [price rangeOfString:@"."].location;
//        if (location != NSNotFound && price.length - location > 2) {
//            price = [price substringToIndex:location+3];
//        }
        
        NSString *price = [NSString stringWithFormat:@"%.2f",dea.current_price];
        price = [price stringByReplacingOccurrencesOfString:@".00" withString:@""];
        label2.text = price;
        [mainImage setImageWithURL:[NSURL URLWithString:dea.image_url]];

        //设置当前时间，拿当前时间做比较设置徽标图片
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *today = [fmt stringFromDate:[NSDate date]];
        
        if ([dea.publish_date isEqualToString:today]) {
            little.hidden = NO;
            little.image = [UIImage imageNamed:@"ic_deal_new"];
        }else if ([dea.purchase_deadline isEqualToString:today]){
            little.hidden = NO;
            little.image = [UIImage imageNamed:@"ic_deal_soonOver"];
        }else if ([dea.purchase_deadline compare:today] == NSOrderedAscending){
            little.hidden = NO;
            little.image = [UIImage imageNamed:@"ic_deal_over"];
        }else{
            little.hidden = YES;
        }
        
    }
}

//点击事件
- (void)tapIntoDetail: (UIGestureRecognizer *)tap
{
    MyView *currentView = (MyView *)tap.view;
    NSString *idName = currentView.myid;
     
    [self.delagate addcover:idName];
    

}

@end
