//
//  UserWebsiteViewController.h
//  certne
//
//  Created by apple on 13-6-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NavBarView.h"

@interface UserWebsiteViewController : BaseViewController<UIWebViewDelegate,NavBarViewDelegate>
{
    UIWebView  *userWebsiteView;
    UIActivityIndicatorView *activityIndicatorView;
    
    UIToolbar        *_toolBar;
    UIBarButtonItem  *_goBackButton;
    UIBarButtonItem  *_goForwardButton;
    UIBarButtonItem  *_refleshButton;
    
    NavBarView       *_navBarView;
}

@property(copy,nonatomic)NSString   *websiteString;
@property(copy,nonatomic)NSString   *title;

@end
