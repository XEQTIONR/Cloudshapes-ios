//
//  CSSkyboardTableViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell.h"

@interface CSSkyboardTableViewCell()


@end

@implementation CSSkyboardTableViewCell

- (void)like:(id)sender
{
    NSLog(@"like: function for postId:%@", self.postId);
    
    // Connect to like script here
}

- (void)comment:(id)sender
{
    NSLog(@"comment: function for postId:%@", self.postId);
    
    // Connect to comment script here
}

- (void)viewLikes:(id)sender
{
    NSLog(@"viewLikes: function for postId:%@", self.postId);
    
    // Navigate to a new view controller
    // Connect to view-likes script
    
}

- (void)viewComments:(id)sender
{
    // Navigate to a new view controller
    // Connect to view-comments script
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
        _postTypeLabel= [[UILabel alloc] init];
        
        
        //replace   // now we have just disabled actions on them
        //_likesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //_commentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //with these
        _likesButtonView = [[UIView alloc] init];
        _commentsButtonView = [[UIView alloc] init];
        _likeCountLabel = [[UILabel alloc] init];
        _commentCountLabel = [[UILabel alloc] init];
        _likeIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hearts-50.png"]];
        _commentIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Comments-50.png"]];
        
        
        _likeIconImage.userInteractionEnabled       = YES;
        _likeCountLabel.userInteractionEnabled      = YES;
        _commentIconImage.userInteractionEnabled    = YES;
        _commentCountLabel.userInteractionEnabled   = YES;
        
        _likeCountLabel.backgroundColor = [UIColor redColor];
        
        UITapGestureRecognizer *tapSeeLikes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewLikes:)];
        UITapGestureRecognizer *tapLike = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like:)];
        UITapGestureRecognizer *tapSeeComments = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewComments:)];
        UITapGestureRecognizer *tapComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comment:)];
        
        tapSeeLikes.delegate = self;
        tapLike.delegate = self;
        tapSeeComments.delegate = self;
        tapComment.delegate = self;
        
        [_likeCountLabel addGestureRecognizer:tapSeeLikes];
        [_likeIconImage addGestureRecognizer:tapLike];
        [_commentCountLabel addGestureRecognizer:tapSeeComments];
        [_commentIconImage addGestureRecognizer:tapComment];
        
        _profilePictureView.backgroundColor = [UIColor redColor];
        _postTypePictureView.backgroundColor = [UIColor blueColor];
        _postTypeLabel.backgroundColor = [UIColor blueColor];
        _heading.backgroundColor = [UIColor orangeColor];
        
        
        
        //_likesButton.backgroundColor = [UIColor redColor];
        //_commentsButton.backgroundColor = [UIColor blueColor];
        
        _likesButtonView.backgroundColor = [UIColor purpleColor];
        _commentsButtonView.backgroundColor = [UIColor magentaColor];
        
    }
    return self;
}

- (void) viewDidAppear
{
    NSLog(@"VIEW DID APPEAR CALLED");
   // _profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
}

#pragma mark - FIX THIS
- (void)layoutSubviews
{
    NSLog(@"    ------------------------- SkyboardTVCell  layoutSubview BEGIN{");
    [super layoutSubviews];
    
 
    //{MAX(a, self.bounds.size.with) | a is minimum width all the possible devices that use this app} - this fixes the problem. Just lookup a.
    _width =[UIScreen mainScreen].bounds.size.width;
    //_width = MAX(375,self.bounds.size.width); //375 width of portrait iphone 6. Fix this for all models.
    //why does changing width to self.bounds.size.width not work?? here but works in ^**
    //maybe because prototypes dont have bounds
    _buttonWidth = _width/3.0;
    CGSize expectedSize = [_heading.text boundingRectWithSize:CGSizeMake(_width, 2000)  options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: _heading.font} context:nil].size;

    NSLog(@"Expected height: %f", expectedSize.height);
    NSLog(@"Self.bounds.size.width: %f", self.bounds.size.width);
    
    _postTypePictureView.frame = CGRectMake((_width - _width/10.0), 0, _width/10.0, _width/10.0);
    NSLog(@"POST TYPE IS :    %@    ", _postType);
    NSLog(@"_heading.text is %@", _heading.text);
    NSLog(@"_fullNameLabel is %@", _fullNameLabel.text);
   
    
    // put these in subclasses
    if([_postType isEqualToString:@"Thought"])
    {
        NSLog(@"THOUGHT IDENTIFIED");
        _postTypePictureView.image = [UIImage imageNamed:@"POST_T_icon.png"];
        _postTypeLabel.text = @"posted a new thought.";
    }
    
    if([_postType isEqualToString:@"Question"])
    {
        NSLog(@"QUESTION IDENTIFIED");
        _postTypePictureView.image = [UIImage imageNamed:@"POST_Q_icon.png"];
        _postTypeLabel.text = @"posted a new question.";
    }
    
    if ([_postType isEqualToString:@"Poll"])
    {
        NSLog(@"POLL IDENTIFIED");
        _postTypePictureView.image = [UIImage imageNamed:@"POST_P_icon.png"];
        _postTypeLabel.text = @"posted a new poll.";
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
    
    _profilePictureView.frame = CGRectMake(0, 0, _width/5.0, _width/5.0);
    //DO NOT SET THE PICTURE HERE .. SET IT IN CellFRAIP
    //changes in CellFRAIP will not appear. As this method is called after CellFRAIP
    //_profilePictureView.image = [UIImage imageNamed:@"cs_alternate180square.png"]; // Default picture. Change this in viewDidAppear perhaps?  //Scarlett-Johansson2-400.jpg
         //Making the picture circular
    _profilePictureView.layer.cornerRadius = _profilePictureView.bounds.size.width/2;
    _profilePictureView.clipsToBounds = YES;
    
    _fullNameLabel.frame = CGRectMake(_profilePictureView.frame.size.width,
                                      0,
                                      _width - (_profilePictureView.frame.size.width
                                               + _postTypePictureView.frame.size.width),
                                      _profilePictureView.frame.size.height/2.0);
    _fullNameLabel.numberOfLines = 1;
    
    [self addSubview:_fullNameLabel];
    self.testCellHeight = _fullNameLabel.frame.size.height;
    
    _postTypeLabel.frame = CGRectMake(_profilePictureView.frame.size.width,
                                      self.testCellHeight,
                                      _width - (_profilePictureView.frame.size.width
                                                + _postTypePictureView.frame.size.width),
                                      _profilePictureView.frame.size.height/2.0);
    self.testCellHeight = _postTypeLabel.frame.size.height;
    
    [self addSubview:_postTypeLabel];
    
    
    
    self.testCellHeight = _profilePictureView.frame.size.height;
    [self addSubview:_profilePictureView];
    // this code places the UILabel on each Cell
    
    
    
    _heading.frame = CGRectMake(0, self.testCellHeight, _width, expectedSize.height);//^**
    _heading.numberOfLines = 0;
    self.testCellHeight += expectedSize.height;
    self.buttonAtHeight = self.testCellHeight;
    NSLog(@"testcellheight in layout subview %f", self.testCellHeight);
    NSLog(@"self.bounds.size.width2: %f", self.bounds.size.width);
    [self addSubview:_heading];
    
    
    
    
    //_likesButton.frame = CGRectMake(0, self.testCellHeight, buttonWidth, 30.0);
    //[_likesButton setTitle:@"Likes" forState:UIControlStateNormal];
    //[_likesButton addTarget:self action:@selector(like:)    forControlEvents:UIControlEventTouchUpInside];
    _likesButtonView.frame = CGRectMake(0, self.testCellHeight, _buttonWidth, 30.0);
    
    //_commentsButton.frame = CGRectMake(buttonWidth, self.testCellHeight, buttonWidth, 30.0);
    //[_commentsButton setTitle:@"Comments" forState:UIControlStateNormal];
    //[_commentsButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside]; // unnecessary. And even if it wasnt you should rather do this line in the init function
    _commentsButtonView.frame = CGRectMake(_buttonWidth, self.testCellHeight, _buttonWidth, 30.0);

    
    //_likeCount = [NSNumber numberWithInt:0];
    //_commentCount = [NSNumber numberWithInt:0];
    
    
    //_likesButtonView.frame = CGRectMake(0, self.testCellHeight, width/2, 30.0);
   // _likeIconImage.frame = CGRectMake(0, 0, _likesButton.frame.size.height, _likesButton.frame.size.height);
        _likeIconImage.frame = CGRectMake(0, 0, _likesButtonView.frame.size.height, _likesButtonView.frame.size.height);
    
    //[_likesButton addSubview:_likeIconImage];
    [_likesButtonView addSubview:_likeIconImage];
    
    //_likeCountLabel.frame = CGRectMake(_likesButton.frame.size.width/2, 0, _likesButton.frame.size.width/2, _likesButton.frame.size.height);
    _likeCountLabel.frame = CGRectMake(_likesButtonView.frame.size.width/2, 0, _likesButtonView.frame.size.width/2, _likesButtonView.frame.size.height);
    
    
    _likeCountLabel.numberOfLines = 1;
    
    
    //[_likesButton addSubview:_likeCountLabel];
    [_likesButtonView addSubview:_likeCountLabel];
    
    
    //_commentsButtonView.frame = CGRectMake(width/2, self.testCellHeight, width/2, 30.0);
    //_commentIconImage.frame = CGRectMake(0, 0, _commentsButton.frame.size.height, _commentsButton.frame.size.height);
    _commentIconImage.frame = CGRectMake(0, 0, _commentsButtonView.frame.size.height, _commentsButtonView.frame.size.height);
    //[_commentsButton addSubview:_commentIconImage];
    [_commentsButtonView addSubview:_commentIconImage];
    
    //_commentCountLabel.frame = CGRectMake(_commentsButton.frame.size.width/2, 0, _commentsButton.frame.size.width/2, _commentsButton.frame.size.height);
    _commentCountLabel.frame = CGRectMake(_commentsButtonView.frame.size.width/2, 0, _commentsButtonView.frame.size.width/2, _commentsButtonView.frame.size.height);
    _commentCountLabel.numberOfLines =1;
    
    //[_commentsButton addSubview:_commentCountLabel];
    [_commentsButtonView addSubview:_commentCountLabel];
    
    

    
    
    self.testCellHeight += 30.0;
    //[self addSubview:_likesButton];
    //[self addSubview:_commentsButton];
    
    [self addSubview:_likesButtonView];
    [self addSubview:_commentsButtonView];
    
    
    NSLog(@"    -------------------------}SkyboardTVCell layoutSubview END");
    
}

 
@end
