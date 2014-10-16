//
//  Restriction.h
//  团购
//
//  Created by  on 14-10-6.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restriction : NSObject

@property (nonatomic,assign) BOOL is_reservation_required; //是否需要预约，0：不是，1：是
@property (nonatomic,assign) BOOL is_refundable; //是否支持随时退款，0：不是，1：是
@property (nonatomic,assign) NSString *special_tips; //附加信息(一般为团购信息的特别提示)

@end
