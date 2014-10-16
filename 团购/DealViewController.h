//
//  DealViewController.h
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPRequest.h"
#import "PullRefreshTableViewController.h"
#import "PullTableView.h"
#import "TableViewCell.h"


//@interface DealViewController : UIViewController<DPRequestDelegate>
//@interface DealViewController : UITableViewController<DPRequestDelegate>
@interface DealViewController : UIViewController<DPRequestDelegate,UIScrollViewDelegate,PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,addCover>
{
    NSMutableArray *_deals;
    
}


@property(nonatomic,assign)UIInterfaceOrientation uiint;

- (void)addData;

- (void)addDictionary:(NSInteger)page;

- (void)refreshTable;

@end
