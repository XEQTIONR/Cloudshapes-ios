//
//  CSSkyboardTableViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell.h"

@implementation CSSkyboardTableViewCell

- (void)like:(id)sender
{
    NSLog(@"Like button stub.");
}

-(void)comment:(id)sender
{
    NSLog(@"Comment button stub.");
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        NSLog(@"CSSkyboardTableViewCell initWithCoder called");
        _heading = [[UILabel alloc] init];
        _fullNameLabel = [[UILabel alloc]init];
        _profilePictureView = [[UIImageView alloc] init];
        _postTypePictureView= [[UIImageView alloc] init];
        _likesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _commentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        _profilePictureView.backgroundColor = [UIColor redColor];
        _postTypePictureView.backgroundColor = [UIColor blueColor];
        _heading.backgroundColor = [UIColor orangeColor];
        _likesButton.backgroundColor = [UIColor purpleColor];
        _commentsButton.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void) viewDidAppear
{
    NSLog(@"VIEW DID APPEAR CALLED");
    _profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
}

#pragma mark - FIX THIS
- (void)layoutSubviews
{
    NSLog(@"    ------------------------- SkyboardTVCell  layoutSubview BEGIN{");
    [super layoutSubviews];
    
 
    //{MAX(a, self.bounds.size.with) | a is minimum width all the possible devices that use this app} - this fixes the problem. Just lookup a.
    CGFloat width = MAX(375,self.bounds.size.width); //375 width of portrait iphone 6. Fix this for all models.
    //why does changing width to self.bounds.size.width not work?? here but works in ^**
    //maybe because prototypes dont have bounds
    CGSize expectedSize = [_heading.text boundingRectWithSize:CGSizeMake(width, 2000)  options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: _heading.font} context:nil].size;

    NSLog(@"Expected height: %f", expectedSize.height);
    NSLog(@"Self.bounds.size.width: %f", self.bounds.size.width);
    
    _postTypePictureView.frame = CGRectMake((width - width/10.0), 0, width/10.0, width/10.0);
    NSLog(@"POST TYPE IS :    %@    ", _postType);
    NSLog(@"_heading.text is %@", _heading.text);
    NSLog(@"_fullNameLabel is %@", _fullNameLabel.text);
   
    if([_postType isEqualToString:@"Thought"])
    {
        NSLog(@"THOUGHT IDENTIFIED");
        _postTypePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
    }
    
    if([_postType isEqualToString:@"Question"])
    {
        NSLog(@"QUESTION IDENTIFIED");
        _postTypePictureView.image = [UIImage imageNamed:@"POST_Q_icon.png"];
    }
    // following if-else is unnecessary
    if (!_postTypePictureView.image)
    {
        NSLog(@"PICTURE NIL");


    }
    else
    {
        NSLog(@"PICTURE NOT NIL");

    }
///////////////////////////CHECK HERE
    //NSLog(@"heading : %@", _heading.text);
    [self addSubview:_postTypePictureView];
    
    _profilePictureView.frame = CGRectMake(0, 0, width/5.0, width/5.0);
    //DO NOT SET THE PICTURE HERE .. SET IT IN CellFRAIP
    //changes in CellFRAIP will not appear. As this method is called after CellFRAIP
    //_profilePictureView.image = [UIImage imageNamed:@"cs_alternate180square.png"]; // Default picture. Change this in viewDidAppear perhaps?  //Scarlett-Johansson2-400.jpg
         //Making the picture circular
    _profilePictureView.layer.cornerRadius = _profilePictureView.bounds.size.width/2;
    _profilePictureView.clipsToBounds = YES;
    
    _fullNameLabel.frame = CGRectMake(_profilePictureView.frame.size.width,
                                      0,
                                      width - (_profilePictureView.frame.size.width
                                               + _postTypePictureView.frame.size.width),
                                      _profilePictureView.frame.size.height);
    _fullNameLabel.numberOfLines = 1;
    [self addSubview:_fullNameLabel];
    
    
    self.testCellHeight = _profilePictureView.frame.size.height;
    [self addSubview:_profilePictureView];
    // this code places the UILabel on each Cell
    
    _heading.frame = CGRectMake(0, self.testCellHeight, width, expectedSize.height);//^**
    _heading.numberOfLines = 0;
    self.testCellHeight += expectedSize.height;
    NSLog(@"testcellheight in layout subview %f", self.testCellHeight);
    NSLog(@"self.bounds.size.width2: %f", self.bounds.size.width);
    [self addSubview:_heading];
    
    
    _likesButton.frame = CGRectMake(0, self.testCellHeight, width/2, 30.0);
    [_likesButton setTitle:@"Likes" forState:UIControlStateNormal];
    [_likesButton addTarget:self action:@selector(like:)    forControlEvents:UIControlEventTouchUpInside];
    
    
    _commentsButton.frame = CGRectMake(width/2, self.testCellHeight, width/2, 30.0);
    [_commentsButton setTitle:@"Comments" forState:UIControlStateNormal];
    [_commentsButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.testCellHeight += 30.0;
    [self addSubview:_likesButton];
    [self addSubview:_commentsButton];
    
    
    NSLog(@"    -------------------------}SkyboardTVCell layoutSubview END");
    
}


@end
