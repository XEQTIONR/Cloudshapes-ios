//
//  CSSkyboardTableViewCellQuestion.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-18.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCellQuestion.h"

@implementation CSSkyboardTableViewCellQuestion

- (void) answer:(id)sender
{
    NSLog(@"answer function for postId : %@", self.postId);
    
    // answer script here
}


- (void) viewAnswers:(id)sender
{
    NSLog(@"viewAnswers function for postId : %@", self.postId);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        NSLog(@"CSSkyboardTableViewQUESTION initWithCoder called");
        self.answerIconLabel = [[UILabel alloc] init];
        self.answerIconLabel.text = @"A:  ";
        self.answerCountLabel = [[UILabel alloc] init];
        self.answersButtonView = [[UIView alloc] init];
    }
    

    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
     _answersButtonView.frame = CGRectMake(2*self.buttonWidth, self.buttonAtHeight, self.buttonWidth, 30.0);
    _answersButtonView.backgroundColor = [UIColor cyanColor];
    
    _answerIconLabel.frame = CGRectMake(0, 0, _answersButtonView.frame.size.height, _answersButtonView.frame.size.height);
    [_answersButtonView addSubview:_answerIconLabel];
    
    _answerCountLabel.frame = CGRectMake(_answersButtonView.frame.size.width/2, 0, _answersButtonView.frame.size.width/2.0, _answersButtonView.frame.size.height);
    _answerCountLabel.numberOfLines = 1;
    [_answersButtonView addSubview:_answerCountLabel];
    
    [self addSubview:_answersButtonView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
