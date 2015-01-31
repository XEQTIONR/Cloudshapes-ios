//
//  CSUserProfileViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-28.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSUserProfileViewController.h"
#import "CSUser.h"
@interface CSUserProfileViewController ()
@property (strong, nonatomic) CSUser *thisUser;
@end

@implementation CSUserProfileViewController

- (CSUser *) thisUser
{
    if (!_thisUser)
    {
        _thisUser = [[CSUser alloc] init];
    }
    return _thisUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    [self.thisUser setUserFNameTo:@"Viktor" andUserLNameTo:@"Novorski"];
    
    self.firstNameLabel.text = [self.thisUser sendFname];
    self.lastNameLabel.text = [self.thisUser sendLname];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
