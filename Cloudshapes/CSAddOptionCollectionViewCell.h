//
//  CSAddOptionCollectionViewCell.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-22.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

// this class is connected to a view controller in the storyboard
// but this class is obsolete
// remove with care
@interface CSAddOptionCollectionViewCell : UICollectionViewCell 
@property (weak, nonatomic) IBOutlet UIImageView *addTextButtonIcon;
@property (weak, nonatomic) IBOutlet UILabel *addTextButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addImageButtonIcon;
@property (weak, nonatomic) IBOutlet UILabel *addImageButtonLabel;

-(void) addText;

-(void) addPhoto;

@end
