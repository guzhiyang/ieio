//
//  ChatFaceView.h
//  certne
//
//  Created by apple on 13-6-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatViewController;
@protocol ChatFaceViewDelegate;
@interface ChatFaceView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_faceScrollView;
    UIPageControl *_facePageControl;
    UIButton *_addImageButton;
    
    NSString *_faceString;
    
    ChatViewController *_chatViewController;
    NSMutableArray *_phraseArray;
    
    id<ChatFaceViewDelegate>  _delegate;
}

@property(retain,nonatomic)UIScrollView *faceScrollView;
@property(retain,nonatomic)UIButton *addImageButton;
@property(retain,nonatomic)UIPageControl *facePageControl;
@property(retain,nonatomic)NSString *faceString;

@property(retain,nonatomic)ChatViewController *chatViewController;
@property(retain,nonatomic)NSMutableArray *phraseArray;
@property(assign,nonatomic)id<ChatFaceViewDelegate>   delegate;

-(void)changePage:(id)sender;
-(void)showEmojiView;

@end


@protocol ChatFaceViewDelegate <NSObject>

-(void)sendTextToChatViewController:(id)sender;

@end