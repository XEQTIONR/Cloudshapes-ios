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
 
    NSString *username = [self.txtusername text ];
    NSString *password = [self.txtpassword text ];
    NSLog(@"Username : %@    Password : %@", username,password);
    
    NSString *loginInfo = [NSString stringWithFormat:@"loginUsername=%@&loginPassword=%@",username,password];
    
    NSData *loginData = [loginInfo dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [loginData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/login_printr.php"]]; // current login script works
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:loginData];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *loginResponseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:loginResponseData options:kNilOptions error:&error];
    if ([urlResponse statusCode]>=200 && [urlResponse statusCode]<300) {
        // NSLog(@"Response: %@", result);
    }
    //NSLog(@"Response: %@", result);
    if (error == nil)
    {NSLog(@"NO ERRORS");}
    if (jsonData == nil)
    {NSLog(@"NIL RESULT");}
    else
    {
        NSLog(@"%@", jsonData);
        //NSLog(@"AND R1:");      //jsonData is a NSArray -->NSDictionary previously
        NSLog(@"jsonData.count = %lu", [jsonData count]);
        if([jsonData count]) // set to count==1?
        {
            NSDictionary *jsonDictionary = [jsonData objectAtIndex:0];
        //NSString *r1 = [jsonData objectForKey:@"useremail"];
            NSLog(@"USERS EMAIL : %@", [jsonDictionary objectForKey:@"useremail"]);
            
        // save  user data to NSUserDefaults
        // only userid for now. We query all other info using userid. Changes possible later.

            NSUserDefaults *appDefaults =[NSUserDefaults standardUserDefaults]; //Get app defaults (singleton class NSUserDefaults)
            
            
            //Modify app defaults to set User
            NSString *userId = [jsonDictionary objectForKey:@"userid"];
            NSString *userFName = [jsonDictionary
                                   objectForKey:@"userfname"];
            NSString *userLName = [jsonDictionary
                                   objectForKey:@"userlname"];
            NSString *userName = [jsonDictionary
                                  objectForKey:@"userdisplayname"];
            NSString *userPoints = [jsonDictionary
                                    objectForKey:@"userpoints"];
            
            
            NSLog(@"userId:%@ userFName:%@ userLName:%@ userName:%@ userPoints:%@", userId,userFName,userLName,userName,userPoints);
            
            
            
            [appDefaults setObject:userId forKey: @"userid"];
            [appDefaults setObject:userFName forKey:@"userfname"];
            [appDefaults setObject:userLName forKey:@"userlname"];
            [appDefaults setObject:userName forKey:@"userdisplayname"];
            [appDefaults setObject:userPoints forKey:@"userpoints"];
            [appDefaults synchronize];
            
            NSLog(@"App Defaults after setting :   userid:%@ userfname:%@ userlname:%@ username:%@ userpoints:%@",
                  [appDefaults objectForKey:@"userid"],
                  [appDefaults objectForKey:@"userfname"],
                  [appDefaults objectForKey:@"userlname"],
                  [appDefaults objectForKey:@"userdisplayname"],
                  [appDefaults objectForKey:@"userpoints"]);
            
            [self performSegueWithIdentifier:@"enterSegue" sender: self];
        }
        else
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
