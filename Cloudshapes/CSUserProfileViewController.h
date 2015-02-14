 //
//  CSUserProfileViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPhotoViewController.h"
@interface CSUserProfileViewController: UIViewController <CSPictureDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPointsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfilePicture;



@end
