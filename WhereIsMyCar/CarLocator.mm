//
//  CarLocator.mm
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 Indiefoodies. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CarLocator.h"


@implementation CarLocator
@synthesize coreManager;
@synthesize targetMapView;
@synthesize parkedLocation;

#pragma mark -
#pragma mark Singleton
static CarLocator* singletonInstance = nil;
+ (CarLocator*) getInstance
{
	@synchronized(self)
	{
		if (!singletonInstance)
		{
			singletonInstance = [[[CarLocator alloc] init] retain];
		}
	}
	return singletonInstance;
}

+ (void) destroyInstance
{
	@synchronized(self)
	{
		[singletonInstance release];
		singletonInstance = nil;
	}
}

#pragma mark -
#pragma mark CarLocator methods
- (id) init
{
    self = [super init];
    if(self)
    {
        self.coreManager = [[CLLocationManager alloc] init];
        self.coreManager.delegate = self;
        self.targetMapView = nil;
        self.parkedLocation = nil;
    }
    return self;
}

- (void) dealloc
{
    [parkedLocation release];
    [targetMapView release];
    [coreManager release];
    [super dealloc];
}

- (void) startUpdating
{
    coreManager.desiredAccuracy = kCLLocationAccuracyBest;
    coreManager.distanceFilter = 5;
    
    [coreManager startUpdatingLocation];
}


#pragma mark -
#pragma mark CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
        MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100.0f, 100.0f);
        [targetMapView setRegion:newRegion animated:YES];
 
        // update my current parked location
        self.parkedLocation = newLocation;
        
        // now put a pin where I am parked
//        MKPinAnnotationView* newPin = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:nil];
        [targetMapView addAnnotation:self];
    }
    // else skip the event and process the next one.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location error: %@",error.localizedDescription);
}

#pragma mark -
#pragma mark MKAnnotation delegate
- (CLLocationCoordinate2D) coordinate
{
    CLLocationCoordinate2D result;
    if(parkedLocation)
    {
        result = parkedLocation.coordinate;
    }
    else
    {
        result = CLLocationCoordinate2DMake(0.0f, 0.0f);
    }
    return result;
}

@end
