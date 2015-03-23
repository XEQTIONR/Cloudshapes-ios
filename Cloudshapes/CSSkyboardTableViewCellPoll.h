//
//  CSSkyboardTableViewCellPoll.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-21.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell.h"

@interface CSSkyboardTableViewCellPoll : CSSkyboardTableViewCell

@property (nonatomic,strong) NSNumber *voteCount;
@property (nonatomic,strong) UIView *votesButtonView;
@property (nonatomic,strong) UILabel *voteCountLabel;
@property (nonatomic,strong) UIImageView *voteIconImage;
@end


