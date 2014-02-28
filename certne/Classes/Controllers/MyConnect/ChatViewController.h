//
//  ChatViewController.h
//  certne
//
//  Created by apple on 13-6-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncUdpSocket.h"
#import "IPAddress.h"
#import "ChatFaceView.h"

@class BaseTabBarController;
@interface ChatViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChatFaceViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIView      *_headNavView;
    UIButton    *_fallbackButton;
    UILabel     *_nameLabel;
    UIButton    *_unFriendButton;
    UIButton    *_addImageButton;
    
    UIView          *_downView;
    UIButton        *_faceButton;
    UITableView     *_chatTableView;
    UITextField     *_chatTextField;
    UIButton        *_sendButton;
    
    ChatFaceView    *_chatFaceView;
    
    NSMutableString    *_messageString;
    NSString           *_phraseString;
    NSString           *_titleString;
    NSMutableArray     *_chatArray;
    NSMutableString    *_chatTimeString;
    
    BOOL                    _isFromNewSMS;
    AsyncUdpSocket          *_udpSocket;
    UIImage                 *_headImage;
    NSString                *_name;
}

@property(nonatomic,retain)BaseTabBarController        *basetempController;
@property(retain,nonatomic)UIView                      *headNavView;
@property(retain,nonatomic)UIButton                    *fallbackButton;
@property(retain,nonatomic)UIButton                    *unFriendButton;
@property(retain,nonatomic)UIButton                    *addImageButton;
@property(retain,nonatomic)UILabel                     *nameLabel;
@property(retain,nonatomic)NSString                    *phraseString;
@property(retain,nonatomic)NSMutableString             *messageString;
@property(retain,nonatomic)NSMutableString             *chatTimeString;

@property(retain,nonatomic)UIButton      *faceButton;
@property(retain,nonatomic)UIView        *downView;
@property(retain,nonatomic)UITextField   *chatTextField;
@property(retain,nonatomic)UITableView   *chatTableView;
@property(retain,nonatomic)UIButton      *sendButton;

@property(copy,nonatomic)NSString      *name;
@property(retain,nonatomic)UIImage     *headImage;

@property(retain,nonatomic)ChatFaceView  *chatFaceView;

@property(retain,nonatomic)NSMutableArray           *chatArray;
@property(retain,nonatomic)NSString                 *titleString;

@property(retain,nonatomic)AsyncUdpSocket *udpSocket;

-(void)fallBack:(id)sender;
-(void)unFriend:(id)sender;
-(void)sendMessage_Click:(id)sender;
-(void)showPhraseInfo:(id)sender;
-(void)addImage:(id)sender;

-(void)openUDPServer;
-(void)sendMassage:(NSString *)message;
-(void)deleteContentFromTableView;

- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf;

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
-(UIView *)assembleMessageAtIndex : (NSString *) message from: (BOOL)fromself;

//- (void)scrollToBottomAnimated:(BOOL)animated;//滚动到底部 未实现

@end
