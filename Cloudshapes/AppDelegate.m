//
//  AppDelegate.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "AppDelegate.h"
#import "Foursquare2.h"

//#import <FacebookSDK/FacebookSDK.h>
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUserDefaults *appDefaults = [NSUserDefaults standardUserDefaults];
    
    if([appDefaults objectForKey:@"userid"])
    {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = // determine the initial view controller here and instantiate it with
        [storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
    
    
    //initialize Foursquare Engine
    [Foursquare2 setupFoursquareWithClientId:@"SCFFFGXLDO2MDLAPD2KQCRT45MWDSROPWEV0O5JXJGPW5PLQ"
                                      secret:@"JTNNSK23UZPIDZB1D5C0R5WEL2Y033OHEXOTQHAZAHRR250C" callbackURL:@""]; // we dont need a callback URL for venues
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
    //[[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return YES; //[FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}
@end
