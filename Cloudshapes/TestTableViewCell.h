//
//  TestTableViewCell.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-26.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewCell : UITableViewCell


//stub property that we are using to test dynamic height
@property (nonatomic,strong) UILabel *heading;


//public properties
@property float testCellHeight;


@property (nonatomic,strong) UIImageView *profilePictureView;
@property (nonatomic,strong) UILabel *fullNameLabel;
@property UIButton *likesButton;
@property UIButton *commentsButton;
@end