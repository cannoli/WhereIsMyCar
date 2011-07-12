//
//  CarLocator.h
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 Indiefoodies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <MapKit/MKAnnotation.h>

@class CLLocationManager;
@class MKMapView;
@interface CarLocator : NSObject<CLLocationManagerDelegate, MKAnnotation> 
{
    CLLocationManager*  coreManager;
    MKMapView*          targetMapView;
    
    CLLocation*         parkedLocation;
}
@property (nonatomic,retain) CLLocationManager* coreManager;
@property (nonatomic,retain) MKMapView*         targetMapView;
@property (nonatomic,retain) CLLocation*        parkedLocation;

+ (CarLocator*)getInstance;
+ (void) destroyInstance;

- (void) startUpdating;

@end
