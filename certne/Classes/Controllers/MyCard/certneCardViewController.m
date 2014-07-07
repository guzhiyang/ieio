//
//  certneCardViewController.m
//  certne
//
//  Created by apple on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "certneCardViewController.h"
#import "ConnectionsViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeCardViewController.h"
#import "Global.h"
#import "Foundation.h"
#import "UserDefault.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@implementation certneCardViewController
@synthesize personInformation = _personInformation;
@synthesize userImageView     = _userImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
        
    _waitPleaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 280, 30)];
    _waitPleaseLabel.hidden = YES;
    _waitPleaseLabel.text = @"正在搜索好友,请稍后...";
    _waitPleaseLabel.textColor = [UIColor whiteColor];
    _waitPleaseLabel.backgroundColor = [UIColor clearColor];
    _waitPleaseLabel.textAlignment = NSTextAlignmentCenter;
    _waitPleaseLabel.font = [UIFont fontWithName:FONTNAME size:18];
    [self.view addSubview:_waitPleaseLabel];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.hidden = YES;
    _closeButton.frame  = CGRectMake(120, kUIsIphone5?440:352, 80, 93);
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"cancle_send.png"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    
    UISwipeGestureRecognizer  *imageSwipeUpGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageSwipeUpGesture:)];
    [imageSwipeUpGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    
    EMAsyncImageView *userImageView = [[EMAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
    userImageView.imageUrl = [UserDefault createUserDefault].avatar;
    userImageView.delegate = self;
    userImageView.userInteractionEnabled = YES;
    [userImageView addGestureRecognizer:imageSwipeUpGesture];
    
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
    [_userImageView addGestureRecognizer:imageSwipeUpGesture];
    _userImageView.userInteractionEnabled = YES;
    [self.view addSubview:_userImageView];
    [self showHeadImage];
    
    _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _setBtn.frame = CGRectMake(270, kUIsIphone5?508:420, 30, 30);
    [_setBtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setBtn];
    
    self.view.backgroundColor = UIColorFromFloat(102, 103, 103);
}

#pragma mark-Custom event methods

-(void)setting:(id)sender
{
    _personInformation=[[personInformationViewController alloc]init];
    _personInformation.title = @"个人信息";
    _personInformation.delegate = self;
    _personInformation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:_personInformation animated:YES];
}

-(void)showHeadImage
{
    __block certneCardViewController *blockSelf = self;
    [_userImageView setImageWithURL:[NSURL URLWithString:TESTUSERAVATAR] placeholderImage:[UIImage imageNamed:@"defaulta"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        blockSelf.userImageView.image = image;
        NSLog(@"下载图片出错:%@",error);
    }];
}

-(void)getUserCardImageFromDocumentWithImageSaveKey:(NSString *)imageSaveKey
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *userImagePath = [documentFile stringByAppendingPathComponent:imageSaveKey];
    UIImage *userImage = [UIImage imageWithContentsOfFile:userImagePath];
    _userImageView.image = userImage;
}

-(void)imageSwipeUpGesture:(UISwipeGestureRecognizer *)recognizer
{
    NSString *session_id = [Global shareGlobal].session_id;

    //设置动画 给动画设置一个时间
    //跟踪图片y轴的移动距离，小于40即不执行发送名片，高于40执行发送动画
    //这里发送数据，判断对象，超时弹出警告
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        //名片向上滑动动画
        _userImageView.frame=CGRectMake(0, 0, 320, self.view.frame.size.height);
        [UIImageView beginAnimations:@"animationID" context:nil];
        [UIImageView setAnimationDuration:2.0f];
        [UIImageView setAnimationRepeatAutoreverses:NO];
        [UIImageView setAnimationTransition:UIViewAnimationTransitionNone forView:_userImageView cache:YES];
        _userImageView.frame=CGRectMake(0, -self.view.frame.size.height, 320, self.view.frame.size.height);
        [UIImageView commitAnimations];
        
        //--发送交换请求
        if (_cardDoExchangeRequest == nil) {
            _cardDoExchangeRequest = [[CardDoExchangeRequest alloc] init];
            _cardDoExchangeRequest.delegate = self;
        }
        
        [_cardDoExchangeRequest sendCardDoExchangeRequestWithSessionid:session_id longitude:[Global shareGlobal].longitude latitude:[Global shareGlobal].latitude];
        
        _closeButton.hidden = NO;
        _setBtn.hidden      = YES;
                
        [NSTimer scheduledTimerWithTimeInterval:15
                                         target:self
                                       selector:@selector(closeButtonClicked:)
                                       userInfo:nil
                                        repeats:NO];
    }else{
        NSLog(@"未执行...");
    }
    
    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(showWaitPleaseLabel)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)closeButtonClicked:(id)sender
{
    _closeButton.hidden = YES;
    _setBtn.hidden      = NO;
    
    CABasicAnimation *moveDownImageAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    moveDownImageAnimation.duration     = 2.0f;
    moveDownImageAnimation.repeatCount  = 1;
    moveDownImageAnimation.autoreverses = NO;
    moveDownImageAnimation.fromValue    = [NSNumber numberWithInt:_userImageView.frame.origin.y];
    moveDownImageAnimation.toValue      = [NSNumber numberWithInt:0.0f];
    moveDownImageAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [_userImageView.layer addAnimation:moveDownImageAnimation forKey:nil];
    _userImageView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    
    _waitPleaseLabel.hidden = YES;
}

-(void)showWaitPleaseLabel
{
    _waitPleaseLabel.hidden = NO;
}

#pragma mark- CardDoExchange request delegate

-(void)CardDoExchangeRequestDidFinished:(CardDoExchangeRequest *)cardDoExchangeRequest changeCardResponse:(StatusResponse *)changeCardResponse
{
    if (changeCardResponse.status == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:changeCardResponse.msg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else if(changeCardResponse.status == 1){
        if (_getChangeCardListRequest == nil) {
            _getChangeCardListRequest = [[GetChangeCardListRequest alloc] init];
            _getChangeCardListRequest.delegate = self;
        }
        
        [_getChangeCardListRequest sendGetChangeCardListRequestWithSessionid:[Global shareGlobal].session_id];
    }
}

-(void)CardDoExchangeRequestDidFailed:(CardDoExchangeRequest *)cardDoExchangeRequest error:(NSError *)error
{
}

#pragma mark- GetChangeCardListRequest delegate methods

-(void)GetChangeCardListRequestDidFinished:(GetChangeCardListRequest *)getChangeCardListRequest changeCardListResponse:(ChangeCardListResponse *)cardListResponse
{
    if (cardListResponse.status == 0) {
        [NSTimer scheduledTimerWithTimeInterval:10
                                         target:self
                                       selector:@selector(showAlertViewWithMessage)
                                       userInfo:nil
                                        repeats:NO];
    }else if (cardListResponse.status == 1){
        ChangeCardViewController *changeViewController = [[ChangeCardViewController alloc] init];
        changeViewController.userListArray = cardListResponse.dataArray;
        [self.navigationController pushViewController:changeViewController animated:NO];
//        [self presentModalViewController:changeViewController animated:NO];
    }
}

-(void)GetChangeCardListRequestDidFaild:(GetChangeCardListRequest *)getChangeCardListRequest error:(NSError *)error
{
}

-(void)showAlertViewWithMessage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有搜索到交换名片的好友!"
                                                        message:@"请重试！"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - resetUserCardImage delegate methods

-(void)resetUserCardImageWithKey:(NSString *)imageSaveKey
{
    [self getUserCardImageFromDocumentWithImageSaveKey:imageSaveKey];
}

#pragma mark - EMAsyncImageView delegate methods

-(void)EMAsyncImageViewFinishedLoadingWith:(UIImage *)image ImageURL:(NSString *)imageURL EMAsyncImageView:(id)imageView
{
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    _personInformation = nil;
    _userImageView     = nil;
}
@end
