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
    self.userActivityTableView.dataSource = self;
    self.userActivityTableView.delegate = self;
    self.userActivityTableView.backgroundColor = nil;
    //self.userActivityTableView.bounds = [[UIScreen mainScreen] bounds];
    
     [self.userProfileBannerImageView setContentMode:UIViewContentModeScaleToFill];
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    NSLog(@"Banner Frame height : %f", self.userProfileBannerImageView.frame.size.height);
    self.userProfileBannerImageView.image = [UIImage imageNamed:@"Hearts-50"];
   
    [self.userProfileBannerImageView reloadInputViews];
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    NSLog(@"Banner Frameheight : %f", self.userProfileBannerImageView.frame.size.height);
    //[self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.x, self.userProfileBannerImageView.bounds.size.height)];
    //self.cachedSize = self.userProfileBannerImageView.bounds;
    //self.center = self.userProfileBannerImageView.center;
    NSLog(@"self center x=%f, y=%f", self.center.x,self.center.y);


}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.userActivityTableView.contentInset = UIEdgeInsetsMake(self.userProfileBannerImageView.bounds.size.height, 0, 0, 0);
    [self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.x, -(self.userProfileBannerImageView.bounds.size.height))];
    self.center = self.userProfileBannerImageView.center;
    self.cachedSize = self.userProfileBannerImageView.bounds;
}


#pragma mark UITableViewDataSource methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell* )tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *profileTVCell = [tableView dequeueReusableCellWithIdentifier:@"Profile TV Cell"];
    
    profileTVCell.textLabel.text = @"Text Label String";
    
    return profileTVCell;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat y = self.cachedSize.size.height - scrollView.contentOffset.y;
    
    //NSLog(@"cachedSize.size.height: %f", self.cachedSize.size.height);
    //NSLog(@"scrollview.contentoffset,y: %f", scrollView.contentOffset.y);
    //NSLog(@"self center x=%f, y=%f", self.center.x,self.center.y);
    //NSLog(@"Y: %f", y);
    
    if (self.userProfileBannerImageView.bounds.size.height < -(scrollView.contentOffset.y))
    {
        //self.userProfileBannerImageView.frame = CG
        
        NSLog(@"cachedSize.size.height: %f", self.cachedSize.size.height);
        NSLog(@"scrollview.contentoffset,y: %f", scrollView.contentOffset.y);
        
        
        CGPoint topLeft, topRight, bottomLeft, bottomRight;
        CGFloat delta = -(self.userProfileBannerImageView.bounds.size.height + scrollView.contentOffset.y);
        NSLog(@"delta : %f", delta);
        
        
        topLeft = CGPointMake(self.center.x-(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y-(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //topRight = CGPointMake(self.center.x+(self.userProfileBannerImageView.frame.size.width +delta)/2.0,  self.center.y-(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //bottomLeft = CGPointMake(self.center.x-(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y+(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        //bottomRight = CGPointMake(self.center.x+(self.userProfileBannerImageView.frame.size.width + delta)/2.0, self.center.y+(self.userProfileBannerImageView.frame.size.height + delta)/2.0);
        
        NSLog(@" x: %f  y: %f              x: %f  y: %f\n\n", topLeft.x, topLeft.y, topRight.x, topRight.y);
        NSLog(@" x: %f  y: %f              x: %f  y: %f\n\n\n\n", bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y);
        
        //self.userProfileBannerImageView.frame = CGRectMake((self.center.x-(self.userProfileBannerImageView.frame.size.width + delta)/2.0), (self.center.y-(self.userProfileBannerImageView.frame.size.height + delta)/2.0), (self.userProfileBannerImageView.frame.size.width + delta), (self.userProfileBannerImageView.frame.size.height+delta));
        
        
        self.userProfileBannerImageView.frame = CGRectMake(0,0, (self.userProfileBannerImageView.frame.size.width + delta), (self.userProfileBannerImageView.frame.size.height+delta));
        //self.userProfileBannerImageView.frame = CGRectMake(0, 0, self.cachedSize.size.width+y, self.cachedSize.size.height+y);
        self.userProfileBannerImageView.center = self.center;
    }
    

    
    //CGFloat fAdd =
    
    
 
}

@end