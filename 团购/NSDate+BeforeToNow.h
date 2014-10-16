//
//  NSDate+BeforeToNow.h
//  团购
//
//  Created by  on 14-10-6.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BeforeToNow)

+(NSDateComponents *)compareFromDate:(NSDate *)from to:(NSDate *)to;

-(NSDateComponents *)compareWith:(NSDate *)other;

@end
