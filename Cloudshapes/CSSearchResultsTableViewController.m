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

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //NSString *searchString = searchController.searchBar.text;
    //NSLog(@"searchString is    %@", searchString);
    //[self startSearchWithString:searchString];
    //startSearchWithString calls self.tableview reloadData
}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *cellIdentifier = @"search cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //if (!cell)
    //{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //}
    cell.textLabel.text = [self.venues[indexPath.row] name];
    return cell;
}

- (IBAction)doneButtonTapped:(id)sender {
    [self.lastSearchOperation cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
