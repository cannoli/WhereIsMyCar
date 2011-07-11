//
//  CarLocator.h
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 Indiefoodies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@class CLLocationManager;

@interface CarLocator : NSObject<CLLocationManagerDelegate> 
{
    CLLocationManager* coreManager;
}
@property (nonatomic,retain) CLLocationManager* coreManager;

+ (CarLocator*)getInstance;
+ (void) destroyInstance;

- (void) startUpdating;

@end
