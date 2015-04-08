//
//  CSSkyboardTableViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewController.h"
#import "CSSkyboardTableViewCellQuestion.h"
#import "CSSkyboardTableViewCellPoll.h"
#define LARGE_HEIGHT 1000

@interface CSSkyboardTableViewController ()

@end

@implementation CSSkyboardTableViewController

- (void)viewDidLoad
{
  ///  NSLog(@"Skyboard TVC viewDidLoadCalled..........");
    [super viewDidLoad];
    
    if(!self.posts)
    {
        //1. gather input
        
        
        //2. encode input data, calculate length
        
        //3. init and setup request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:@"http://ec2-54-173-125-187.compute-1.amazonaws.com/scripts/getposts9.php"]]; //previously getskyboarddata2.php
        [request setHTTPMethod:@"POST"];
        [request setValue:0 forHTTPHeaderField:@"Content-Length"]; // currently passing no body , so length is 0(zero)
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        //4. allocate variables for URL response and  NS error
        NSHTTPURLResponse *response=nil;
        NSError *error = nil;
        
        
        //5. fire request, receive data, get HTTP Response
        NSData *skyboardPostData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:skyboardPostData options:kNilOptions error:&error]; // decoding data
        
        
        if ([response statusCode]>=200 && [response statusCode]<300)
        {
            NSLog(@"response status code: %ld", [response statusCode]);
        }
        
        if (error == nil){NSLog(@"NO ERRORS");}
        
        if (jsonData == nil)
        {
            NSLog(@"NIL RESULT");
        }
        else
        {
            NSLog(@"%@", jsonData);
            //NSLog(@"AND R1:");      //jsonData is a NSArray -->NSDictionary previously
            NSLog(@"jsonData.count = %lu", [jsonData count]);
            
            self.posts = jsonData; // initialize our model with the received data
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

- (void) viewDidLayoutSubviews
{
 
    
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
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
    
    
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    NSString *postType = [object objectForKey:@"posttype"];
    
    CSSkyboardTableViewCell *cell;
    //id cell;
    if ([postType compare:@"Question"] == NSOrderedSame)
    {
        CSSkyboardTableViewCellQuestion *cell2 = [tableView dequeueReusableCellWithIdentifier:@"Question Cell" forIndexPath:indexPath];
        //CSSkyboardTableViewCellQuestion *cellSubclass = cell;
        cell2.answerCount = [NSNumber numberWithInt:5];
        cell2.answerCountLabel.text = [NSString stringWithFormat:@"%d", [cell2.answerCount intValue]];
        cell = cell2;
        
    }
    
    else if([postType compare:@"Poll"] == NSOrderedSame)
    {
        CSSkyboardTableViewCellPoll *cell3 = [tableView dequeueReusableCellWithIdentifier:@"Poll Cell" forIndexPath:indexPath];
        cell3.voteCount = [NSNumber numberWithInt:53];
        cell3.voteCountLabel.text = [NSString stringWithFormat:@"%d", [cell3.voteCount intValue ]];
        cell = cell3;
        
    }
    
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell" forIndexPath:indexPath];
    }

    
    NSLog(@"AFTER DEQUE");
    
    cell.postType = [object objectForKey:@"posttype"];
    cell.heading.text = [object objectForKey:@"posttext"];
    cell.fullNameLabel.text = [[object objectForKey:@"userfname"] stringByAppendingString: [object objectForKey:@"userlname"]];
    


    
    
    cell.profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
 
    NSString *filePath = [object objectForKey:@"mediafilepath"];
    NSString *baseString =@"http://ec2-54-173-125-187.compute-1.amazonaws.com/";
    baseString = [baseString stringByAppendingString:filePath];
    
    NSData *profilePictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseString]];
    UIImage *image = [UIImage imageWithData:profilePictureData];
    cell.profilePictureView.image = image;
// following if block is unnecessary because we change the picture in layoutSubview method of the cell
 /*if([cell.postType isEqualToString:@"Thought"])
 {
 NSLog(@"THOUGHT IDENTIFIED");
 cell.profilePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
 }*/
 
    //[cell layoutSubviews];
    
    cell.likeCount = [NSNumber numberWithInt:6];
    cell.commentCount = [NSNumber numberWithInt:2];
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%d",[cell.likeCount intValue]];
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%d", [cell.commentCount intValue]];
    cell.postId = [object objectForKey:@"postid"];
 
NSLog(@"------------------------- SkyboardTableViewController  cellFRAIP END RETURN cell");
 return cell;
 
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-------------------------heightFRAIP BEGIN");
    NSLog(@"heightForRowAtIndexPath:%lu called", indexPath.row);
    
    NSDictionary *object = [self.posts objectAtIndex:indexPath.row];
    
    @try
    {
        self.prototypeCell.heading.text = [object objectForKey:@"posttext"];
       // self.prototypeCell.postType = [object objectForKey:@"posttype"]; // we pass the post type now rather than later

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
