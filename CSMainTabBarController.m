//
//  CSMainTabBarController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-12.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSMainTabBarController.h"
#import "CSNewPostViewController.h"
@interface CSMainTabBarController (){
    UIView *contentView;
    UPStackMenu *stack;
    UIViewController *dummyViewController;
    
}

@end

@implementation CSMainTabBarController



- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController==dummyViewController)
    {
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Stop" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Meh", nil];
        //[alert show];
        return NO ;
    }
    return YES;
}


#pragma mark - UPStackMenu Delegate Methods

- (void)stackMenuDidOpen:(UPStackMenu*)menu
{
    dummyViewController.tabBarItem.title = @"Cancel";
}

- (void)stackMenuDidClose:(UPStackMenu*)menu
{
    dummyViewController.tabBarItem.title = @"New Post";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tabBar.backgroundColor = [UIColor redColor];
    [self.tabBar setBarTintColor:[UIColor colorWithRed:0.0 green:0.21 blue:0.9 alpha:1.0]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    self.delegate = self;
    
    
    // Do any additional setup after loading the view.
    
    dummyViewController = [self viewControllerWithTabTitle:@"New Post" image:nil storyboardID:nil];
    
    // here we manually add all the tabs including our special center button
    self.viewControllers = [NSArray arrayWithObjects:
                             [self viewControllerWithTabTitle:@"Explore" image:[UIImage imageNamed:@"Binoculars-32"] storyboardID:@"TESTitem"], //Skyboard Tab ... use navSkyboard for Navigation Controller
                             dummyViewController, // New Post Tab
                             [self viewControllerWithTabTitle:@"Profile" image:[UIImage imageNamed:@"User Male Circle-32"] storyboardID:@"CSProfile"], // CSProfile is the navigation controller. CSProfile2 is the view
                             nil ];
    
    //method on our special center button subclass.
    contentView =[self addCenterButtonWithImage:[UIImage imageNamed:@"Plus-32"] highlightImage:[UIImage imageNamed:@"Delete Sign Filled-32"]];
    
    
    
    //initialize our tab bars
    [self changeDemo:nil];
    
}





// this method resets our tab bars.
- (void)changeDemo:(id)sender
{
    if(stack)
        [stack removeFromSuperview];
    
    stack = [[UPStackMenu alloc] initWithContentView:contentView];
    //[stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [stack setDelegate:self];
    
    UPStackMenuItem *thoughtItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Exclamation Mark Filled-32"] highlightedImage:nil title:@"Thought"];
    UPStackMenuItem *questionItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Question Mark Filled-32"] highlightedImage:nil title:@"Question"];
    UPStackMenuItem *pollItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Checkmark Filled-32"] highlightedImage:nil title:@"Poll"];
    //UPStackMenuItem *crossItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@"Cross"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:thoughtItem, questionItem, pollItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor whiteColor]];
    }];
    

            [stack setAnimationType:UPStackMenuAnimationType_progressive];
            [stack setStackPosition:UPStackMenuStackPosition_up];
            [stack setOpenAnimationDuration:.4];
            [stack setCloseAnimationDuration:.4];
            [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                [item setLabelPosition:UPStackMenuItemLabelPosition_right];
                [item setLabelPosition:UPStackMenuItemLabelPosition_left];
            }];

    
    [stack addItems:items];
    [self.view addSubview:stack];
    
    [self setStackIconClosed:YES];
}


- (void)setStackIconClosed:(BOOL)closed
{
    UIView *icon = contentView ;
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}


#pragma mark - UPStackMenuDelegate

- (void)stackMenuWillOpen:(UPStackMenu *)menu
{
    
    //[self.view setAlpha:0.1]; // toggles visibility of entire screen
    
    // maybe change this to only the current view controller
    for (UIViewController *vc in self.viewControllers)
    {
        [vc.view setAlpha:0.1];
    }
    
    if([[contentView subviews] count] == 0)
        return;
    
    [self setStackIconClosed:NO];
}

- (void)stackMenuWillClose:(UPStackMenu *)menu
{
    [self.view setAlpha:1.0]; // toggles visibility of entire screen
    
    for (UIViewController *vc in self.viewControllers)
    {
        [vc.view setAlpha:1.0];
    }
    
    if([[contentView subviews] count] == 0)
        return;
    
    [self setStackIconClosed:YES];
}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index
{
    //NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    [stack closeStack];
    NSString *postType = item.title;
    
    if ([postType compare:@"Thought"]==NSOrderedSame)
        [self performSegueWithIdentifier:@"New Thought" sender:self];
    
    else if ([postType compare:@"Question"]==NSOrderedSame)
        [self performSegueWithIdentifier:@"Collection Segue" sender:self];
    
    else if ([postType compare:@"Poll"]==NSOrderedSame)
        [self performSegueWithIdentifier:@"New Poll" sender:self];
    
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
