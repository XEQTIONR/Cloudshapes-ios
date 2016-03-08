//
//  CSSearchResultsTableViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-05-29.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSearchResultsTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Foursquare2.h"
#import "FSConverter.h"

@interface CSSearchResultsTableViewController ()<UITableViewDataSource, UITableViewDelegate,  CLLocationManagerDelegate>



@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, weak) NSOperation *lastSearchOperation;

@end

@implementation CSSearchResultsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tableView registerClass:UITableViewCellStyleDefault forCellReuseIdentifier:@"search cell"];
    
    //self.locationManager = [[CLLocationManager alloc]init];
    //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //self.locationManager.delegate = self;
    //[self.locationManager startUpdatingLocation];
    
    //self.searchRequest = [[MKLocalSearchRequest alloc]init];
    //self.searchRequest.region = self.region;
    
}


#pragma mark - NSLocationManager methods
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    self.location = newLocation;
    //[self startSearchWithString:nil];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - NSSearchResultsUpdating protcol method

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    
    NSLog(@"searchText is    %@", searchText);
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchText;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         
         self.venues = response.mapItems;
         
         //NSLog(@"Map Items : %@", response.mapItems);
         //NSLog(@"self.region :%f %f %f %f", self.region.center.latitude, self.region.center.longitude, self.region.span.latitudeDelta, self.region.span.longitudeDelta);
         if(error)
         {
             NSLog(@"error : %@", error.localizedDescription);
         }
         
         [self.tableView reloadData];
     }];

    
    

}

/*
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    

    NSLog(@"searchText is    %@", searchText);
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchText;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         NSLog(@"Map Items : %@", response.mapItems);
         //NSLog(@"self.region :%f %f %f %f", self.region.center.latitude, self.region.center.longitude, self.region.span.latitudeDelta, self.region.span.longitudeDelta);
        if(error)
        {
            NSLog(@"error : %@", error.localizedDescription);
        }
     }];

    //[self startSearchWithString:searchText];
}
*/

/*
- (void)startSearchWithString:(NSString *)string {
    
    [self.lastSearchOperation cancel];
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"LONG : %f   LAT : %f", self.location.coordinate.latitude,self.location.coordinate.latitude);
    self.lastSearchOperation = [Foursquare2
                                venueSearchNearByLatitude:@(self.location.coordinate.latitude)
                                longitude:@(self.location.coordinate.longitude)
                                query:string
                                limit:nil
                                intent:intentCheckin
                                radius:@(500)
                                categoryId:nil
                                callback:^(BOOL success, id result){
                                    if (success) {
                                        NSDictionary *dic = result;
                                        NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                        FSConverter *converter = [[FSConverter alloc] init];
                                        self.venues = [converter convertToObjects:venues];
                                        [self.tableView reloadData];
                                    } else {
                                        NSLog(@"%@",result);
                                    }
                                }];
}
 
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];//[[UITableViewCell alloc] init];
    
    //}
    MKMapItem *aVenue = self.venues[indexPath.row];
    
    cell.textLabel.text = [aVenue name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", aVenue.placemark.subThoroughfare, aVenue.placemark.thoroughfare];
    return cell;
}

- (IBAction)doneButtonTapped:(id)sender {
    [self.lastSearchOperation cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
