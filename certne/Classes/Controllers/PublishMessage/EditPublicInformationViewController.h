//
//  EditPublicInformationViewController.h
//  certne
//
//  Created by apple on 13-9-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UpYun.h"
#import "PublishMessageRequest.h"
#import "OverlayViewController.h"
#import "NavBarView.h"

@protocol EditPublicInfoRefreshDelegate;

@interface EditPublicInformationViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UpYunDelegate,PublishMessageRequestDelegate,OverlayViewControllerDelegate,NavBarViewDelegate>
{
    UIButton        *_backButton;
    
    UIButton        *_addImageButton;
    UITextView      *_informationTextView;
    UIButton        *_supplyButton;
    UIButton        *_demandButton;
    UILabel         *_supplyLabel;
    UILabel         *_demandLabel;
    
    PublishMessageRequest   *_publishMessageRequest;
    NavBarView              *_navBarView;
    NSString                *_imageSaveKey;
    __unsafe_unretained id<EditPublicInfoRefreshDelegate>   _delegate;
}

@property (strong, nonatomic) UIButton      *addImageButton;
@property (strong, nonatomic) UITextView    *informationTextView;
@property (copy, nonatomic) NSString        *imageSaveKey;
@property (assign, nonatomic) id<EditPublicInfoRefreshDelegate>     delegate;

-(void)publicSupplyInformationClicked:(id)sender;
-(void)publicDemandInformationClicked:(id)sender;

@end

@protocol EditPublicInfoRefreshDelegate <NSObject>

//-(NSArray *)addPublicInfoTo

-(void)refreshPublicInfoWhileFallback;

@end
