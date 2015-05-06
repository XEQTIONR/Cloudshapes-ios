//
//  CSAddOptionCollectionViewCell.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-22.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSAddOptionCollectionViewCell.h"


// this class is connected to a view controller in the storyboard
// but this class is obsolete
// remove with care

@implementation CSAddOptionCollectionViewCell


/*- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
    UITapGestureRecognizer *tapAddText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addText:)];
    UITapGestureRecognizer *tapAddPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto:)];
    
    tapAddText.delegate = self;
    tapAddPhoto.delegate = self;
    
    [self.addTextButtonIcon addGestureRecognizer:tapAddText];
    [self.addTextButtonLabel addGestureRecognizer:tapAddText];
    [self.addImageButtonIcon addGestureRecognizer:tapAddPhoto];
    [self.addImageButtonLabel addGestureRecognizer:tapAddPhoto];
    
    self.addTextButtonIcon.userInteractionEnabled = YES;
    self.addTextButtonLabel.userInteractionEnabled = YES;
    self.addImageButtonIcon.userInteractionEnabled = YES;
    self.addImageButtonLabel.userInteractionEnabled = YES;
    }
    
    return self;
}*/

- (void) viewDidLoad
{
    //[super viewDidLoad];
    /*UITapGestureRecognizer *tapAddText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addText)];
    UITapGestureRecognizer *tapAddPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    
   // tapAddText.delegate = self;
    //tapAddPhoto.delegate = self;
    
    [self.addTextButtonIcon addGestureRecognizer:tapAddText];
    [self.addTextButtonLabel addGestureRecognizer:tapAddText];
    [self.addImageButtonIcon addGestureRecognizer:tapAddPhoto];
    [self.addImageButtonLabel addGestureRecognizer:tapAddPhoto];
    
    self.addTextButtonIcon.userInteractionEnabled = YES;
    self.addTextButtonLabel.userInteractionEnabled = YES;
    self.addImageButtonIcon.userInteractionEnabled = YES;
    self.addImageButtonLabel.userInteractionEnabled = YES;
    */
}

- (void) addText
{
    NSLog(@"addText called.");
}

-(void) addPhoto
{
    NSLog(@"addPhoto called.");
}


@end
