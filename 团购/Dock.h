//
//  Dock.h
//  团购
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemButton.h"

@class Dock;
@protocol DockDeledate <NSObject>

@optional
- (void)dock:(Dock *)dock tabChangeFrom:(int)from to:(int)to;

@end

@interface Dock : UIView<UIPopoverControllerDelegate>
- (void)addLogo;
- (void)addTabs;
- (void)addLocation;
- (void)addMore;
- (void)addTab:(NSString *)icon setSelectedIcon:(NSString *)setSelectedIcon index:(NSInteger)index;
- (void)clickAction:(ItemButton *)btn;

@property(nonatomic,weak)id <DockDeledate> delegate;

@end
