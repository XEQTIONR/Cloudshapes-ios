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
    [self.userProfilePicture reloadInputViews]; //perhaps not neccessary
    
    if(self.userProfilePicture.image == image)
        NSLog(@"Picture Assigned");
    else
        NSLog(@"Picture not assigned");
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstNameLabel.text = [[CSUser currentAppUser]userFName];//[self.thisUser sendFname];
    self.lastNameLabel.text = [[CSUser currentAppUser] userLName];
    self.userNameLabel.text = [[CSUser currentAppUser] userName];
    self.userPointsLabel.text = [[CSUser currentAppUser] userPoints];
    
    if(!self.userProfilePicture.image)
    {
        
        //1. gather input
        NSUserDefaults *appDefaults =[NSUserDefaults standardUserDefaults];
        
        NSString *userId = [appDefaults objectForKey:@"userid"];
        
        NSString *paramUserId = [NSString stringWithFormat:@"userId=%@",userId];
        
        //2. encode input data, calculate length
        NSData *dataUserId = [paramUserId dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", [dataUserId length]];
        
        
        //3. init and setup request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getprofilepicturefilepath.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:dataUserId];
        
        
        //4. allocate variables for URL response and  NS error
        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        
        //5. fire request, receive data, get HTTP Response
        ///- Change this to async Request later
        NSData *picturePath = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        NSString *filePath = [[NSString alloc] initWithData:picturePath encoding:NSUTF8StringEncoding]; //decoding the file path
        NSString *baseString =@"http://ec2-54-173-125-187.compute-1.amazonaws.com/";
        
        baseString = [baseString stringByAppendingString:filePath]; // attaching to url of server giving us the full path
        
        //
        NSLog(@"User profile picture filePath = %@", filePath);
        NSLog(@"Base string <%@>", baseString);
        
        NSData *pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseString]];
        UIImage *image = [UIImage imageWithData:pictureData];
        self.userProfilePicture.image = image ;
        
    }
    
    
    
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
    // Pass self to the new view controller as its delegate.
}


@end

