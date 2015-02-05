//
//  CSPhotoViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *currentPhoto;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@end
