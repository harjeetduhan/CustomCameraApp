//
//  ViewController.m
//  CustomCameraApp
//
//  Created by bliss on 22/05/17.
//  Copyright © 2017 bliss. All rights reserved.
//

#import "ViewController.h"
#import "CellCollectionView.h"

@interface ViewController ()
{
     NSMutableArray *imageCollection, *selectedCollection;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    imageCollection =[[NSMutableArray alloc] init];
    selectedCollection =[[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }else{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:picker animated:YES completion:NULL];
}
}


#pragma -mark   Image Picker delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    NSData *imgData = UIImageJPEGRepresentation(chosenImage, 0.9);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [imageCollection addObject:imgData];
    NSLog(@"Count -- %lu", (unsigned long)[imageCollection count]);
    [self.collectionView reloadData];    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



#pragma -mark   Collection view delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageCollection count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Count in clooection view -- %lu", (unsigned long)[imageCollection count]);
    CellCollectionView *cell = (CellCollectionView*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //cell.self.ImgCheck.hidden=NO;
    cell.ImgCheck.tag=indexPath.row;
    cell.contentView.backgroundColor = [UIColor whiteColor];
       cell.self.imgCollection.image=[UIImage imageWithData:[imageCollection objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    CellCollectionView *cell = [collectionView cellForItemAtIndexPath:indexPath];
       NSLog(@"Selected index value is  -- %lu", (unsigned long)indexPath.row);    
    
    NSString*temp=[imageCollection objectAtIndex:indexPath.row];
     if (![selectedCollection containsObject:temp])
    {
        [selectedCollection addObject:temp];
        //cell.self.ImgCheck.hidden=NO;
        cell.ImgCheck.tag=indexPath.row;
        cell.ImgCheck.hidden=NO;
        //[cell.self.imgCollection bringSubviewToFront: cell.ImgCheck];
        cell.contentView.backgroundColor = [UIColor redColor];
        NSLog(@"Selected");
       // cell.backgroundColor=[UIColor redColor];
        NSLog(@"Count in selected clooection view -- %lu", (unsigned long)[selectedCollection count]);  
        self.imageView.image=[UIImage imageWithData:[imageCollection objectAtIndex:indexPath.row]];
    }
    else
    {      
        [selectedCollection removeObject:temp];
        //cell.self.ImgCheck.hidden=YES;
        cell.ImgCheck.hidden=YES;
         cell.contentView.backgroundColor = [UIColor grayColor];
         cell.backgroundColor=[UIColor grayColor];
         NSLog(@"DeSelected");
         NSLog(@"Count in after deselected clooection view -- %lu", (unsigned long)[selectedCollection count]);
    }
}

@end
