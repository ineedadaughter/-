//
//  MapViewController.h
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DPRequest.h"

@interface MapViewController : UIViewController<MKMapViewDelegate,DPRequestDelegate>
{
    MKMapView *_mapView;
    
    
        
    
}

@property (nonatomic, strong)NSMutableArray *deals;

@end
