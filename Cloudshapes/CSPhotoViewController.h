//
//  CSPhotoViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//
//#import "CSUserProfileViewController.h"
#import <UIKit/UIKit.h>

@protocol CSPictureDelegate <NSObject>
@required
- (void) setProfilePicture: (UIImage *) image;
@end

@interface CSPhotoViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *currentPhoto;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak) id <CSPictureDelegate> photoDelegate;
@end
