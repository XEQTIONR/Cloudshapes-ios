//
//  CSSkyboardTableViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell.h"

@implementation CSSkyboardTableViewCell



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _heading = [[UILabel alloc] init];
        _profilePictureView = [[UIImageView alloc] init];
        _postTypePictureView= [[UIImageView alloc] init];
        _likesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _commentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        _heading.backgroundColor = [UIColor orangeColor];
        _likesButton.backgroundColor = [UIColor purpleColor];
        _commentsButton.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
#pragma mark - FIX THIS 
    //{MAX(a, self.bounds.size.with) | a is minimum width all the possible devices that use this app} - this fixes the problem. Just lookup a.
    CGFloat width = MAX(375,self.bounds.size.width); //375 width of portrait iphone 6. Fix this for all models.
    //why does changing width to self.bounds.size.width not work?? here but works in ^**
    //maybe because prototypes dont have bounds
    CGSize expectedSize = [_heading.text boundingRectWithSize:CGSizeMake(width, 2000)  options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: _heading.font} context:nil].size;
    NSLog(@"Expected height: %f", expectedSize.height);
    NSLog(@"Self.bounds.size.width: %f", self.bounds.size.width);
    
    _postTypePictureView.frame = CGRectMake((width - width/10.0), 0, width/10.0, width/10.0);
    _postTypePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
    [self addSubview:_postTypePictureView];
                                            
    _profilePictureView.frame = CGRectMake(0, 0, width/5.0, width/5.0);
    _profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
    //Making the picture circular
    _profilePictureView.layer.cornerRadius = _profilePictureView.bounds.size.width/2;
    _profilePictureView.clipsToBounds = YES;
    
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
    
    _commentsButton.frame = CGRectMake(width/2, self.testCellHeight, width/2, 30.0);
    [_commentsButton setTitle:@"Comments" forState:UIControlStateNormal];
    
    self.testCellHeight += 30.0;
    [self addSubview:_likesButton];
    [self addSubview:_commentsButton];
    
    
    
    
}




    
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
