//
//  NSDate+BeforeToNow.m
//  团购
//
//  Created by  on 14-10-6.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+BeforeToNow.h"

@implementation NSDate (BeforeToNow)

+(NSDateComponents *)compareFromDate:(NSDate *)from to:(NSDate *)to
{
    //日历对象 （标识符：时区标识符）
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    
    //合并标记
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    return [calendar components:flags fromDate:from toDate:to options:0];
}

-(NSDateComponents *)compareWith:(NSDate *)other
{
    return [NSDate compareFromDate:self to:other];
}

@end
