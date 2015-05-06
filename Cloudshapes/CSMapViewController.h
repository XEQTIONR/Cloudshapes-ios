//
//  CSMapViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-30.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CSMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
//@property (strong, nonatomic) NSMutableArray <MKAnnotation> *ann;

@end
