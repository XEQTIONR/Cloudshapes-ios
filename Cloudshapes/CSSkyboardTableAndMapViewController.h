//
//  CSSkyboardTableAndMapViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-07.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CSSkyboardTableViewCell.h"
#import "CSSkyboardTableView.h"

@interface CSSkyboardTableAndMapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet CSSkyboardTableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) UISearchController *searchController;


@property (strong, nonatomic) NSArray *posts; // our skyboard model // Should we use CORE DATA???
@property (strong, nonatomic) CSSkyboardTableViewCell *prototypeCell; // dummy cell used to calculate cell height.

@property (strong, nonatomic) NSArray *nearbyVenues; /// For Foursquare integration

@end
