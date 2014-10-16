//
//  Deal.m
//  团购
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "Deal.h"
#import "NSObject+Value.h"
#import "Business.h"

@implementation Deal


@synthesize deal_id = _deal_id;
@synthesize title = _title;
@synthesize desc = _desc;
@synthesize list_price = _list_price;
@synthesize current_price = _current_price;
@synthesize list_price_text = _list_price_text;
@synthesize current_price_text = _current_price_text;
@synthesize regions = _regions;
@synthesize categories = _categories;
@synthesize purchase_count = _purchase_count;
@synthesize publish_date = _publish_date;
@synthesize purchase_deadline = _purchase_deadline;
@synthesize image_url = _image_url;
@synthesize s_image_url = _s_image_url;
@synthesize deal_h5_url = _deal_h5_url;
@synthesize notice = _notice;
@synthesize details = _details;
@synthesize restrictions = _restrictions;
@synthesize collected = _collected;
@synthesize businesses = _businesses;


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_deal_id forKey:@"_deal_id"];
    [aCoder encodeObject:_image_url forKey:@"_image_url"];
    [aCoder encodeObject:_desc forKey:@"_desc"];
    [aCoder encodeDouble:_current_price forKey:@"_current_price"];
    [aCoder encodeInt:_purchase_count forKey:@"_purchase_count"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.deal_id = [aDecoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [aDecoder decodeObjectForKey:@"_image_url"];
        self.desc = [aDecoder decodeObjectForKey:@"_desc"];
        self.current_price = [aDecoder decodeDoubleForKey:@"_current_price"];
        self.purchase_count = [aDecoder decodeIntForKey:@"_purchase_count"];
    }
    return self;
}

-(void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            Business *b = [[Business alloc] init];
            [b setValues:dict];
            [temp addObject:b];
        }
        
        _businesses = temp;
        
    } else {
        _businesses = businesses;
    }
    

    
}

//约束模型，判断是否可以预约
-(void)setRestrictions:(Restriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[Restriction alloc] init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    } else 
    {
        _restrictions = restrictions;
    }
}

- (BOOL)isEqual:(Deal *)object
{
    return [object.deal_id isEqualToString:_deal_id];
}

@end
