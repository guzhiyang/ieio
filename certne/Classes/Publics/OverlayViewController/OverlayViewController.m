//
//  OverlayViewController.m
//  certne
//
//  Created by apple on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "OverlayViewController.h"

@implementation OverlayViewController
@synthesize delegate                  = _delegate;
@synthesize imagePickerViewController = _imagePickerViewController;
@synthesize startPic                  = _startPic;
@synthesize stopPic                   = _stopPic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imagePickerViewController = [[UIImagePickerController alloc] init];
        self.imagePickerViewController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Custom event methods

-(void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePickerViewController.sourceType = sourceType;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        self.imagePickerViewController.showsCameraControls = NO;
        
        if ([[self.imagePickerViewController.cameraOverlayView subviews] count] == 0) {
            CGRect overlayViewFrame = self.imagePickerViewController.cameraOverlayView.frame;
            CGRect newFrame = CGRectMake(0.0f, CGRectGetHeight(overlayViewFrame)-self.view.frame.size.height-10.0, CGRectGetWidth(overlayViewFrame), self.view.frame.size.height+10.0f);
            self.view.frame = newFrame;
            [self.imagePickerViewController.cameraOverlayView addSubview:self.view];
        }
    }
}

-(void)dostartPic:(id)sender
{
    [self.imagePickerViewController takePicture];
}

-(void)dostartAv:(id)sender
{
    [self.imagePickerViewController startVideoCapture];
}

-(void)dostopAv:(id)sender
{
    [self.imagePickerViewController stopVideoCapture];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (image != nil) {
        return;//--图片处理
    }
    
    NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
    if (url != nil) {
        return;//--视频处理
    }
    
    return;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //--取消处理
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
}

@end
