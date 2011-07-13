//
//  FirstViewController.m
//  WhereIsMyCar
//
//  Created by Shu Chiun Cheah on 7/10/11.
//  Copyright 2011 Indiefoodies. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "FirstViewController.h"
#import "CarLocator.h"


@implementation FirstViewController
@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[CarLocator getInstance] setTargetMapView:self.mapView];
    mapView.delegate = [CarLocator getInstance];
    mapView.showsUserLocation = YES;
    
    // move the map to user's location
    //CLLocation* userLoc = mapView.userLocation.location;
    //MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(userLoc.coordinate, 100.0f, 100.0f);
    //[mapView setRegion:newRegion animated:YES];
        
    //[[CarLocator getInstance] startUpdating];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
