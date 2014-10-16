//
//  CollectViewController.h
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface CollectViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,addCover>
{
    NSMutableArray *_deals;
    
}

- (void)addData;

@end
