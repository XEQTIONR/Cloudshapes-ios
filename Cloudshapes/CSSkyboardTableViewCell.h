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
@property (nonatomic,strong)NSNumber *postId;
@property float testCellHeight;
@property (nonatomic, strong)NSString *postType;


@property (nonatomic,strong) UIImageView *profilePictureView;
@property (nonatomic,strong) UIImageView *postTypePictureView;
@property (nonatomic,strong) UILabel *fullNameLabel;
@property UIButton *likesButton;
@property UIButton *commentsButton;




@end
