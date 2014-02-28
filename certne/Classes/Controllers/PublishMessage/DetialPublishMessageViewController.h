//
//  DetialPublishMessageViewController.h
//  certne
//
//  Created by apple on 13-9-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "PublicInfo.h"
#import "NavBarView.h"
#import "ImageDownLoader.h"

@interface DetialPublishMessageViewController : BaseViewController<NavBarViewDelegate,ImageDownLoaderDelegate,UIGestureRecognizerDelegate>
{
    PublicInfo          *_publicInfo;
    
    UIView              *_headView;
    UIButton            *_headImageButton;
    UILabel             *_userNameLabel;
    UILabel             *_userCopanyLabel;

    UIView              *_contentView;
    UILabel             *_messageLabel;
    UILabel             *_locationLabel;
    UILabel             *_dateLabel;
    
    CGFloat             _messageHeight;
    
    NavBarView          *_navBarView;
    ImageDownLoader     *_imageDownLoader;
    ImageDownLoader     *_headImageDownLoader;
    UIButton            *_productImageButton;
    NSData              *_imageData;
    
    UIButton            *_largeImageButton;
}

@property (retain, nonatomic) PublicInfo    *publicInfo;
@property (retain, nonatomic) UILabel       *messageLabel;
@property (assign, nonatomic) CGFloat       messageHeight;

@end

