//
//  MainViewController.h
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"

@interface MainViewController : UIViewController<DockDeledate>

- (void)addSubViewController;

@end
