//
//  MapViewController.m
//  团购
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DealPosAnnotation.h"
#import "Business.h"
#import "DPAPI.h"
#import "Deal.h"
#import "NSObject+Value.h"
#import "WebCach.h"


@implementation MapViewController
{
    MKMapView *map;
    MKUserLocation *myLocation;
    Deal *deall;
    WebCach *imageView;
}
@synthesize deals = _deals;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"地图";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    
    //添加地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(150, self.view.frame.size.height -60-44, 60, 60)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.layer.cornerRadius = 30.0;
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changecurrentView)];
    [view addGestureRecognizer:tap];
    
    imageView = [[WebCach alloc] init];
    _deals = [NSMutableArray array];
    [self.view addSubview:mapView];
    [self.view addSubview:view];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_mapView) {
        return;
    }
    map = mapView;
    myLocation = userLocation;
    //设置默认伸缩区域
    //中心点
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    //跨度范围
    MKCoordinateSpan span = MKCoordinateSpanMake(0.006454, 0.009913);
    
    //区域
    MKCoordinateRegion  region=  MKCoordinateRegionMake(center, span);
    
    //设置区域
    [mapView setRegion:region animated:YES];
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    _mapView = mapView;
}

- (void)changecurrentView
{
    [map setCenterCoordinate:myLocation.location.coordinate animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
    static BOOL isFirst =true;
    
    if (isFirst)
    {
        isFirst = false;
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"苏州",@"city",[NSNumber numberWithFloat: myLocation.location.coordinate.latitude],@"latitude",[ NSNumber numberWithFloat:myLocation.location.coordinate.longitude],@"longitude", nil];
//        NSLog(@"%@",params);
//        NSLog(@"=====%f--%f",position.latitude,position.longitude);
        [[DPAPI sharedDPAPI] requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
        
    }
    else
    {
        //地图当前展示区域的中心
        CLLocationCoordinate2D position = mapView.region.center;
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"苏州",@"city",[NSNumber numberWithFloat: position.latitude],@"latitude",[ NSNumber numberWithFloat:position.longitude],@"longitude", nil];
        [[DPAPI sharedDPAPI] requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    }

    //请求网络
}

#pragma mark - 请求网络代理方法
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{

        NSArray *array = [result objectForKey:@"deals"];

        
    for (NSDictionary *dic in array) {
        Deal *deal = [[Deal alloc]init];
        [deal setValues:dic];
        [_deals addObject:deal];
        
    }
 
    
        for (Deal *d in _deals) {

            for (Business *b in  d.businesses) {
                DealPosAnnotation *annotation = [[DealPosAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                
                [map addAnnotation:annotation];
                
            }
            
            
        }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //从缓存池中取出大头针view
    NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];



    }
    return annotationView;
}


#pragma mark - 监听区域经纬度的改变
//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
//{
//    NSLog(@"%f---%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
//}


@end
