//
//  CSLoginViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-20.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

@import Foundation;
#import "CSLoginViewController.h"

@interface CSLoginViewController ()

@end

@implementation CSLoginViewController


- (IBAction)login:(id)sender {
 
    
    //1. gather input
    NSString *username = [self.txtusername text ];
    NSString *password = [self.txtpassword text ];
    NSLog(@"Username : %@    Password : %@", username,password);
    NSString *loginInfo = [NSString stringWithFormat:@"loginUsername=%@&loginPassword=%@",username,password];
    
    //2. encode input data, calculate length
    NSData *loginData = [loginInfo dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [loginData length]];
    
    
    //3. init and setup request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"http://localhost/scripts/login_v3.0.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:loginData];
    
    //4. allocate variables for URL response and  NS error
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    
    //5. fire request, receive data, get HTTP Response
    ///- Change this to async Request later
    NSData *loginResponseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:loginResponseData options:kNilOptions error:&error]; // decoding the data
    
    if ([urlResponse statusCode]>=200 && [urlResponse statusCode]<300)
    {
        NSLog(@"urlResponse status code: %ld", [urlResponse statusCode]);
    }
    
    if (error == nil) {NSLog(@"NO ERRORS");}
    
    if (jsonData == nil)
    {
        NSLog(@"NIL RESULT");
    }
    
    else  // jsonData!= nil
    {
        NSLog(@"%@", jsonData);
        //NSLog(@"AND R1:");      //jsonData is a NSArray -->NSDictionary previously
        NSLog(@"jsonData.count = %lu", [jsonData count]);
        
        
        
        if([jsonData count]) //JsonData array should contain a single user
        {
            NSDictionary *jsonDictionary = [jsonData objectAtIndex:0]; // First and only object in Array
            NSLog(@"USERS EMAIL : %@", [jsonDictionary objectForKey:@"useremail"]);
            
            // save  user data to NSUserDefaults
            // only userid for now. We query all other info using userid. Changes possible later.

            //Singleton  - Same object returned when creating a new variable
            NSUserDefaults *appDefaults =[NSUserDefaults standardUserDefaults]; //Get app defaults (singleton class NSUserDefaults)
            
            
            //Modify app defaults to set User
            NSString *userId = [jsonDictionary objectForKey:@"userid"];
            NSString *userFName = [jsonDictionary
                                   objectForKey:@"userfname"];
            NSString *userLName = [jsonDictionary
                                   objectForKey:@"userlname"];
            NSString *userName = [jsonDictionary
                                  objectForKey:@"username"];
            //NSString *userPoints = [jsonDictionary objectForKey:@"userpoints"];
            
            /// Later get the user profile picture as well
            NSLog(@"userId:%@ userFName:%@ userLName:%@ userName:%@", userId,userFName,userLName,userName); //userPoints left out
            
            
            
            [appDefaults setObject:userId forKey: @"userid"];
            [appDefaults setObject:userFName forKey:@"userfname"];
            [appDefaults setObject:userLName forKey:@"userlname"];
            [appDefaults setObject:userName  forKey:@"username"];
            //[appDefaults setObject:userPoints forKey:@"userpoints"];
            [appDefaults synchronize];
            
            //Log of the synced values
            NSLog(@"App Defaults after setting :   userid:%@ userfname:%@ userlname:%@ username:%@ userpoints:%@",
                  [appDefaults objectForKey:@"userid"],
                  [appDefaults objectForKey:@"userfname"],
                  [appDefaults objectForKey:@"userlname"],
                  [appDefaults objectForKey:@"username"],
                  [appDefaults objectForKey:@"userpoints"]);
            
            // Enter the app as a logged in user
            
            // UNCOMMENT THIS TO GO TO SKYBOARD
            [self performSegueWithIdentifier:@"enterSegue" sender: self];
        }
        else  // jsonData.count = 0 /// No username-password match
        {
            NSLog(@"User Authentication Failed");
            UIAlertView *authenticationFailedAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Username or Password Incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [authenticationFailedAlert show];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
