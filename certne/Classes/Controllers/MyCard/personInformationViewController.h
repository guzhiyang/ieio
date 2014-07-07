//
//  personInformationViewController.h
//  certne
//
//  Created by apple on 13-5-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UpYun.h"
#import "User.h"
#import "UserInfoScrollVIew.h"
#import "HeadNavView.h"
#import "UIKeyboardViewController.h"
#import "SaveUserInfoRequest.h"
#import "SessionIDDatabase.h"

@protocol resetUserCardImageDelegate;

@interface personInformationViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UpYunDelegate,UITextFieldDelegate,UIKeyboardViewControllerDelegate,SaveUserInfoRequestDelegate,UserInfoScrollVIewDelegate>
{
    UIKeyboardViewController    *keyboardViewController;
    
    UserInfoScrollVIew          *_userInfoScrollView;
    HeadNavView                 *_headNavView;
    
    User                        *_userSelf;
    SaveUserInfoRequest         *_saveUserInfoRequest;
    NSString                    *_imageSaveKey;
    NSString                    *_imageURL;
    
    __unsafe_unretained id<resetUserCardImageDelegate>      _delegate;
    SessionIDDatabase           *_sessionIDDataBase;
    BOOL                        _getHeadImageSuccess;
}

@property (strong, nonatomic) UITextField        *currentTextField;
@property (strong, nonatomic) UserInfoScrollVIew *userInfoScrollView;
@property (strong, nonatomic) HeadNavView        *headNavView;
@property (strong, nonatomic) User               *userSelf;
@property (copy, nonatomic) NSString             *imageSaveKey;
@property (copy, nonatomic) NSString             *imageURL;
@property (assign, nonatomic) id<resetUserCardImageDelegate>    delegate;
@property (strong, nonatomic) SessionIDDatabase  *sessionIDDataBase;

/**
 *	@brief	导航条回退上一层
 *
 *	@param 	sender 	暂时没有设置参数类型
 */
-(void)backToHome:(id)sender;

/**
 *	@brief	上传图片到又拍云
 */
-(void)upLoadImageToUpYun;

@end

@protocol resetUserCardImageDelegate <NSObject>

-(void)resetUserCardImageWithKey:(NSString *)imageSaveKey;

@end
