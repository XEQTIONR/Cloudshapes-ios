//
//  CSSkyboardTableViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewController.h"
#import "CSSkyboardTableViewCell.h"
#import "TestTableViewCell.h"
#define LARGE_HEIGHT 1000

@interface CSSkyboardTableViewController ()

@end

@implementation CSSkyboardTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!self.posts)
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getskyboarddata.php"]];
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
            NSLog(@"jsonData.count = %lu", [jsonData count]);
            
            self.posts = jsonData;
        }
    }
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath:%ld called",indexPath.row);

     __unused NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Arial-ItalicMT" size:60]};
    
    //CSSkyboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell" forIndexPath:indexPath];
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Test Cell" forIndexPath:indexPath];
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    //cell.postText.text = [object objectForKey:@"posttext"];
    //cell.userFNName.text = [object objectForKey:@"postcreatoruserid"];
    
    cell.heading.text = [object objectForKey:@"posttext"];
    //[cell sizeToFit]; //fucks up the content aligning with cells
    
   /* __unused CGSize maximumLabelSize = CGSizeMake(296, LARGE_HEIGHT);
    
    NSLog(@"cell.post.text = %@", cell.postText.text);
    CGSize expectedLabelSize = [cell.postText.text sizeWithAttributes:attributes];
    NSLog(@"Expected label height %f", expectedLabelSize.height);
    CGRect newFrame = cell.postText.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.postText.frame = newFrame;
    */
    
   /*    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:60]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [cell.postText.text boundingRectWithSize:CGSizeMake(cell.postText.bounds.size.width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    //rect.origin.x = cell.postText.bounds.origin.x + 5;
    rect.origin.y = cell.postText.bounds.origin.y + 5;
    
    [[object objectForKey:@"posttext" ] drawWithRect:rect
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:attributes
                             context:nil];*/
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath:%lu called", indexPath.row);
    //  [tableView:tableView cellForRowAtIndexPath:indexPath].postText
    
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];

    
    @try
    {
        self.prototypeCell.heading.text = [object objectForKey:@"posttext"];
        [self.prototypeCell layoutSubviews];
        
        return MAX(self.prototypeCell.testCellHeight, 88.0f);
    }
    
    @catch (NSException *e)
    {
        NSLog(@"Exception: %@", e);
        return 100.0f;
    }
}

@end
