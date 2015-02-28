//
//  CSSkyboardTableViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSkyboardTableViewCell.h"

@interface CSSkyboardTableViewController : UITableViewController
@property (strong, nonatomic) NSArray *posts; // our skyboard model
@property (strong, nonatomic) CSSkyboardTableViewCell *prototypeCell;
@end
