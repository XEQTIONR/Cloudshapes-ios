//
//  CSMapViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-30.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSMapViewController.h"

@interface CSMapViewController ()

@end

@implementation CSMapViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    [[self locationManager] setDelegate:self]; // so TestMapViewController receives CLLocationManager delegate messages
    
    
    // for backward compatibility with iOS7
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        NSLog(@"respondstoSelector: requestWhenInUseAuthrorization");
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    
    //[[self mapView] setShowsUserLocation:YES];
    self.mapView.delegate = self;  // so TestMapViewController receives MKMapView delegate messages.
    self.mapView.showsUserLocation = YES;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"NEW LOCATION:");
    NSLog(@"%@", [locations lastObject]);
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D userCoordinates = [userLocation coordinate];
    
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(userCoordinates, 1000, 1000);
    [self.mapView setRegion:zoomRegion animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"locationManager:didChangeAuthorizationStatus works.");
    
    //if(status == requestWhenInUseAuthorization)
    
    NSLog(@" status =%d", status);
    NSLog(@"wheninUse =%d", kCLAuthorizationStatusAuthorizedWhenInUse);
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [[self locationManager] startUpdatingLocation];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    /*this method is called to for each annotation to be displayed on the map
    MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    
    //NSLog(@"viewForAnnotation called");
    
    if (annotation==[self.mapView userLocation]) {
        
        NSLog(@"Found user location");
    }
    annotationView.pinColor = MKPinAnnotationColorGreen;
    
    return annotationView;
*/
    return nil;
}

/*- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSLog(@"Current  location is NIL");
    }
}*/
@end
