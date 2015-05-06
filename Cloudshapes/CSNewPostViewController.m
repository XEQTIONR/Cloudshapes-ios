//
//  CSNewPostViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-17.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSNewPostViewController.h"

@interface CSNewPostViewController ()


@property (strong, nonatomic)NSString *postText;
@property (strong, nonatomic)NSNumber *userId;
@end

@implementation CSNewPostViewController

- (IBAction)cancel:(id)sender
{
    //temporary for testing. Use delegates instead.
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)post:(id)sender {
    
    //[self resignFirstResponder];
    NSUserDefaults *appDefaults = [NSUserDefaults standardUserDefaults];
    NSString *stringUserId = [appDefaults objectForKey:@"userid"];
    
    self.userId = [NSNumber numberWithInt:[stringUserId intValue]];
    self.postText = self.postTextView.text;
    
    [self.postTextView resignFirstResponder];
    
    NSLog(@"Post text: %@ \n stringUserId : %@ \n userId : %d", self.postText, stringUserId, [self.userId intValue]);
    
    //code for script to insert new post
   
    
}

#pragma mark - UITextView Delegate Methods

-(void) textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postTextView.delegate = self;
    self.postTextView.textColor = [UIColor grayColor];
    
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
