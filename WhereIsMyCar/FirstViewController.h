//
//  FirstViewController.h
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;
@interface FirstViewController : UIViewController 
{
    MKMapView* mapView;
}
@property (nonatomic,retain) IBOutlet MKMapView* mapView;

@end
