//
//  DeviceView.h
//  certne
//
//  Created by apple on 13-5-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeviceViewDelegate;

@interface DeviceView : UIView<UITextFieldDelegate,UITextViewDelegate>
{
    UITextView              *_deviceTextView;
    __unsafe_unretained id<DeviceViewDelegate>  _delegate;
}

@property (nonatomic, strong) UITextView                *deviceTextView;
@property (assign, nonatomic) id<DeviceViewDelegate>    delegate;

@end

@protocol DeviceViewDelegate <NSObject>

-(void)sendSuggestionMessage;

@end