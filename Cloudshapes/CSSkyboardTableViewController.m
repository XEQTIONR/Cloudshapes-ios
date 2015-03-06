//
//  CSSkyboardTableViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewController.h"
#define LARGE_HEIGHT 1000

@interface CSSkyboardTableViewController ()

@end

@implementation CSSkyboardTableViewController

- (void)viewDidLoad
{
    NSLog(@"Skyboard TVC viewDidLoadCalled..........");
    [super viewDidLoad];
    
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
            NSLog(@"jsonData.count = %lu", [jsonData count]);
            
            self.posts = jsonData;
        }
    }
    
    NSLog(@"BEFORE self.prototypeCell dequeReusable Idebtifier POST CELL");
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Post Cell"];
    NSLog(@"AFTER self.prototypeCell dequeReusable Idebtifier POST CELL");
    
    
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"------------------------- SkyboardTableViewController  cellFRAIP BEGIN");
    
    NSLog(@"cellForRowAtIndexPath:%ld called BEFORE DEQUE",indexPath.row);
    
    
    CSSkyboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell" forIndexPath:indexPath];
    NSLog(@"AFTER DEQUE");
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    cell.heading.text = [object objectForKey:@"posttext"];
    cell.fullNameLabel.text = [[object objectForKey:@"userfname"] stringByAppendingString: [object objectForKey:@"userlname"]];


    cell.postType = [object objectForKey:@"posttype"];
 
 if([cell.postType isEqualToString:@"Thought"])
 {
 NSLog(@"THOUGHT IDENTIFIED");
 cell.profilePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
 }
 
    //[cell layoutSubviews];
 
 
NSLog(@"------------------------- SkyboardTableViewController  cellFRAIP END RETURN cell");
 return cell;
 
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-------------------------heightFRAIP BEGIN");
    NSLog(@"heightForRowAtIndexPath:%lu called", indexPath.row);
    //  [tableView:tableView cellForRowAtIndexPath:indexPath].postText
    
    
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    @try
    {
        self.prototypeCell.heading.text = [object objectForKey:@"posttext"];
        self.prototypeCell.postType = [object objectForKey:@"posttype"]; // we pass the post type now rather than later
        
       /* if ([self.prototypeCell.postType isEqualToString:@"Thought"])
        {
            self.prototypeCell.postTypePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
        }
        else if([self.prototypeCell.postType isEqualToString:@"Question"])
        {
            self.prototypeCell.postTypePictureView.image = [UIImage imageNamed:@"POST_Q_icon.png"];
        }*/



        NSLog(@"self.protoypecell.posttype = %@", self.prototypeCell.postType);
        [self.prototypeCell layoutSubviews];//LAYOUT SUBVIEWS
                NSLog(@"prototypecell .testcellheight : %f", self.prototypeCell.testCellHeight);
NSLog(@"-------------------------heightFRAIP END RETURN HEIGHT\n\n\n\n\n");
        return self.prototypeCell.testCellHeight;
    }
    
    @catch (NSException *e)
    {
        NSLog(@"Exception: %@", e);
        return 100.0f;
    }
}

@end
