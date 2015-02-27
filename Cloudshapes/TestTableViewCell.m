//
//  TestTableViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-26.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell()


//post creator info
@property (nonatomic, strong) UIImage   *postCreatorPicture;
@property (nonatomic, strong) NSString  *postCreatorID;
@property (nonatomic, strong) NSString  *postCreatorName;



//post info
@property (nonatomic, strong) NSDate    *postDateTime;
@property (nonatomic, strong) NSString  *postLocation;
@property (nonatomic, strong) NSString  *postType;
@property (nonatomic, strong) NSString  *postText;
@property (nonatomic)         NSInteger  postLikeCount;
@property (nonatomic)         NSInteger  postCommentCount;



@end

@implementation TestTableViewCell




- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _heading = [[UILabel alloc] init];
        _profilePictureView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = MAX(375,self.bounds.size.width);
    //why does changing width to self.bounds.size.width not work?? here but works in ^**
    //maybe because prototypes dont have bounds
    CGSize expectedSize = [_heading.text boundingRectWithSize:CGSizeMake(width, 2000)  options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: _heading.font} context:nil].size;
    NSLog(@"Expected height: %f", expectedSize.height);
    NSLog(@"Self.bounds.size.width: %f", self.bounds.size.width);
    
    
    _profilePictureView.frame = CGRectMake(0, 0, width/5.0, width/5.0);
    _profilePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
    self.testCellHeight = _profilePictureView.frame.size.height;
    // this code places the UILabel on each Cell
    
    _heading.frame = CGRectMake(0, self.testCellHeight, width, expectedSize.height);//^**
    _heading.numberOfLines = 0;
    self.testCellHeight += expectedSize.height;
    NSLog(@"testcellheight in layout subview %f", self.testCellHeight);
    NSLog(@"self.bounds.size.width2: %f", self.bounds.size.width);
    [self addSubview:_heading];
    

    [self addSubview:_profilePictureView];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
