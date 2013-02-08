//
//  ViewController.h
//  PicPick
//
//  Created by Benjamin Charley on 2/6/13.
//  Copyright (c) 2013 Benjamin Charley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIAlertViewDelegate>

@property BOOL newMedia;
//This is the image View
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview2;


//These are the use camera and use camera roll buttons
- (IBAction)useCamera1:(id)sender;
- (IBAction)useCameraRoll1:(id)sender;
//These are the alert buttons
- (IBAction)AlertButton1:(id)sender;
- (IBAction)AlertButton2:(id)sender;

@end
