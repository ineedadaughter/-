//
//  LocationController.h
//  团购
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

- (void)addSearch;
- (void)addTableView;
- (void)tapAction;
- (void)addCity;

@end
