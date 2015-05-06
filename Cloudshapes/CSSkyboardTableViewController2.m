//
//  CSSkyboardTableViewController2.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewController2.h"
#import "CSSkyboardTableViewCell2.h"
@interface CSSkyboardTableViewController2 ()

-(void) getPostsFromServer;
@end

@implementation CSSkyboardTableViewController2


- (void) getPostsFromServer
{
    NSLog(@"getPostsFromServer");
    NSLog(@"This gets self.posts from server");
    if(!self.posts)
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getskyboarddata2.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:0 forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSHTTPURLResponse *response=nil;
        NSError *error = nil;
        NSData *skyboardPostData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:skyboardPostData options:kNilOptions error:&error];
        
        
        if ([response statusCode]>=200 && [response statusCode]<300) {
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
            NSLog(@"jsonData.count = %lu\n\n\n\n", [jsonData count]);
            
            self.posts = jsonData;
        }
    }
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Post Cell 2"];
    
    NSLog(@"Prototype Cell Created");

}
- (void)viewDidLoad {
    
    NSLog(@"ViewDidLoad CSSTVC2 called");
    [super viewDidLoad];
    [self getPostsFromServer];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger count = [self.posts count];
    NSLog(@"Number of rows in section returned : %lu", count);
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"CFRAIP : %ld",indexPath.row);
    
    if(self.posts == nil)
    {
        NSLog(@"self.posts nil");
    }
    //Our model
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    if (object == nil) {
        NSLog(@"object nil");
    }
    NSLog(@"POST ID : %@", [object objectForKey:@"postid"]);
    
    CSSkyboardTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell 2" forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    cell.postId.text = [object objectForKey:@"postid"];

    
    [cell layoutIfNeeded];
        cell.postTypePictureView.image = [UIImage imageNamed:@"POST-Q_icon.png"];
    NSLog(@"Description of UIImage : %@", [cell.postTypePictureView description]);
    
    
    return cell;
}



@end
