//
//  OverlayViewController.h
//  certne
//
//  Created by apple on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseViewController.h"

@protocol OverlayViewControllerDelegate;

@interface OverlayViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    id<OverlayViewControllerDelegate>   _delegate;
    
    UIImagePickerController             *_imagePickerViewController;
    
@private
    UIBarButtonItem                     *_startPic;
    UIBarButtonItem                     *_stopPic;
}

@property (assign, nonatomic) id<OverlayViewControllerDelegate>     delegate;
@property (retain, nonatomic) UIImagePickerController               *imagePickerViewController;
@property (retain, nonatomic) UIBarButtonItem                       *startPic;
@property (retain, nonatomic) UIBarButtonItem                       *stopPic;

-(void)dostartPic:(id)sender;

-(void)dostartAv:(id)sender;

-(void)dostopAv:(id)sender;

@end

@protocol OverlayViewControllerDelegate <NSObject>

-(void)didTakePicture:(UIImage *)picture;

-(void)didFinishedWithCramer;

@end
