//
//  NewPollViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-23.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPollViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) NSMutableArray *cellData; //model - temporary


@property (weak, nonatomic) IBOutlet UICollectionView *pollOptionsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *addTextButton;


@end
