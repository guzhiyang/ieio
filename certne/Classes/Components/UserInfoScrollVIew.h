//
//  UserInfoScrollVIew.h
//  certne
//
//  Created by apple on 13-12-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoScrollVIewDelegate;

@interface UserInfoScrollVIew : UIScrollView
{
    UIButton        *_headImageButton;
    UITextField     *_nameTextField;
    UITextField     *_positionTextField;
    UITextField     *_companyTextField;
    
    /**
     *	@brief	联系信息控件
     */
    UIImageView     *_phoneCallImageView;
    UITextField     *_mobileTextField;
    UIImageView     *_telphoneCallImageView;
    UITextField     *_telphoneTextField;
    UIImageView     *_emailImageView;
    UITextField     *_emailTextField;
    UIImageView     *_faxImageView;
    UITextField     *_faxTextField;
    UIImageView     *_qqImageView;
    UITextField     *_qqTextField;
    
    /**
     *	@brief	公司信息
     */
    UIImageView     *_departmentImageView;
    UITextField     *_departmentTextField;
    UIImageView     *_industryImageView;
    UITextField     *_industryTextField;
    UIImageView     *_websiteImageView;
    UITextField     *_websiteTextField;
    UIImageView     *_addressImageView;
    UITextField     *_addressTextField;
    UIImageView     *_zipcodeImageView;
    UITextField     *_zipcodeTextField;
    
    __unsafe_unretained id<UserInfoScrollVIewDelegate>  _myDelegate;
}

@property (strong, nonatomic) UIButton      *headImageButton;
@property (strong, nonatomic) UITextField   *nameTextField;
@property (strong, nonatomic) UITextField   *positionTextField;
@property (strong, nonatomic) UITextField   *companyTextField;
@property (strong, nonatomic) UITextField   *mobileTextField;
@property (strong, nonatomic) UITextField   *telphoneTextField;
@property (strong, nonatomic) UITextField   *emailTextField;
@property (strong, nonatomic) UITextField   *faxTextField;
@property (strong, nonatomic) UITextField   *qqTextField;
@property (strong, nonatomic) UITextField   *departmentTextField;
@property (strong, nonatomic) UITextField   *industryTextField;
@property (strong, nonatomic) UITextField   *websiteTextField;
@property (strong, nonatomic) UITextField   *addressTextField;
@property (strong, nonatomic) UITextField   *zipcodeTextField;
@property (assign, nonatomic) id<UserInfoScrollVIewDelegate>    myDelegate;

/**
 *	@brief	头像按钮点击事件 可以考虑加载到使用UserInfoScrollVIew的视图控制器中
 *
 *	@param 	sender 	未知参数类型 返回头像的字符串地址
 */
-(void)headImageButtonClicked:(id)sender;

@end

@protocol UserInfoScrollVIewDelegate <NSObject>

-(void)headImageButtonClicked;

@end
