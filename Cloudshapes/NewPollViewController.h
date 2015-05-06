//
//  NewPollViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-23.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCollectionViewCell.h"
#import "CSPollOptionTextCollectionViewCell.h"
#import "CSNewPostViewController.h"

@interface NewPollViewController :  CSNewPostViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) NSMutableArray *cellData; //model - temporary


@property (weak, nonatomic) IBOutlet UICollectionView *pollOptionsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *addTextButton;


@property (strong, nonatomic) UIImagePickerController *imagePickerController;


@end
