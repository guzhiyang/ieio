//
//  ChangeCardViewController.h
//  certne
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "DoExchangeRequest.h"
#import "NavBarView.h"
//#import "ImageDownLoadQueue.h"

@interface ChangeCardViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,DoExchangeRequestDelegate,NavBarViewDelegate>
{
    UITableView         *_changeCardTableView;
    NSInteger           _currentIndex;
    
    NSArray             *_userListArray;
    NSMutableArray      *_userArray;
    DoExchangeRequest   *_doExchangeRequest;
    NSString            *_selectedUserID;
    NavBarView          *_navBarView;
    
    NSMutableArray      *_headImageURLArray;
    
    NSMutableDictionary *_headImageDic;
//    ImageDownLoadQueue  *_imageDownLoadQueue;
}

@property (nonatomic, strong) UITableView        *changeCardTableView;
@property (nonatomic, assign) NSInteger          currentIndex;
@property (nonatomic, strong) NSArray            *userListArray;
@property (nonatomic, strong) NSMutableArray     *userArray;
@property (nonatomic, copy) NSString             *selectedUserID;
@property (nonatomic, strong) NSMutableArray     *headImageURLArray;

/**
 *	@brief	获取选择的用户编号
 *
 *	@return	返回以逗号分割的字符串
 */
//-(NSString *)getChangeCardUserID;

@end
