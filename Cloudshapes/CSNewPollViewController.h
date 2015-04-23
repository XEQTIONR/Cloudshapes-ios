//
//  CSNewPollViewController.h
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-15.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCollectionViewCell.h"
#import "CSAddOptionCollectionViewCell.h"

@interface CSNewPollViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *pollTextView;


@property (weak, nonatomic) IBOutlet UICollectionView *pollOptionsCollectionView;

@end
