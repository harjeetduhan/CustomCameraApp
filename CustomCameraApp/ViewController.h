//
//  ViewController.h
//  CustomCameraApp
//
//  Created by bliss on 22/05/17.
//  Copyright © 2017 bliss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(id)sender;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end

