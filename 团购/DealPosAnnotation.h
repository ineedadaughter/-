//
//  DealPosAnnotation.h
//  团购
//
//  Created by  on 14-10-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DealPosAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 

@end
