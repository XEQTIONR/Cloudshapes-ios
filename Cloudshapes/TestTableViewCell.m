//
//  TestTableViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-02-26.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell




- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _heading = [[UILabel alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize expectedSize = [_heading.text boundingRectWithSize:CGSizeMake(151, 300) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: _heading.font} context:nil].size;
    NSLog(@"Expected height: %f", expectedSize.height);
    
    // this code places the UILabel on each Cell
    _heading.frame = CGRectMake(0, 0, 151, expectedSize.height+10);
    _heading.numberOfLines = 0;
    self.testCellHeight = expectedSize.height+10;
    NSLog(@"testcellheight in layout subview %f", self.testCellHeight);
    [self addSubview:_heading];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
