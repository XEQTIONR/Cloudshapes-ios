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
    
    // script for getting the profile picture form the internet.
    
    if(!self.userProfilePicture.image)
    {
        
        NSUserDefaults *appDefaults =[NSUserDefaults standardUserDefaults];
        
        NSString *userId = [appDefaults objectForKey:@"userid"];
        
        NSString *paramUserId = [NSString stringWithFormat:@"userId=%@",userId];
        NSData *dataUserId = [paramUserId dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", [dataUserId length]];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getprofilepicturefilepath.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:dataUserId];
        
        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        
        NSData *picturePath = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];     //just the path for now
        
        NSString *filePath = [[NSString alloc] initWithData:picturePath encoding:NSUTF8StringEncoding];
        NSString *baseString =@"http://ec2-54-173-125-187.compute-1.amazonaws.com/";
        
        baseString = [baseString stringByAppendingString:filePath];
        
        //NSLog(@"%@", jsonData);
        NSLog(@"User profile picture filePath = %@", filePath);
        NSLog(@"Base string <%@>", baseString);
        
        NSData *pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseString]];
        //NSData *pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/uploads/26/83d533188ad07c636c67852fa9975bd1.jpg"]];
        
    
        //NSString * stringRepPic = [NSString ]
        UIImage *image = [UIImage imageWithData:pictureData];
        self.userProfilePicture.image = image ;
        
        //NSLog(@"Picture Data: %@", pictureData);
        
        //[super viewDidLoad];
        

        
        
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
    // Pass the selected object to the new view controller.
}


@end

