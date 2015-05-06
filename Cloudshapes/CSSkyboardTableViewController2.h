//
//  CSSkyboardTableViewController2.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSkyboardTableViewCell2.h"
@interface CSSkyboardTableViewController2 : UITableViewController
@property (strong, nonatomic) NSArray *posts; // our skyboard model
@property (strong, nonatomic) CSSkyboardTableViewCell2 *prototypeCell;
@end
