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
    self.userActivityTableView.bounds = [[UIScreen mainScreen] bounds];
    
     [self.userProfileBannerImageView setContentMode:UIViewContentModeScaleToFill];
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    
    self.userProfileBannerImageView.image = [UIImage imageNamed:@"cs alternate"];
   
    [self.userProfileBannerImageView reloadInputViews];
    NSLog(@"Banner Picture height : %f", self.userProfileBannerImageView.image.size.height);
    //[self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.x, self.userProfileBannerImageView.bounds.size.height)];


}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.userActivityTableView.contentInset = UIEdgeInsetsMake(self.userProfileBannerImageView.bounds.size.height, 0, 0, 0);
    [self.userActivityTableView setContentOffset:CGPointMake(self.userActivityTableView.contentOffset.x, -(self.userProfileBannerImageView.bounds.size.height))];
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

/*- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"\n\nScrollView Did Scroll in user profile");
    NSLog(@"scrollView.contentOffset.y : %f",scrollView.contentOffset.y);
    NSLog(@"self.userProfileBannerImageView.bounds.size.height : %f", self.userProfileBannerImageView.bounds.size.height);
    if (scrollView.contentOffset.y < - (self.userProfileBannerImageView.bounds.size.height) )
    {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -(self.userProfileBannerImageView.bounds.size.height))];
        NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXif block true. Scrollview did scroll");
    }
    NSLog(@"scrollView.contentOffset.y : %f",scrollView.contentOffset.y);

}*/

@end