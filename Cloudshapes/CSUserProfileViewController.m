//
//  CSUserProfileViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSUserProfileViewController.h"
#import "CSUser.h"

//@protocol CSPictureDelegate;

@interface CSUserProfileViewController () 
//@property (strong, nonatomic) CSUser *thisUser;
@end

@implementation CSUserProfileViewController

/*
 
- (CSUser *) thisUser
{
    if (!_thisUser)
    {
        _thisUser = [[CSUser alloc] init];
    }
    return _thisUser;
}*/


- (void)setProfilePicture:(UIImage *)image
{
    NSLog(@"Set profile picture activated");
    self.userProfilePicture.image = image;
    [self.userProfilePicture reloadInputViews];
    
    if(self.userProfilePicture.image == image)
        NSLog(@"Picture Assigned");
    else
        NSLog(@"Picture not assigned");
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    //[self.thisUser setUserFNameTo:@"Viktor" andUserLNameTo:@"Novorski"];
    
    
    self.firstNameLabel.text = [[CSUser currentAppUser]userFName];//[self.thisUser sendFname];
    self.lastNameLabel.text = [[CSUser currentAppUser] userLName];
    self.userNameLabel.text = [[CSUser currentAppUser] userName];
    self.userPointsLabel.text = [[CSUser currentAppUser] userPoints];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Segue: %@", segue.description);
    
    // a little introspection to determine which segue (Required for multiple segue from the same root View Controller)
    if ([[segue destinationViewController] isKindOfClass:[CSPhotoViewController class]])
    {
        CSPhotoViewController *photoViewController = [segue destinationViewController];
        photoViewController.photoDelegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

