//
//  CSLoginViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-01-20.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSLoginViewController.h"

@interface CSLoginViewController ()

@end

@implementation CSLoginViewController


- (IBAction)login:(id)sender {
 /*
    NSString *username = [self.txtusername text ];
    NSString *password = [self.txtpassword text ];
    NSLog(@"Username : %@    Password : %@", username,password);
    
    NSString *loginInfo = [NSString stringWithFormat:@"loginUsername=%@&loginPassword=%@",username,password];
    
    NSData *loginData = [loginInfo dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [loginData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/CSregisteruser_dev.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:loginData];
   */ 
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
