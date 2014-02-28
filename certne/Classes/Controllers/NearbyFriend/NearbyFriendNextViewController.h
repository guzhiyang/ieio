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
#import "ImageDownLoader.h"

@interface NearbyFriendNextViewController : BaseViewController<UITextFieldDelegate,SayHelloResponseRequestDelegate,ImageDownLoaderDelegate>
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
    ImageDownLoader             *_headImageDownLoader;
    UIActivityIndicatorView     *_activityView;
}

@property (retain, nonatomic) UIImageView     *headImageView;
@property (retain, nonatomic) UILabel         *nameLabel;
@property (retain, nonatomic) UILabel         *positionLabel;
@property (retain, nonatomic) UILabel         *companyNameLabel;
@property (retain, nonatomic) UILabel         *addressLabel;
@property (retain, nonatomic) NearbyUser      *user;
@property (retain, nonatomic) MarginTextField *chatTextfield;
@property (retain, nonatomic) UIActivityIndicatorView   *activityView;
@property (copy, nonatomic) NSString          *headImageURL;

@end
