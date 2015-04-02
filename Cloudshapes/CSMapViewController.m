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

- (void) setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    _mapView.delegate = self;
    
    //id <MKAnnotation> tempAnn;
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(43.6942, -79.2933);
     CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(42.9999, -79.3014);
    
    MKPointAnnotation *Pannotation1 = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *Pannotation2 = [[MKPointAnnotation alloc] init];
    
    
    
    [Pannotation1 setCoordinate:coordinate1];
    [Pannotation2 setCoordinate:coordinate2];
    //[annotation1 set]
    
    [self.mapView addAnnotation:Pannotation1];
    [self.mapView addAnnotation:Pannotation2];
    //id <MKAnnotation> tempAnn1 = coordinate1;
    //self.mapView addAnnotation:coordinate1
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    //this method is called to for each annotation to be displayed on the map
    MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    
    //NSLog(@"viewForAnnotation called");
    annotationView.pinColor = MKPinAnnotationColorGreen;
    
    return annotationView;

}
@end
