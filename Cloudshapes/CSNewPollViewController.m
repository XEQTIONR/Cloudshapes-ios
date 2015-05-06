//
//  CSNewPollViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-15.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "CSNewPollViewController.h"

@interface CSNewPollViewController ()

@end

@implementation CSNewPollViewController

static NSString * const reuseIdentifier = @"Bell";

- (IBAction)cancel:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:self completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Register cell classes
    //[self.pollOptionsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.pollOptionsCollectionView.dataSource =self;
    self.pollOptionsCollectionView.delegate=self;
   // self.imagePickerController.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //#warning Incomplete method implementation -- Return the number of sections
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSAddOptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Add Cell" forIndexPath:indexPath];
    
    // Configure the cell
    //CGFloat flat = 25.0;
    
    //cell.backgroundColor = [UIColor blueColor];
    
    //a single gesture recognizer is for a single view;
    UITapGestureRecognizer *tapAddTextIcon = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(addText)];
    UITapGestureRecognizer *tapAddTextLabel = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(addText)];
    UITapGestureRecognizer *tapAddPhotoIcon = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(addPhoto)];
    UITapGestureRecognizer *tapAddPhotoLabel = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(addPhoto)];
    
   // tapAddText.delegate = cell;
   // tapAddPhoto.delegate = cell;
    
    [cell.addTextButtonIcon addGestureRecognizer:tapAddTextIcon];
    [cell.addTextButtonLabel addGestureRecognizer:tapAddTextLabel];
    [cell.addImageButtonIcon addGestureRecognizer:tapAddPhotoIcon];
    [cell.addImageButtonLabel addGestureRecognizer:tapAddPhotoLabel];
    
    cell.addTextButtonIcon.userInteractionEnabled = YES;
    cell.addTextButtonLabel.userInteractionEnabled = YES;
    cell.addImageButtonIcon.userInteractionEnabled = YES;
    cell.addImageButtonLabel.userInteractionEnabled = YES;
    
    
    /*if ((indexPath.row)%2) {
        
        cell.imageView.image = [UIImage imageNamed:@"Binoculars-32.png"];
    }
    else cell.imageView.image = [UIImage imageNamed:@"User Male Circle-32.png"];
    */
    return cell;

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldSelectItemAtIndexPath called.");
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}
/*- (void) addText
{
    NSLog(@"Add text in Controller");
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
