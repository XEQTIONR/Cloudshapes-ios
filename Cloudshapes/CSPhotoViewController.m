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
    
    /*
    NSData *imageData = UIImageJPEGRepresentation(image, 0.9);
    NSString *urlString = @"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/upload.php";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------6251453646545616536172636";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary %@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n"]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type:application/octet-stream\r\n\r\n"]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"return String %@", returnString);
    */
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/uploadtest.php"]];
    
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
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    NSLog(@"post length : %@", postLength);
    
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
    
    NSLog(@"Debug info:");
    NSLog(@"Response code: %lu", [urlResponse statusCode]);
    
    
    /*
 
    //NSString *imageTitle = @"thisimageuploaded";
    NSData *imageData = UIImageJPEGRepresentation(image, 0.9); // 0.9 as in 90%.. Wonder why no []
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //boundary for data
    NSString *boundary =@"----BoundaryRandomString xC1rHU7SjK3UpHwrqGtYuiH";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    
    // setting HTTP Request Properties
    
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/uploadimage.php"]];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    //setting HTTP Body
    
                    //initilize body
    NSMutableData *body = [[NSMutableData alloc] initWithData:imageData];
                    //boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
                    //add the title
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream \r\n" dataUsingEncoding:NSASCIIStringEncoding]];
                    //image data
    [body appendData:imageData];
                    //boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    
    
    
    //// setting the body of the post request after appending data to the body
    [request setHTTPBody:body];
    
    
    
    // Connecting to the web
    ////note to self : Implement response and error-handling
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
    
    
    
    //Log our
    NSLog(returnString);
    
   
    
    
    
    //add boundary to where the file starts
    //[body appendData:[[NSString stringWithFormat:@"\r\n--%@", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    
    //form field???
    
 */
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
