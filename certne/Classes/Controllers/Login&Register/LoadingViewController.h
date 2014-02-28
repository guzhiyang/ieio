//
//  LoadingViewController.h
//  certne
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "UserOnLineRequest.h"
#import "User.h"
#import "SessionIDDatabase.h"
#import "ImageDownLoader.h"

@interface LoadingViewController : BaseViewController<CLLocationManagerDelegate,MKReverseGeocoderDelegate,UserOnLineRequestDelegate,ImageDownLoaderDelegate>
{
    UIImageView         *_defaultImageView;
    CGFloat             _longitude;
    CGFloat             _latitude;
    
    CLLocationManager   *_locationManager;
    CLLocation          *_currentLocation;
    
    UserOnLineRequest   *_userOnLineRequest;
    ImageDownLoader     *_imageDownLoader;
}

@property (nonatomic, retain) UIImageView       *defaultImageView;
@property (assign, nonatomic) CGFloat           longitude;
@property (assign, nonatomic) CGFloat           latitude;
@property (retain, nonatomic) CLLocationManager *locationManager;

/**
 *	@brief	将获取的session值转换为user，提交给个人信息界面使用
 *
 *	@param 	sessionID 	session比user多了一个登录标志属性
 *
 *	@return	返回user信息
 */
-(User *)getUserFromSessionID:(SessionID *)sessionID;

@end
