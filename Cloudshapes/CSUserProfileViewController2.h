//
//  CSUserProfileViewController2.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-08-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSUserProfileViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userProfileBannerImageView;
@property (weak, nonatomic) IBOutlet UITableView *userActivityTableView;
@property (weak, nonatomic) IBOutlet UIImageView *userProfilePicture;
@property  CGRect cachedSize;
@property CGPoint center;   // this property is obsolete
@property CGFloat delta;
@property (strong, nonatomic) UILabel *fullName;

@property (strong, nonatomic) UIVisualEffectView *blurEffectView;
@end
