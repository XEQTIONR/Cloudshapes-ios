//
//  CSSkyboardTableViewCellPoll.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-21.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCellPoll.h"

@implementation CSSkyboardTableViewCellPoll

- (void) vote:(id)sender
{
    NSLog(@"vote function for postId : %@", self.postId);
    //vote script goes here
}


- (void) viewVotes:(id)sender
{
    NSLog(@"viewVotes function for postId : %@", self.postId);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.voteCountLabel = [[UILabel alloc] init];
        self.voteIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checklist Filled-50.png"]];
        self.votesButtonView = [[UIView alloc] init];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _votesButtonView.frame = CGRectMake(2*self.buttonWidth, self.buttonAtHeight, self.buttonWidth, 30.0);
    _votesButtonView.backgroundColor = [UIColor greenColor];
    
    _voteIconImage.frame = CGRectMake(0, 0, _votesButtonView.frame.size.height/2.0, _votesButtonView.frame.size.height/2.0);
    _voteCountLabel.frame = CGRectMake(_votesButtonView.frame.size.width/2.0, 0, _votesButtonView.frame.size.width/2.0,_votesButtonView.frame.size.height);
    _voteCountLabel.numberOfLines = 1;
    
    [_votesButtonView addSubview:_voteCountLabel];
    [_votesButtonView addSubview:_voteIconImage];
    
    [self addSubview:_votesButtonView];


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
