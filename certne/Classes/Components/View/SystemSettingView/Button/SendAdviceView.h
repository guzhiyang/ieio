//
//  SendAdviceView.h
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendAdviceViewDelegate;

@interface SendAdviceView : UIView
{
    id<SendAdviceViewDelegate>  _delegate;
    BOOL open;
    UIButton   *_sendAdviceButton;
}

@property(nonatomic,assign)id<SendAdviceViewDelegate> delegate;
@property(nonatomic,assign)BOOL  open;
@property(nonatomic,retain)UIButton *sendAdviceButton;

@end

@protocol SendAdviceViewDelegate <NSObject>

-(void)sendAdviceButtonClicked:(SendAdviceView *)view;

@end
