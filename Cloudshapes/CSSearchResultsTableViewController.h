//
//  CSSearchResultsTableViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-05-29.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CSSearchResultsTableViewController : UITableViewController<UISearchResultsUpdating> //UISearchBarDelegate
@property (strong,nonatomic) MKLocalSearchRequest *searchRequest;
@property MKCoordinateRegion region;
@end
