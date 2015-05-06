//
//  CSSkyboardTableViewCell2.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-03-05.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSSkyboardTableViewCell2.h"

@implementation CSSkyboardTableViewCell2




- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Init with coder called");
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _profilePictureView = [[UIImageView alloc] init];
        _postTypePictureView = [[UIImageView alloc] init];
        _postId = [[UILabel alloc] init];
        
        
        _profilePictureView.backgroundColor = [UIColor grayColor];
        _postTypePictureView.backgroundColor = [UIColor greenColor];
        _postId.backgroundColor = [UIColor magentaColor];
    }
    return self;
}

-(void) layoutIfNeeded
{
    NSLog(@"Layout if needed called.");
    
    _postTypePictureView.frame = CGRectMake(0, 0, self.bounds.size.width/5.0, self.bounds.size.width/5.0);
    //NSString *postType =
    //_postTypePictureView.image = [UIImage imageNamed:@"Scarlett-Johansson2-400.jpg"];
    
    NSLog(@"Description of UIImage in layoutifneeded : %@", [_postTypePictureView description]);
    
    [self addSubview:_postTypePictureView];
    
    _postId.frame = CGRectMake(0, _postTypePictureView.frame.size.height, self.bounds.size.width, (self.bounds.size.height/3));
    [self addSubview:_postId];
}


@end
