//
//  CSMainTabBarController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-12.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSMainTabBarController.h"
#import "CSNewPostViewController.h"
@interface CSMainTabBarController ()

@end

@implementation CSMainTabBarController



- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController
{

    if ([viewController isKindOfClass:[CSNewPostViewController class]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Stop" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Meh", nil];
        [alert show];
        return YES ;
        
        //here we should replace the alert with the custom view to select the type of post
    }
    else
    {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // Do any additional setup after loading the view.
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"Explore" image:[UIImage imageNamed:@"Binoculars-32"] storyboardID:@"TESTItem"],
                            [self viewControllerWithTabTitle:@"Profile" image:[UIImage imageNamed:@"User Male Circle-32"] storyboardID:@"CSProfile"],
                            nil];
    
    [self addCenterButtonWithImage:[UIImage imageNamed:@"Plus-32"] highlightImage:[UIImage imageNamed:@"Delete Sign Filled-32"]];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
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
