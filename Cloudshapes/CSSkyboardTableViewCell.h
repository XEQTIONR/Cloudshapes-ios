//
//  CSSkyboardTableViewCell.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-13.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSSkyboardTableViewCell : UITableViewCell

//stub property that we are using to test dynamic height
@property (nonatomic,strong) UILabel *heading;


//public properties
@property (nonatomic,strong)NSNumber        *postId;
@property float                             testCellHeight; // change this to NSNumber later
@property CGFloat                           width;
@property CGFloat                           buttonWidth;
@property CGFloat                           buttonAtHeight;
@property (nonatomic, strong)NSString       *postType;


@property (nonatomic,strong) NSNumber       *likeCount;
@property (nonatomic,strong) NSNumber       *commentCount;



@property (nonatomic,strong) UIImageView    *profilePictureView;
@property (nonatomic,strong) UIImageView    *postTypePictureView;
@property (nonatomic,strong) UILabel        *fullNameLabel;


//trying to replace these buttons ^^
@property (nonatomic,strong) UIButton       *likesButton;
@property (nonatomic,strong) UIButton       *commentsButton;


// ^^ with these custom views
@property (nonatomic,strong) UIView         *likesButtonView;
@property (nonatomic,strong) UIView         *commentsButtonView;
@property (nonatomic,strong) UILabel        *likeCountLabel;
@property (nonatomic,strong) UILabel        *commentCountLabel;
@property (nonatomic,strong) UIImageView    *likeIconImage;
@property (nonatomic,strong) UIImageView    *commentIconImage;

//should any of these be weak? arent outlets supposed to be weak?? or is that only IBOutlets???



@end
