//
//  ViewController.m
//  PicPick
//
//  Created by Benjamin Charley on 2/6/13.
//  Copyright (c) 2013 Benjamin Charley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end


@implementation ViewController

BOOL button1 =NO;




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)useCamera1:(id)sender {
    [self useCamera:nil];
}

- (IBAction)useCameraRoll1:(id)sender {
    [self useCameraRoll:nil];
}

- (IBAction)AlertButton1:(id)sender {
    button1 = YES;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Photo from:"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Camera"];
    [message addButtonWithTitle:@"Photo Library"];
    [message show];

}

- (IBAction)AlertButton2:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Photo from:"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Camera"];
    [message addButtonWithTitle:@"Photo Library"];
    [message show];
}

// this is the response to the botton presses in the popups
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Camera"])
    {
        [self useCamera:nil];
    }
    else if([title isEqualToString:@"Photo Library"])
    {
        [self useCameraRoll:nil];
    }
}




//The useCamera method first checks that the device has a camera. It then creates a UIImagePickerController instance, assigns the cameraViewController as the delegate for the object and defines the media source as the camera. Since we do not plan on handling videos the supported media types property is set to images only. Finally, the camera interface will be displayed. Finally we set the newMedia flag to YES to indicate that the image is new and is not an existing image from the camera roll.
- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}

//The useCameraRoll method is almost the same as useCamera, but the source of the image is declared to be UIImagePickerControllerSourceTypePhotoLibrary. The newMedia flag is set to NO since the photo is already in the library (we don’t need to save it again)
- (void) useCameraRoll:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}


//BEGINNNNNNNNNNN  DELEGATE CODE
// The code in this delegate method dismisses the image picker view and identifies the type of media passed from the image picker controller. If it is an image it is displayed on the view image object of the user interface. If this is a new image it is saved to the camera roll. The finishedSavingWithError method is configured to be called when the save operation is complete. If an error occurred it is reported to the user via an alert box.
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // the following line selects to display the edited
        UIImage *image = info[UIImagePickerControllerEditedImage];
        if (button1){
            _imageView1.image = image;
        }
        else{
            _imageview2.image = image;
        }
        button1 = NO;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//If canceled without taking a picture, we need to dismiss the image picker
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}









@end

