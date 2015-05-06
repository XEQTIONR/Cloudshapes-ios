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
    UIAlertController *textInputAlert = [UIAlertController alertControllerWithTitle:@"Text Option" message:@"Add text option (20 characters max)." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    
        {
            NSLog(@"Looks like this code executes in a block");
            
            UITextField *textField =[textInputAlert.textFields objectAtIndex:0];
            NSString *text = textField.text;
            
            
            [self addTextPollOptionWithString:text];
            //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }];
    
    [textInputAlert addAction:defaultAction];
    
    
    [textInputAlert addTextFieldWithConfigurationHandler:nil];
    
    
    [self presentViewController:textInputAlert animated:YES completion:nil];
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

- (void) addTextPollOptionWithString : (NSString *)text
{
    NSString *localText = text;
    
    [self.cellData addObject:localText];
    
    NSLog(@"cellData count : %lu", (unsigned long)[self.cellData count]);
    NSIndexPath *index2 = [NSIndexPath indexPathForItem:[self.cellData indexOfObject:localText] inSection:0];
    
    //NSIndexPath *index = [NSIndexPath indexPathForItem:[self.cellData count] inSection:0];
    
    NSArray *pathArray = [NSArray arrayWithObject:index2];
    
    [self.pollOptionsCollectionView insertItemsAtIndexPaths:pathArray]; //look for single path function
    localText = nil; // safety, so image does not contain the previous data..
    
    
    
    //NSLog(@"Add test option with string works");
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.cellData addObject:image];
    NSLog(@"cellData count : %lu", (unsigned long)[self.cellData count]);
    NSIndexPath *index2 = [NSIndexPath indexPathForItem:[self.cellData indexOfObject:image] inSection:0];
    
    //NSIndexPath *index = [NSIndexPath indexPathForItem:[self.cellData count] inSection:0];
    
    NSArray *pathArray = [NSArray arrayWithObject:index2];
    
    [self.pollOptionsCollectionView insertItemsAtIndexPaths:pathArray]; //look for single path function 
    image = nil; // safety, so image does not contain the previous data..
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //self.cellData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],nil];
    self.cellData = [NSMutableArray arrayWithObjects: nil]; // initialize our empty options array
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
    
        CSPollOptionTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"New Poll View Cell" forIndexPath:indexPath];
    
    // Configure the cell
        cell.pollOptionTextLabel.text = [self.cellData objectAtIndex:[indexPath row]];
        //cell.backgroundColor = [UIColor blueColor];
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


