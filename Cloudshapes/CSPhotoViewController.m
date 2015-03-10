//
//  CSPhotoViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSPhotoViewController.h"

@interface CSPhotoViewController ()

-(void) uploadPhoto: (UIImage*) image;

@end

@implementation CSPhotoViewController

- (IBAction)pickProfilePhoto:(id)sender
{


    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (IBAction)uploadProfilePhoto:(id)sender {
    
    if(self.currentPhoto.image) //image!=nil
    {
        [self uploadPhoto:self.currentPhoto.image];
    }
    
    else
        NSLog(@"No photo selected");
}


-(void) uploadPhoto:(UIImage *)image
{
    
    
    
    NSUserDefaults *appDefaults = [NSUserDefaults standardUserDefaults];
    NSString *zeroFillUserId = [appDefaults objectForKey:@"userid"];
    NSLog(@"Current zeroFillUser id is %@", zeroFillUserId);
    NSInteger intUserId = [zeroFillUserId integerValue];
    NSLog(@"intUserId is %ld", intUserId);
    NSString *stringFormattedUserId = [NSString stringWithFormat:@"%ld",intUserId];
    NSLog(@"stringFormattedUserId is %@", stringFormattedUserId);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/uploadinsert.php"]]; //previously uploadtest10.php?
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //NSLog(@"%@", imageData);
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    

    
    NSString *boundary =@"-------------------XcXXXXXXXXXXXXXXXXi7777789rtPui";
    
//set content type in HTTP field
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    //post body
    NSMutableData *body = [NSMutableData data];
    
    
    //add params all params are strings
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", @"SomeCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"userId"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", stringFormattedUserId] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", body);
    
    //add image data
    if(imageData)
    {
        NSLog(@"Image Data is true");
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpg\r\n",@"imageFromKey"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=imageName2.jpg\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //[body]
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        NSLog(@"imageData false");
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
// adding the created body to the POST HTTP Request
    //NSLog(@"%@", body);
    [request setHTTPBody:body];
    
    
//set content length
    NSString *postLength =[NSString stringWithFormat:@"%lu", [body length]];
    NSString *bodyString;
    BOOL ok = YES;
    [NSString stringEncodingForData:body encodingOptions:kNilOptions convertedString:&bodyString usedLossyConversion:&ok];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    NSLog(@"post length : %@", postLength);
    NSLog(@"BODY DECODED: %@", bodyString);
    
/////////
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *uploadResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *result= [[NSString alloc] initWithData:uploadResponseData encoding:NSUTF8StringEncoding];
    
    //NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:uploadResponseData options:kNilOptions error:&error];
    if ([urlResponse statusCode]>=200 && [urlResponse statusCode]<300)
    {
        
    }
    
    if (error == nil)
    {NSLog(@"NO ERRORS");}
    if (result == nil)
    {NSLog(@"NIL RESULT");}
    else
    {
        NSLog(@"%@", result);
    }
    
    //need a better check here LATER
    /*if (![result isEqualToString:@""])
    {
        
        
        NSUserDefaults *appDefaults = [NSUserDefaults standardUserDefaults];
        
        
        NSString *uploaderId = [appDefaults objectForKey:@"userid"];
        NSString *uploadAddress = [NSString stringWithString:result];
        
       // NSString *uploadAddressTest = @"NONESCAPINGSTRING";
        
        
        //NSString *inputString2 = [NSString stringWithFormat:@"userFirstName=%@&userLastName=%@", uploaderId,uploadAddress];
        NSString *inputString2 = [NSString stringWithFormat:@"uploaderID=%@&uploadLocation=%@", uploaderId,uploadAddress];
        NSLog(@"inputstring = %@", inputString2);
        
        NSData *postData2 =[inputString2 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength2 = [NSString stringWithFormat:@"%lu", [postData2 length]];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]init];
        
        
        [request2 setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/insertinmedia.php"]];
        [request2 setHTTPMethod:@"POST"];
        [request2 setValue:postLength2 forHTTPHeaderField:@"Content-Length"];
        [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request2 setHTTPBody:postData2];
        
        NSHTTPURLResponse *urlResponse2 = nil;
        NSError *error2 = nil;
        NSData *responseData2 =[NSURLConnection sendSynchronousRequest:request2 returningResponse:&urlResponse2 error:&error2];
        //NSString *result2 =[[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
        NSLog(@"Response code: %lu", [urlResponse2 statusCode]);
        NSString *responseBody2 = [[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
        NSLog(@"RESPONSE BODY : %@", responseBody2);
        
        
    }*/
    
    [self.photoDelegate setProfilePicture:image];
    
    NSLog(@"Debug info:");
    NSLog(@"Response code: %lu", [urlResponse statusCode]);
    
    

}


 //UIImagePickerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.currentPhoto.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
