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
    UIButton        *_phoneCallButton;
    UITextField     *_mobileTextField;
    UIButton        *_telphoneCallButton;
    UITextField     *_telphoneTextField;
    UIButton        *_emailButton;
    UITextField     *_emailTextField;
    UIButton        *_faxButton;
    UITextField     *_faxTextField;
    UIButton        *_qqButton;
    UITextField     *_qqTextField;
    
    /**
     *	@brief	公司信息
     */
    UIButton        *_departmentButton;
    UITextField     *_departmentTextField;
    UIButton        *_industryButton;
    UITextField     *_industryTextField;
    UIButton        *_websiteButton;
    UITextField     *_websiteTextField;
    UIButton        *_addressButton;
    UITextField     *_addressTextField;
    UIButton        *_zipcodeButton;
    UITextField     *_zipcodeTextField;
    
    id<UserInfoScrollVIewDelegate>  _myDelegate;
}

@property (retain, nonatomic) UIButton      *headImageButton;
@property (retain, nonatomic) UITextField   *nameTextField;
@property (retain, nonatomic) UITextField   *positionTextField;
@property (retain, nonatomic) UITextField   *companyTextField;
@property (retain, nonatomic) UITextField   *mobileTextField;
@property (retain, nonatomic) UITextField   *telphoneTextField;
@property (retain, nonatomic) UITextField   *emailTextField;
@property (retain, nonatomic) UITextField   *faxTextField;
@property (retain, nonatomic) UITextField   *qqTextField;
@property (retain, nonatomic) UITextField   *departmentTextField;
@property (retain, nonatomic) UITextField   *industryTextField;
@property (retain, nonatomic) UITextField   *websiteTextField;
@property (retain, nonatomic) UITextField   *addressTextField;
@property (retain, nonatomic) UITextField   *zipcodeTextField;
@property (assign, nonatomic) id<UserInfoScrollVIewDelegate>    myDelegate;

/**
 *	@brief	头像按钮点击事件 可以考虑加载到使用UserInfoScrollVIew的视图控制器中
 *
 *	@param 	sender 	未知参数类型 返回头像的字符串地址
 */
-(void)headImageButtonClicked:(id)sender;

/**
 *	@brief	打电话
 *
 *	@param 	sender 	未知类型参数
 */
-(void)phoneCallButtonClicked:(id)sender;

/**
 *	@brief	固定电话
 *
 *	@param 	sender 	未知参数类型
 */
-(void)telephoneCallButtonClicked:(id)sender;

/**
 *	@brief	发邮件
 */
-(void)sendEmailButtonClicked:(id)sender;


@end

@protocol UserInfoScrollVIewDelegate <NSObject>

-(void)headImageButtonClicked;

@end
