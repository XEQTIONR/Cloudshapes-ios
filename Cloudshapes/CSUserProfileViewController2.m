//
//  CSUserProfileViewController2.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-08-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSUserProfileViewController2.h"


@interface CSUserProfileViewController2 () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CSUserProfileViewController2


- (void) viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.21 blue:0.9 alpha:0.5];
    self.userActivityTableView.dataSource = self;
    self.userActivityTableView.delegate = self;
    self.userActivityTableView.backgroundColor = nil;
    self.userActivityTableView.bounds = [[UIScreen mainScreen] bounds];
    //[self.view bringSubviewToFront:self.userActivityTableView];
    //[self.view sendSubviewToBack:self.userProfilePicture];
    
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    NSLog(@"Banner Frame height : %f", self.userProfileBannerImageView.frame.size.height);
    //self.userProfileBannerImageView.image = [UIImage imageNamed:@"venom-landscape"];
   //[self.userProfileBannerImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.userProfileBannerImageView.backgroundColor = [UIColor redColor];
    //[self.userProfileBannerImageView setClipsToBounds:YES];
    [self.userProfileBannerImageView reloadInputViews];
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    NSLog(@"Banner Frameheight : %f", self.userProfileBannerImageView.frame.size.height);
    //[self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.x, self.userProfileBannerImageView.bounds.size.height)];
    //self.cachedSize = self.userProfileBannerImageView.bounds;
    //self.center = self.userProfileBannerImageView.center;
    //NSLog(@"self center x=%f, y=%f", self.center.x,self.center.y);

    
    
    if(!self.userProfileBannerImageView.image)
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

        [self.userProfileBannerImageView setImage:image];
        [self.userProfileBannerImageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.userProfilePicture setImage:image];
        [self.userProfilePicture setContentMode:UIViewContentModeScaleAspectFill];
        //self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.bounds.size.width/2.0;
        [self.userProfilePicture setClipsToBounds:YES];

    }
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.userActivityTableView.contentInset = UIEdgeInsetsMake(self.userProfileBannerImageView.bounds.size.height, 0, 0, 0);
    [self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.y, -(self.userProfileBannerImageView.frame.size.height))];
    self.center = self.userProfileBannerImageView.center;
    self.cachedSize = self.userProfileBannerImageView.frame; //CACHED SIZE
    
    /*
    self.fullName = [[UILabel alloc] init];
    self.fullName.text = @"John Doe"; // HARD_CODED VALUE]
    self.fullName.textColor = [UIColor blackColor];
    self.fullName.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.fullName];
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.fullName
                                                 attribute: NSLayoutAttributeCenterX
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:self.userProfilePicture
                                                 attribute: NSLayoutAttributeCenterX
                                                 multiplier:1.0
                                                constant:0.0];
    
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.fullName attribute: NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.userProfilePicture attribute: NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:self.fullName attribute: NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.userProfilePicture attribute: NSLayoutAttributeHeight multiplier:0.5 constant:0];
    
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:self.fullName attribute: NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.userProfilePicture attribute: NSLayoutAttributeWidth multiplier:1.5 constant:0];
    
    
    NSArray *constraints = [NSArray arrayWithObjects:c1,c2,c3,c4, nil];
    [self.view addConstraints:constraints];
    */
    
    
    
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight ];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.view addSubview:self.blurEffectView];
    self.blurEffectView.frame = self.userProfileBannerImageView.frame;
    [self.view sendSubviewToBack:self.blurEffectView];
    [self.view sendSubviewToBack:self.userProfileBannerImageView];
    
    self.userProfilePicture.layer.borderWidth = 6.0f;
    self.userProfilePicture.layer.borderColor = [UIColor whiteColor].CGColor; // hmm... interesting short-hand for [-[UIColor c] CGColor];
    self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.bounds.size.width/2.0;
    

    [self.view bringSubviewToFront:self.userActivityTableView];
    
    
    //UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userActivityTableView.frame.size.width, 32)];
    UISegmentedControl *header = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Activity",@"About",@"Photos", nil]];
    header.frame = CGRectMake(0, 0, self.userActivityTableView.frame.size.width, 32);
    header.backgroundColor = [UIColor whiteColor];
    header.tintColor = [UIColor colorWithRed:0.0 green:0.21 blue:0.9 alpha:1.0];
    self.userActivityTableView.tableHeaderView = header;
    [self.view bringSubviewToFront:header];
    [self.view bringSubviewToFront:self.fullName];// <------ IMPORTANT
}


#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

/*- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    header.backgroundColor = [UIColor redColor];
    //header.textLabel.text = @"THIS IS THE HEADER VIEW";
    return header;
}*/

- (UITableViewCell* )tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *profileTVCell = [tableView dequeueReusableCellWithIdentifier:@"Profile TV Cell"];
    
    profileTVCell.textLabel.text = @"Text Label String";
    
    return profileTVCell;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //CGFloat y = self.cachedSize.size.height - scrollView.contentOffset.y;
    
    //NSLog(@"cachedSize.size.height: %f", self.cachedSize.size.height);
    //NSLog(@"scrollview.contentoffset,y: %f", scrollView.contentOffset.y);
    //NSLog(@"self center x=%f, y=%f", self.center.x,self.center.y);
    //NSLog(@"Y: %f", y);
    
    //if (self.userProfileBannerImageView.bounds.size.height < -(scrollView.contentOffset.y))
    
    //Only happens when scroll-view max scroll down
    if (self.cachedSize.size.height < -(scrollView.contentOffset.y))
    {
        //self.userProfileBannerImageView.frame = CG
        
        //NSLog(@"cachedSize.size.height: %f", self.cachedSize.size.height);
        //NSLog(@"scrollview.contentoffset,y: %f", scrollView.contentOffset.y);
        
        
      //  CGPoint topLeft, topRight, bottomLeft, bottomRight;
        CGFloat newdelta = -(self.userProfileBannerImageView.bounds.size.height + scrollView.contentOffset.y);
        
        //if (self.userProfilePicture.alpha<1 || self.userProfilePicture.alpha>0) {
            
        
           /* if(newdelta<0)
            {
                //NSLog(@"EUREKAAAAAAAAAAAAAAAAAAA\n\n");
                //self.userProfilePicture.alpha = self.userProfilePicture.alpha +(newdelta/50);
                NSLog(@"New delta -VE");
            }
            else
            {
                //self.userProfilePicture.alpha = self.userProfilePicture.alpha -(newdelta/50);
                NSLog(@"New delta +VE");
            }*/
            self.userProfilePicture.alpha = self.userProfilePicture.alpha -(newdelta/50);
            self.blurEffectView.alpha = self.blurEffectView.alpha - (newdelta/50);
        
        if (self.userProfilePicture.alpha>1.0) {
            self.userProfilePicture.alpha=1.0;
        }
        else if (self.userProfilePicture.alpha<0.0)
        {
            self.userProfilePicture.alpha=0.0;
        }
        
        
        if (self.blurEffectView.alpha>1.0) {
            self.blurEffectView.alpha=1.0;
        }
        
        else if (self.blurEffectView.alpha<0.0){
            self.blurEffectView.alpha=0.0;
        }
        
        //}
        
        //self.userProfilePicture.alpha = self.userProfilePicture.alpha +(newdelta/50);
        NSLog(@"delta : %f", self.delta);
        NSLog(@"newdelta : %f", newdelta);
        NSLog(@"alpha : %f \n\n", self.userProfilePicture.alpha);
     /*
      //  topLeft = CGPointMake(self.center.x-(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y-(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //topRight = CGPointMake(self.center.x+(self.userProfileBannerImageView.frame.size.width +delta)/2.0,  self.center.y-(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //bottomLeft = CGPointMake(self.center.x-(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y+(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //bottomRight = CGPointMake(self.center.x+(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y+(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        
       // NSLog(@" x: %f  y: %f              x: %f  y: %f\n\n", topLeft.x, topLeft.y, topRight.x, topRight.y);
       // NSLog(@" x: %f  y: %f              x: %f  y: %f\n\n\n\n", bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y);
       
      */

        
        self.userProfileBannerImageView.frame = CGRectMake(0,0, (self.userProfileBannerImageView.frame.size.width + newdelta), (self.userProfileBannerImageView.frame.size.height+newdelta)); // Dont Change height.... Acts wierd.
        //self.userProfileBannerImageView.frame = CGRectMake(0, 0, self.cachedSize.size.width+y, self.cachedSize.size.height+y);
        //self.userProfileBannerImageView.center = self.center;
        self.userProfileBannerImageView.center = self.userProfilePicture.center;
        
        self.blurEffectView.frame = self.userProfileBannerImageView.frame;
        self.blurEffectView.center = self.userProfilePicture.center;
        
        //self.delta ++;
        self.delta =newdelta;
    }
    

    
    
 
}

@end