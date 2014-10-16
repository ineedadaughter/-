//
//  Business.h
//  团购
//
//  Created by  on 14-10-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *h5_url;
@property(nonatomic,assign)int ID;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property(nonatomic,assign)NSString *name;

@end
