//
//  NearbyFriendNextViewController.h
//  certne
//
//  Created by apple on 13-6-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Animation.h"
#import "NearbyUser.h"
#import "MarginTextField.h"
#import "SayHelloResponseRequest.h"
//#import "ImageDownLoader.h"

@interface NearbyFriendNextViewController : BaseViewController<UITextFieldDelegate,SayHelloResponseRequestDelegate>
{
    UIImageView         *_headImageView;
    UILabel             *_nameLabel;
    UILabel             *_positionLabel;
    UILabel             *_companyNameLabel;
    UILabel             *_addressLabel;
    UIButton            *chatButton;
    MarginTextField     *_chatTextfield;
    NearbyUser          *_user;
    NSString            *_headImageURL;
    BOOL                _isLoading;
    
    SayHelloResponseRequest     *_sayHelloResponseRequest;
//    ImageDownLoader             *_headImageDownLoader;
    UIActivityIndicatorView     *_activityView;
}

@property (strong, nonatomic) UIImageView     *headImageView;
@property (strong, nonatomic) UILabel         *nameLabel;
@property (strong, nonatomic) UILabel         *positionLabel;
@property (strong, nonatomic) UILabel         *companyNameLabel;
@property (strong, nonatomic) UILabel         *addressLabel;
@property (strong, nonatomic) NearbyUser      *user;
@property (strong, nonatomic) MarginTextField *chatTextfield;
@property (strong, nonatomic) UIActivityIndicatorView   *activityView;
@property (copy, nonatomic) NSString          *headImageURL;

@end
