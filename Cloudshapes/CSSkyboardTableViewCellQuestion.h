//
//  CSSkyboardTableViewCellQuestion.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-18.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell.h"

@interface CSSkyboardTableViewCellQuestion : CSSkyboardTableViewCell


@property (nonatomic,strong) UIButton       *answersButton;


@property (nonatomic,strong) NSNumber       *answerCount;
@property (nonatomic,strong) UIView         *answersButtonView;
@property (nonatomic,strong) UILabel        *answerCountLabel;
@property (nonatomic,strong) UILabel        *answerIconLabel;




@end
