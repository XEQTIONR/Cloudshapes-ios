//
//  CSSkyboardTableViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSSkyboardTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *userFullName;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (strong, nonatomic) NSArray *posts;
@end
