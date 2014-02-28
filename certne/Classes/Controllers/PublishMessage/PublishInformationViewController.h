//
//  PublishInformationViewController.h
//  certne
//
//  Created by apple on 13-9-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "PublicInfo.h"
#import "PublicMessageCell.h"
#import "NavBarView.h"
#import "ImageDownLoadQueue.h"
#import "GetFriendDetailInfoRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "GetSupplyListRequest.h"
#import "GetNeedListRequest.h"
#import "EditPublicInformationViewController.h"

@interface PublishInformationViewController : BaseViewController<HeadImageButtonClickedDelegate,UITableViewDelegate,UITableViewDataSource,NavBarViewDelegate,ImageDownLoadQueueDelegate,GetFriendDetailInfoRequestDelegate,EGORefreshTableHeaderDelegate,GetSupplyListRequestDelegate,GetNeedListRequestDelegate,EditPublicInfoRefreshDelegate>
{
    UITableView     *_supplyInformationTableView;
    UITableView     *_demandInformationTableView;
    UIView          *_segmentSupplyView;
    UIView          *_segmentDemandView;
    
    UIButton        *_supplyButton;
    UILabel         *_supplyLabel;
    UIButton        *_demandButton;
    UILabel         *_demandLabel;
        
    NSArray         *_supplyParserArray;
    NSArray         *_needParserArray;
    NSMutableArray  *_supplyInfoArray;
    NSMutableArray  *_needdInfoArray;
    
    NSMutableArray  *_messageArray;
    NavBarView      *_navBarView;
    
    NSMutableArray              *_productImageURLArray;
    NSMutableArray              *_headImageURLArray;
    NSMutableDictionary         *_imageDictionary;
    ImageDownLoadQueue          *_imageDoenLoadQueue;
    
    NSMutableArray              *_needImageURLArray;
    NSMutableArray              *_needHeadImageURLArray;
    NSMutableDictionary         *_allNeedImageDic;
    ImageDownLoadQueue          *_needImageDownLoadQueue;
    
    GetFriendDetailInfoRequest  *_getFriendDetailInfoRequest;
    EGORefreshTableHeaderView   *_refreshSupplyDataView;
    EGORefreshTableHeaderView   *_refreshNeedDataView;
    BOOL                        _isSupplyDataLoading;
    BOOL                        _isNeedDataLoading;
    GetSupplyListRequest        *_getSupplyListRequest;
    GetNeedListRequest          *_getNeedListRequest;
}

@property (retain, nonatomic) UITableView       *supplyInformationTableView;
@property (retain, nonatomic) UITableView       *demandInformationTableView;
@property (retain, nonatomic) NSArray           *supplyParserArray;
@property (retain, nonatomic) NSArray           *needParserArray;

/**
 *	@brief	供求按钮点击事件
 *
 *	@param 	sender 	参数未知，上线前没有用到可以删除
 */
-(void)supplyButtonClicked:(id)sender;
-(void)demandButtonClicked:(id)sender;

/**
 *	@brief	获取服务端数据
 */
-(NSMutableArray *)getMessageInfoDataWithParserArray:(NSArray *)parserArray;

@end
