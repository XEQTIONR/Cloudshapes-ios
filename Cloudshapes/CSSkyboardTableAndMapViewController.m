//
//  CSSkyboardTableAndMapViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-07.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableAndMapViewController.h"
#import "CSSkyboardTableViewCellQuestion.h"
#import "CSSkyboardTableViewCellPoll.h"
#import "CSSearchResultsTableViewController.h"

#import "Foursquare2.h"
#import "FSConverter.h"
#import "FSVenue.h"

@interface CSSkyboardTableAndMapViewController () <UISearchBarDelegate> //UISearchResultsUpdating,UISearchControllerDelegate>


@end

@implementation CSSkyboardTableAndMapViewController



- (void)getVenuesForLocation:(CLLocation *)location {
    
    [Foursquare2 venueSearchNearByLatitude:@(location.coordinate.latitude)
                                 longitude:@(location.coordinate.longitude)
                                     query:nil
                                     limit:nil
                                    intent:intentCheckin
                                    radius:@(500)
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *dic = result;
                                          NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                          FSConverter *converter = [[FSConverter alloc]init];
                                          self.nearbyVenues = [converter convertToObjects:venues];
                                          //[self.tableView reloadData];
                                          //[self proccessAnnotations];
                                          
                                          for (FSVenue *places in self.nearbyVenues) {
                                              
                                              NSLog(@"Name : %@", places.name);
                                          }
                                          
                                      }
                                  }];
}

- (void)viewDidLoad
{
   //// NSLog(@"Skyboard TVC viewDidLoadCalled..........");
    [super viewDidLoad];
  
  /*  UIViewController *searchResultsController = [[UITableViewController alloc] init];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil ];//searchResultsController];
    searchController.searchResultsUpdater = searchResultsController;
    [searchController.searchBar sizeToFit];
    //searchController.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    if(searchController.searchBar!=nil)
        NSLog(@"SEARCH CONTROLLERs SEARCH BAR IS NOT NIL");
    self.tableView.tableHeaderView = searchController.searchBar;
    //self.definesPresentationContext = YES;
    
    //searchController.delegate =self;
    //have to set the content inset here... doesnt work in layoutSubviews after adding the search bar
    //self.tableView.contentInset = UIEdgeInsetsMake(self.mapView.bounds.size.height, 0, 0, 0);
    
   */
    
    //CSSearchResultsTableViewController *resultsController = [[CSSearchResultsTableViewController alloc] init];
    
    self.searchResultsTableView = [[CSSearchResultsTableViewController alloc] init];
    
    [self.searchResultsTableView.tableView registerClass:UITableViewCellStyleDefault forCellReuseIdentifier:@"search cell"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsTableView];
    self.searchController.searchResultsUpdater = self.searchResultsTableView;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.searchBar.delegate = self.searchResultsTableView;
    //self.searchController.searchBar.delegate = self;
    
    
    [self.view addSubview:self.searchController.searchBar];
    //self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
    if(!self.posts)
    {
        //1. gather input
        
        
        //2. encode input data, calculate length
        
        //3. init and setup request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getposts9.php"]]; //previously getskyboarddata2.php
        [request setHTTPMethod:@"POST"];
        [request setValue:0 forHTTPHeaderField:@"Content-Length"]; // currently passing no body , so length is 0(zero)
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        //4. allocate variables for URL response and  NS error
        NSHTTPURLResponse *response=nil;
        NSError *error = nil;
        
        
        //5. fire request, receive data, get HTTP Response
        NSData *skyboardPostData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:skyboardPostData options:kNilOptions error:&error]; // decoding data
        
        
        if ([response statusCode]>=200 && [response statusCode]<300)
        {
    ////        NSLog(@"response status code: %ld", [response statusCode]);
        }
        
        if (error == nil){NSLog(@"NO ERRORS");}
        
        if (jsonData == nil)
        {
   ////         NSLog(@"NIL RESULT");
        }
        else
        {
 ////          NSLog(@"%@", jsonData);
            //NSLog(@"AND R1:");      //jsonData is a NSArray -->NSDictionary previously
 ////           NSLog(@"jsonData.count = %lu", [jsonData count]);
            
            self.posts = jsonData; // initialize our model with the received data
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounds = [[UIScreen mainScreen] bounds];
        self.tableView.backgroundColor = nil;
    }
    
    else
    {
        // show the empty table here
    }
    
  ////  NSLog(@"BEFORE self.prototypeCell dequeReusable Idebtifier POST CELL");
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Post Cell B"];
  ////  NSLog(@"AFTER self.prototypeCell dequeReusable Idebtifier POST CELL");
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//  ----------------------------------------------
  
  // Configure location Manager
    self.mapView.showsUserLocation = YES;

    
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
    [self.locationManager startUpdatingLocation];
    
    

    
}

- (void) viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    
    /*UIViewController *searchResultsController = [[UIViewController alloc] init];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    // searchController.searchResultsUpdater = searchResultsController;
    self.tableView.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;*/
    
    ///////////////UNCOMMENT NEXT LINE
    self.tableView.contentInset = UIEdgeInsetsMake(self.mapView.bounds.size.height, 0, 0, 0);
    //self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    NSLog(@"content offset y after layout subviews: %f",self.tableView.contentOffset.y);
    NSLog(@"mapview height is : %f", self.mapView.bounds.size.height);
}

//-- view life-cycle methods End ----------------------

#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Search Text Changed");
}

// -- search bar Delegte methods end
#pragma mark - Location Manager Delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"NEW LOCATION:");
    NSLog(@"%@", [locations lastObject]);
    
    [self getVenuesForLocation:[locations lastObject]];
    
    [self.locationManager stopUpdatingLocation];
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
    NSLog(@"always =%d", kCLAuthorizationStatusAuthorizedAlways);
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
   //THIS IS WHERE WE START UPDATING LOCATIONS
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


//Location Manager End----------------------------------------


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView==self.tableView)
    {
        // Return the number of rows in the section.
        return self.posts.count;
    }
    
    else
    {
        return 5;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  ////  NSLog(@"------------------------- SkyboardTableViewController  cellFRAIP BEGIN");
    
  ////  NSLog(@"cellForRowAtIndexPath:%ld called BEFORE DEQUE",indexPath.row);
    
    if(tableView == self.tableView)
    {
        NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
        NSString *postType = [object objectForKey:@"posttype"];
    
        CSSkyboardTableViewCell *cell;
        //id cell;
        if ([postType compare:@"Question"] == NSOrderedSame)
        {
            CSSkyboardTableViewCellQuestion *cell2 = [tableView dequeueReusableCellWithIdentifier:@"Question Cell B" forIndexPath:indexPath];
            //CSSkyboardTableViewCellQuestion *cellSubclass = cell;
        
            cell2.answerCount = [NSNumber numberWithInt:5];
            cell2.answerCountLabel.text = [NSString stringWithFormat:@"%d", [cell2.answerCount intValue]];
            cell = cell2;
        
        }
    
        else if([postType compare:@"Poll"] == NSOrderedSame)
        {
            CSSkyboardTableViewCellPoll *cell3 = [tableView dequeueReusableCellWithIdentifier:@"Poll Cell B" forIndexPath:indexPath];
            if (!cell3)
            {
  ////          NSLog(@"Cell 3 is nil");
            } // BLANK
            else
            {
    ////        NSLog(@"Cell 3 in not nil");
            } // BLANK
            
            cell3.voteCount = [NSNumber numberWithInt:53];
            cell3.voteCountLabel.text = [NSString stringWithFormat:@"%d", [cell3.voteCount intValue ]];
            cell = cell3;
        
        }
    
        else // postType  = Thought   ---- Add More sub-classes later
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell B" forIndexPath:indexPath];
        }
    
 
 ////   NSLog(@"AFTER DEQUE");
    
        cell.postType = [object objectForKey:@"posttype"];
        cell.heading.text = [object objectForKey:@"posttext"];
        cell.fullNameLabel.text = [[object objectForKey:@"userfname"] stringByAppendingString: [object objectForKey:@"userlname"]];
    
        cell.profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
    
        NSString *filePath = [object objectForKey:@"mediafilepath"];
        NSString *baseString =@"http://ec2-54-173-125-187.compute-1.amazonaws.com/";
        baseString = [baseString stringByAppendingString:filePath];
    
        NSData *profilePictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseString]];
        UIImage *image = [UIImage imageWithData:profilePictureData];
        cell.profilePictureView.image = image;
                            // following if block is unnecessary because we change the picture in layoutSubview method of the cell
                            /*if([cell.postType isEqualToString:@"Thought"])
                            {
                            NSLog(@"THOUGHT IDENTIFIED");
                             cell.profilePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
                             }*/
    
                            //[cell layoutSubviews];
    
        cell.likeCount = [NSNumber numberWithInt:6];
        cell.commentCount = [NSNumber numberWithInt:2];
        cell.likeCountLabel.text = [NSString stringWithFormat:@"%d",[cell.likeCount intValue]];
        cell.commentCountLabel.text = [NSString stringWithFormat:@"%d", [cell.commentCount intValue]];
        cell.postId = [object objectForKey:@"postid"];
    
 ////   NSLog(@"------------------------- SkyboardTableViewController  cellFRAIP END RETURN cell");
        return cell;
    }
    else // tableview != self.tableView
    {
        CSSkyboardTableViewCell *cell = [[CSSkyboardTableViewCell alloc] init];
        return cell;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 ////   NSLog(@"-------------------------heightFRAIP BEGIN");
  ////  NSLog(@"heightForRowAtIndexPath:%lu called", indexPath.row);
    
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    @try
    {
        self.prototypeCell.heading.text = [object objectForKey:@"posttext"];
        // self.prototypeCell.postType = [object objectForKey:@"posttype"]; // we pass the post type now rather than later
        
   ////     NSLog(@"self.protoypecell.posttype = %@", self.prototypeCell.postType);
        [self.prototypeCell layoutSubviews];//LAYOUT SUBVIEWS
   ////    NSLog(@"prototypecell .testcellheight : %f", self.prototypeCell.testCellHeight);
    ////    NSLog(@"-------------------------heightFRAIP END RETURN HEIGHT\n\n\n\n\n");
        return self.prototypeCell.testCellHeight;
    }
    
    @catch (NSException *e)
    {
     ////   NSLog(@"Exception: %@", e);
        return 100.0f;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"contentOffset:%f", scrollView.contentOffset.y);
    NSLog(@"mapview height:%f\n", self.mapView.frame.size.height-1);
    
    if (scrollView.contentOffset.y < - (self.mapView.bounds.size.height) ) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -(self.mapView.bounds.size.height))];
        NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXif block true. Scrollview did scroll");
    }
    
  /*  if (scrollView.contentOffset.y >= 0.0) {
        
        NSLog(@"CONTENT OFFSET IS ZERO");
        NSLog(@"Attempting to shutdown location monitoring");
        // THIS IS WHERE WE STOP UPDATING LOCATION.
        
        [self.locationManager stopUpdatingLocation];
    }
    
    else
    {
        [self.locationManager startUpdatingLocation];
    }
 */
}

//Table View Data-Source End -----------------






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
