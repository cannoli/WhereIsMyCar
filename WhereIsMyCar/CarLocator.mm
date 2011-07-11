//
//  CarLocator.mm
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 Indiefoodies. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "CarLocator.h"


@implementation CarLocator
@synthesize coreManager;

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
        coreManager = [[CLLocationManager alloc] init];
        coreManager.delegate = self;
    }
    return self;
}

- (void) dealloc
{
    [coreManager release];
    [super dealloc];
}

- (void) startUpdating
{
    coreManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    coreManager.distanceFilter = 500;
    
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
    }
    // else skip the event and process the next one.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location error: %@",error.localizedDescription);
}

@end
