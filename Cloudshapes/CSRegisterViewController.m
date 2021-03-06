//
//  CSRegisterViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-19.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSRegisterViewController.h"

@interface CSRegisterViewController ()
@end

@implementation CSRegisterViewController

- (IBAction)registerButtonClicked:(id)sender {
    
    
    NSLog(@"REGISTER BUTTON CLICKED");
    
    if ([self validateUserInput])
    {
        //1. gather input
        NSString *userFirstName = [self.txtFirstName text];
        NSString *userLastName = [self.txtLastName text];
        NSString *userEmail = [self.txtEmailAddress text];
        NSString *userSex = [self.txtSex text];
        NSString *userDOB = [self.txtDateOfBirth text];
        NSString *userName = [self.txtUserName text];
        NSString *userPassword = [self.txtPassword text];
        __unused NSString *userConfirmPassword = [self.txtConfirmPassword text]; //implement password match
        NSString *inputString = [NSString stringWithFormat:@"userFirstName=%@&userLastName=%@&userEmail=%@&userSex=%@&userDOB=%@&userName=%@&userPassword=%@",userFirstName,userLastName,userEmail,userSex,userDOB,userName,userPassword];
        NSLog(@"%@",inputString);
        
        
        //2. encode input data, calculate length
        NSData *postData =[inputString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
        
        
        //3. init and setup request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
        [request setURL:[NSURL URLWithString:@"http://localhost/scripts/CSregisteruser13.1_dev.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    
    
        //4. allocate variables for URL response and NS error
        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        
        
        //5. fire request, receive data, get HTTP Response
        ///- Change this to async request later
        NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        NSString *result =[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Response code: %lu", [urlResponse statusCode]);
        NSString *responseBody = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]; // decoding the data
        NSLog(@"RESPONSE BODY : %@", responseBody);
    
        if ([urlResponse statusCode]>=200 && [urlResponse statusCode]<300) {
           // NSLog(@"Response: %@", result);
        }
        //NSLog(@"Response: %@", result);
        if (error == nil)
        {NSLog(@"NO ERRORS");}
        if (result == nil)
        {NSLog(@"NIL RESULT");}
        NSLog(@"RESULT: %@", result);
        NSLog(@"Error : %@", error.localizedDescription);
    
    }
    
    
    
}


- (BOOL) validateUserInput {
    NSLog(@"VALIDATE USER INPUT METHOD");
    return YES;
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
