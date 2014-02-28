//
//  certneCardViewController.h
//  certne
//
//  Created by apple on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "personInformationViewController.h"
#import "CardDoExchangeRequest.h"
#import "GetChangeCardListRequest.h"

@interface certneCardViewController : BaseViewController<CardDoExchangeRequestDelegate,GetChangeCardListRequestDelegate,resetUserCardImageDelegate>
{
    UIButton                        *_setBtn;
    personInformationViewController *_personInformation;
    UIImageView                     *_userImageView;
    UIButton                        *_closeButton;
    UILabel                         *_waitPleaseLabel;
    
    CardDoExchangeRequest           *_cardDoExchangeRequest;
    GetChangeCardListRequest        *_getChangeCardListRequest;
    NSTimer                         *_timer;
}

/**
 *	@brief	设置用户信息
 *	@param 	sender 	参数类型未知，暂时没有用到参数
 */
-(void)setting:(id)sender;

-(void)getUserCardImageFromDocumentWithImageSaveKey:(NSString *)imageSaveKey;

@property (retain, nonatomic) personInformationViewController   *personInformation;
@property (retain, nonatomic) UIImageView                       *userImageView;

@end
