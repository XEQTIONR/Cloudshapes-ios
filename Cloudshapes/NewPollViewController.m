//
//  NewPollViewController.m
//  Cloudshapes
//
//  Created by Ishtehar Hussain on 2015-04-23.
//  Copyright (c) 2015 Cloudshapes. All rights reserved.
//

#import "NewPollViewController.h"

@implementation NewPollViewController

- (IBAction)cancel:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:self completion:nil];
}


- (IBAction)add:(id)sender {
    
    //[self.cellData addObject:[NSNumber numberWithInt:5]];
    
    NSArray *itemsPaths = [self.pollOptionsCollectionView indexPathsForSelectedItems];
    
    
    
    NSLog(@"Array : %@", itemsPaths);
    
    
    [self.cellData addObject:[NSNumber numberWithInt:1]];

    NSMutableArray *itemsPaths2 = [[NSMutableArray alloc] initWithObjects: nil];
    
    NSIndexPath *tempPath;
    
    for (int i=0; i<self.cellData.count; i++) // buggy code.... here i<= check off by one error...
    {
        tempPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [itemsPaths2 addObject:tempPath];
        
    
    }
    
    NSArray *lastPath = [NSArray arrayWithObjects:tempPath, nil];
    [self.pollOptionsCollectionView insertItemsAtIndexPaths:lastPath]; //This does all the CFRAIP work
    
}


- (IBAction)addImageOption:(id)sender
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else
    {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
    

    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.cellData addObject:image];
    NSLog(@"cellData count : %lu", (unsigned long)[self.cellData count]);
    NSIndexPath *index2 = [NSIndexPath indexPathForItem:[self.cellData indexOfObject:image] inSection:0];
    
    //NSIndexPath *index = [NSIndexPath indexPathForItem:[self.cellData count] inSection:0];
    
    NSArray *pathArray = [NSArray arrayWithObject:index2];
    
    [self.pollOptionsCollectionView insertItemsAtIndexPaths:pathArray];
    image = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //self.cellData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],nil];
    self.cellData = [NSMutableArray arrayWithObjects: nil];
    // Register cell classes
    //[self.pollOptionsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.pollOptionsCollectionView.dataSource =self;
    self.pollOptionsCollectionView.delegate=self;
    
    // We can do the following in IB
    //[self.addTextButton setTitle:@" Normal" forState:UIControlStateNormal];
    //[self.addTextButton setImage:[UIImage imageNamed:@"Add Image-64"] forState:UIControlStateNormal];
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
    return [self.cellData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[self.cellData objectAtIndex:[indexPath row]] class]==[UIImage class])
    {
        TestCollectionViewCell *cell;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"New Picture Option Cell" forIndexPath:indexPath];
        
        //TestCollectionViewCell *cell2 = cell;
        cell.imageView.image = [self.cellData objectAtIndex:[indexPath row]];
        
        return cell;
        
    }
    
    else
        
    {
    
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"New Poll View Cell" forIndexPath:indexPath];
    
    // Configure the cell
        cell.backgroundColor = [UIColor blueColor];
        return cell;
        
    }
    
    
    
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
    cell.contentView.backgroundColor = [UIColor blueColor];
}


@end


