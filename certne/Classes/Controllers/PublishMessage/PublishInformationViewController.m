//
//  PublishInformationViewController.m
//  certne
//
//  Created by apple on 13-9-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PublishInformationViewController.h"
#import "DetialPublishMessageViewController.h"
#import "UserDetailMessageViewController.h"
#import "Foundation.h"
#import "Global.h"

@implementation PublishInformationViewController
@synthesize demandInformationTableView = _demandInformationTableView;
@synthesize supplyInformationTableView = _supplyInformationTableView;
@synthesize supplyParserArray          = _supplyParserArray;
@synthesize needParserArray            = _needParserArray;

#pragma mark - get Parser Data

-(NSMutableArray *)getMessageInfoDataWithParserArray:(NSArray *)parserArray
{
    _messageArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *infoDic in parserArray) {
        PublicInfo *publicInfo = [[PublicInfo alloc] init];
        
        id infoIDObject = [infoDic objectForKey:@"uid"];
        if ([[infoIDObject class] isSubclassOfClass:[NSNumber class]]) {
            publicInfo.infoID = [infoIDObject integerValue];
        }
        
        id avatarObject = [infoDic objectForKey:@"avatar"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.avatar = (NSString *)avatarObject;
        }
        
        id nameObject = [infoDic objectForKey:@"name"];
        if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.name = (NSString *)nameObject;
        }
        
        id companyObject = [infoDic objectForKey:@"company"];
        if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.company = (NSString *)companyObject;
        }
        
        id mobileObject = [infoDic objectForKey:@"mobile"];
        if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.mobile = (NSString *)mobileObject;
        }
        
        id imgObject = [infoDic objectForKey:@"imgs"];
        if ([[imgObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.img = (NSString *)imgObject;
        }
        
        id descOnject = [infoDic objectForKey:@"desc"];
        if ([[descOnject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.desc = (NSString *)descOnject;
        }
        
        id infoTypeObject = [infoDic objectForKey:@"type"];
        if ([[infoTypeObject class] isSubclassOfClass:[NSNumber class]]) {
            publicInfo.infoType = [infoTypeObject integerValue];
        }
        
        id publishAddressObject = [infoDic objectForKey:@"address"];
        if ([[publishAddressObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.publishAddress = (NSString *)publishAddressObject;
        }
        
        id publishTimeObject = [infoDic objectForKey:@"add_time"];
        if ([[publishTimeObject class] isSubclassOfClass:[NSString class]]) {
            publicInfo.addTime = (NSString *)publishTimeObject;
        }
        
        [_messageArray addObject:publicInfo];
        [publicInfo release];
    }
    return _messageArray;
}

-(void)createImageURLArray
{
    _productImageURLArray = [[NSMutableArray alloc] init];
    _headImageURLArray    = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [_supplyInfoArray count]; i++) {
        PublicInfo *publicInfo = [_supplyInfoArray objectAtIndex:i];
        if (publicInfo.avatar != nil) {
            NSString *headImageURL = publicInfo.avatar;
            [_headImageURLArray addObject:headImageURL];
        }
        if (publicInfo.img != nil) {
            NSString *productImageURL = publicInfo.img;
            [_productImageURLArray addObject:productImageURL];
        }
    }
    
    _imageDictionary = [[NSMutableDictionary alloc] init];
}

-(void)createNeedImageURLArray
{
    _needImageURLArray = [[NSMutableArray alloc] init];
    _needHeadImageURLArray = [[NSMutableArray alloc] init];
    _allNeedImageDic = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_needdInfoArray count]; i++) {
        PublicInfo *publicInfo = [_needdInfoArray objectAtIndex:i];
        if (publicInfo.avatar != nil) {
            NSString *headImageURL = publicInfo.avatar;
            [_needHeadImageURLArray addObject:headImageURL];
        }
        
        if (publicInfo.img != nil) {
            NSString *productImage = publicInfo.img;
            [_needImageURLArray addObject:productImage];
        }
    }
}

#pragma mark- View lifestyle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _supplyInfoArray = [self getMessageInfoDataWithParserArray:self.supplyParserArray];
    _needdInfoArray  = [self getMessageInfoDataWithParserArray:self.needParserArray];
    
    [self createImageURLArray];
    int imageNum = [_productImageURLArray count] + [_headImageURLArray count];
    _imageDoenLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:imageNum delegate:self];
    
    [self createNeedImageURLArray];
    int needImageNum = [_needImageURLArray count] + [_needHeadImageURLArray count];
    _needImageDownLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:needImageNum delegate:self];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"企业商机"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIButton *editInformationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    editInformationButton.frame = CGRectMake(270, 27, 30, 30);
    [editInformationButton setBackgroundImage:[UIImage imageNamed:@"edit_msg.png"] forState:UIControlStateNormal];
    [editInformationButton addTarget:self action:@selector(addMoreInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editInformationButton];
    
    _supplyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _supplyButton.frame=CGRectMake(10, 74, 150, 30);
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    [_supplyButton addTarget:self action:@selector(supplyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_supplyButton];
    
    _supplyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 150, 30)];
    _supplyLabel.text = @"供应商机";
    _supplyLabel.textAlignment = NSTextAlignmentCenter;
    _supplyLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [self.view addSubview:_supplyLabel];
    [_supplyLabel release];
    
    _demandButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _demandButton.frame=CGRectMake(160, 74, 150, 30);
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    [_demandButton addTarget:self action:@selector(demandButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_demandButton];
    
    _demandLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 74, 150, 30)];
    _demandLabel.textAlignment = NSTextAlignmentCenter;
    _demandLabel.textColor = [UIColor whiteColor];
    _demandLabel.text = @"需求商机";
    _demandLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [self.view addSubview:_demandLabel];
    [_demandLabel release];
    
    _supplyInformationTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, kUIsIphone5?444:356)];
    _supplyInformationTableView.delegate   = self;
    _supplyInformationTableView.dataSource = self;
    _supplyInformationTableView.showsVerticalScrollIndicator = NO;
    _supplyInformationTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _supplyInformationTableView.backgroundColor=[UIColor clearColor];
    
    if (_refreshSupplyDataView == nil) {
        _refreshSupplyDataView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _supplyInformationTableView.bounds.size.height, _supplyInformationTableView.bounds.size.width, _supplyInformationTableView.bounds.size.height)];
        _refreshSupplyDataView.delegate = self;
        [_supplyInformationTableView addSubview:_refreshSupplyDataView];
        [_refreshSupplyDataView release];
    }
    
    _segmentSupplyView=[[UIView alloc] initWithFrame:CGRectMake(10, 114, 300, kUIsIphone5?444:356)];
    _segmentSupplyView.backgroundColor=[UIColor clearColor];
    _segmentSupplyView.hidden = NO;
    [_segmentSupplyView addSubview:_supplyInformationTableView];
    [self.view addSubview:_segmentSupplyView];
    [_segmentSupplyView release];
    
    _demandInformationTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, kUIsIphone5?444:356)];
    _demandInformationTableView.delegate   = self;
    _demandInformationTableView.dataSource = self;
    _demandInformationTableView.showsVerticalScrollIndicator = NO;
    _demandInformationTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _demandInformationTableView.backgroundColor = [UIColor clearColor];
    
    if (_refreshNeedDataView == nil) {
        _refreshNeedDataView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _demandInformationTableView.bounds.size.height, _demandInformationTableView.bounds.size.width, _demandInformationTableView.bounds.size.height)];
        _refreshNeedDataView.delegate = self;
        [_demandInformationTableView addSubview:_refreshNeedDataView];
        [_refreshNeedDataView release];
    }
    
    _segmentDemandView=[[UIView alloc] initWithFrame:CGRectMake(10, 114, 300, kUIsIphone5?444:356)];
    _segmentDemandView.backgroundColor = [UIColor clearColor];
    _segmentDemandView.hidden = YES;
    [_segmentDemandView addSubview:_demandInformationTableView];
    [self.view addSubview:_segmentDemandView];
    [_segmentDemandView release];
    
    self.view.backgroundColor = UIColorFromFloat(216, 215, 210);
}

#pragma mark- Custom event methods

-(void)supplyButtonClicked:(id)sender
{
    _segmentSupplyView.hidden = NO;
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    _supplyLabel.textColor = [UIColor blackColor];
    _segmentDemandView.hidden = YES;
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    _demandLabel.textColor = [UIColor whiteColor];
}

-(void)demandButtonClicked:(id)sender
{
    _segmentSupplyView.hidden = YES;
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    _supplyLabel.textColor = [UIColor whiteColor];
    _segmentDemandView.hidden = NO;
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    _demandLabel.textColor = [UIColor blackColor];
}

-(void)addMoreInformation
{
    //--编辑界面
    EditPublicInformationViewController *editViewController = [[EditPublicInformationViewController alloc] init];
    editViewController.delegate = self;
    [self.navigationController pushViewController:editViewController animated:YES];
    [editViewController release];
}

-(UIImage *)editImageFromDownLoadImage:(UIImage *)downLoadImage
{
    CGFloat cutFloat = downLoadImage.size.height - downLoadImage.size.width;
    CGRect imageRect = CGRectMake(0, cutFloat/2, downLoadImage.size.width, downLoadImage.size.width);
    CGImageRef imageRef = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 80.0f;
    size.height = 80.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)editProductImageFromDownloadImage:(UIImage *)downLoadImage
{
    CGFloat imageHeight = downLoadImage.size.height;
    CGFloat imageWidth  = downLoadImage.size.width;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect imageRect    = CGRectMake(0, cutFloat/2, imageWidth, imageWidth/3);
    CGImageRef imageRef = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 300.0f;
    size.height = 100.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    //--展开左边导航
}

#pragma mark- TableView delegate & datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_supplyInformationTableView]) {
        return [_supplyInfoArray count];
    }else{
        return [_needdInfoArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_supplyInformationTableView]) {
        CGFloat height;
        PublicInfo *publicInfo = [_supplyInfoArray objectAtIndex:indexPath.row];
        height=[PublicMessageCell caculateCellHeightWithProductMessage:publicInfo.desc];
        return height;
    }else{
        CGFloat cellHeight;
        PublicInfo *publicInfo=[_needdInfoArray objectAtIndex:indexPath.row];
        cellHeight=[PublicMessageCell caculateCellHeightWithProductMessage:publicInfo.desc];
        return cellHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_supplyInformationTableView]) {
        static NSString     *supplyCellIdentifier = @"CellIdentifier";
        PublicMessageCell   *cell = [tableView dequeueReusableCellWithIdentifier:supplyCellIdentifier];
        
        if (!cell) {
            cell = [[[PublicMessageCell alloc] init] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate       = self;
        }
        
        if ([_supplyInfoArray count] > indexPath.row) {
            PublicInfo *publicInfo = [_supplyInfoArray objectAtIndex:indexPath.row];
            [cell setUserPublicInfo:publicInfo indexPath:indexPath];
            
            NSString *headImageURL = [_headImageURLArray objectAtIndex:indexPath.row];
            UIImage *image = [_imageDictionary objectForKey:headImageURL];
            if (image) {
                UIImage *headImage = [self editImageFromDownLoadImage:image];
                [cell setHeadImage:headImage];
            }else{
                [_imageDoenLoadQueue addImageURL:headImageURL];
            }
            
            NSString *prodctImageURL = [_productImageURLArray objectAtIndex:indexPath.row];
            UIImage *proImage = [_imageDictionary objectForKey:prodctImageURL];
            if (proImage) {
                UIImage *productImage = [self editProductImageFromDownloadImage:proImage];
                [cell setProductImage:productImage];
            }else{
                [_imageDoenLoadQueue addImageURL:prodctImageURL];
            }
        }
        
        return cell;
    }else{
        static NSString *demandCellIdentifier = @"CellIdentifier";
        PublicMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:demandCellIdentifier];
        
        if (!cell) {
            cell = [[[PublicMessageCell alloc] init] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        if ([_needdInfoArray count] > indexPath.row) {
            PublicInfo *publicInfo=[_needdInfoArray objectAtIndex:indexPath.row];
            [cell setUserPublicInfo:publicInfo indexPath:indexPath];
            
            NSString *headImageURL = [_needHeadImageURLArray objectAtIndex:indexPath.row];
            UIImage *image = [_allNeedImageDic objectForKey:headImageURL];
            if (image) {
                UIImage *headImage = [self editImageFromDownLoadImage:image];
                [cell setHeadImage:headImage];
            }else{
                [_needImageDownLoadQueue addImageURL:headImageURL];
            }
            
            NSString *prodctImageURL = [_needImageURLArray objectAtIndex:indexPath.row];
            UIImage *proImage = [_allNeedImageDic objectForKey:prodctImageURL];
            if (proImage) {
                UIImage *productImage = [self editProductImageFromDownloadImage:proImage];
                [cell setProductImage:productImage];
            }else{
                [_needImageDownLoadQueue addImageURL:prodctImageURL];
            }
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicInfo *publicInfo = [[[PublicInfo alloc] init] autorelease];
    if ([tableView isEqual:_supplyInformationTableView]) {
        publicInfo = [_supplyInfoArray objectAtIndex:indexPath.row];
    }else{
        publicInfo = [_needdInfoArray objectAtIndex:indexPath.row];
    }
    CGSize messageSize = [publicInfo.desc sizeWithFont:[UIFont fontWithName:FONTNAME size:14]
                                     constrainedToSize:CGSizeMake(270, 100000)
                                         lineBreakMode:NSLineBreakByCharWrapping];
    DetialPublishMessageViewController *detialPublishMessageViewController = [[DetialPublishMessageViewController alloc]init];
    detialPublishMessageViewController.publicInfo = publicInfo;
    detialPublishMessageViewController.messageHeight = messageSize.height;
    detialPublishMessageViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:detialPublishMessageViewController animated:YES];
}

#pragma mark- HeadImageButtonClicked delegate methods

-(void)headImageButtonClickedPushDetalMessage:(HeadImageButton *)headImagebutton
{
    if (_getFriendDetailInfoRequest == nil) {
        _getFriendDetailInfoRequest = [[GetFriendDetailInfoRequest alloc] init];
        _getFriendDetailInfoRequest.delegate = self;
    }

    if (_segmentDemandView.hidden == YES) {
        PublicInfo *publicInfo = [_supplyInfoArray objectAtIndex:headImagebutton.cellRow];
        [_getFriendDetailInfoRequest sendGetFriendDetailInfoRequestWithSessionid:[Global shareGlobal].session_id fuid:publicInfo.infoID];
    }else if (_segmentDemandView.hidden == NO){
        PublicInfo *publicInfo = [_needdInfoArray objectAtIndex:headImagebutton.cellRow];
        [_getFriendDetailInfoRequest sendGetFriendDetailInfoRequestWithSessionid:[Global shareGlobal].session_id fuid:publicInfo.infoID];
    }
}

#pragma mark - GetFriendDetailInfoRequest delegate methods

-(void)GetFriendDetailInfoRequestDidFinished:(GetFriendDetailInfoRequest *)getFriendDetailInfoRequest friendDetailInfo:(FriendInfoAndMessage *)friendDetailInfo
{
    if (friendDetailInfo.status == 1) {
        UserDetailMessageViewController *userDetailMessageViewController = [[UserDetailMessageViewController alloc] init];
        userDetailMessageViewController.friendDetailData = friendDetailInfo.data;
        userDetailMessageViewController.userInfoArray    = friendDetailInfo.infoArray;
        [self.navigationController pushViewController:userDetailMessageViewController animated:NO];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:friendDetailInfo.msg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)GetFriendDetailInfoRequestDidFailed:(GetFriendDetailInfoRequest *)getFriendDetailInfoRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - ImageDownLoadQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_imageDictionary setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_supplyInformationTableView visibleCells];
    [_supplyInformationTableView reloadData];

    [_allNeedImageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_demandInformationTableView visibleCells];
    [_demandInformationTableView reloadData];
}

-(void)downLoadImageFailed:(NSString *)imageURL error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - EgoRefreshTableViewData delegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshSupplyDataView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshNeedDataView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshSupplyDataView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshNeedDataView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    if ([view isEqual:_refreshSupplyDataView]) {
        [self reloadSupplyTableViewData];
        [self performSelector:@selector(doneLoadingSupplyTableViewData) withObject:nil afterDelay:3];
    }else if ([view isEqual:_refreshNeedDataView]){
        [self reloadNeedTableViewData];
        [self performSelector:@selector(doneLoadingNeedTableViewData) withObject:nil afterDelay:3];
    }
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    if ([view isEqual:_refreshSupplyDataView]) {
        return _isSupplyDataLoading;
    }else if ([view isEqual:_refreshNeedDataView]){
        return _isNeedDataLoading;
    }
    return YES;
}

-(void)reloadSupplyTableViewData
{
    if (_getSupplyListRequest == nil) {
        _getSupplyListRequest = [[GetSupplyListRequest alloc] init];
        _getSupplyListRequest.delegate = self;
    }
    [_getSupplyListRequest sendPublicBuinessMessageRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)doneLoadingSupplyTableViewData
{
    _isSupplyDataLoading = NO;
    [_refreshSupplyDataView egoRefreshScrollViewDataSourceDidFinishedLoading:_supplyInformationTableView];
}

-(void)reloadNeedTableViewData
{
    if (_getNeedListRequest == nil) {
        _getNeedListRequest = [[GetNeedListRequest alloc] init];
        _getNeedListRequest.delegate = self;
    }
    
    [_getNeedListRequest sendGetNeedListRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)doneLoadingNeedTableViewData
{
    _isNeedDataLoading = NO;
    [_refreshNeedDataView egoRefreshScrollViewDataSourceDidFinishedLoading:_demandInformationTableView];
}

#pragma mark - GetSupplyListData delegate methods

-(void)getSupplyListRequestDidFinished:(GetSupplyListRequest *)getSupplyListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse
{
    if (publicInfoResponse.status == 1) {
        _isSupplyDataLoading = YES;
        [_supplyInfoArray removeAllObjects];
        _supplyInfoArray = [self getMessageInfoDataWithParserArray:publicInfoResponse.dataArray];
        [self createImageURLArray];
        int imageNum = [_headImageURLArray count] + [_productImageURLArray count];
        _imageDoenLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:imageNum delegate:self];
        [_supplyInformationTableView reloadData];
    }else{
        NSLog(@"刷新失败!");
    }
}

-(void)getSupplyListRequestDidFailed:(GetSupplyListRequest *)getSupplyListRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - GetNeedListData delegate methods

-(void)getNeedListRequestDidFinished:(GetNeedListRequest *)getNeedListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse
{
    if (publicInfoResponse.status == 1) {
        _isNeedDataLoading = YES;
        [_needdInfoArray removeAllObjects];
        _needdInfoArray = [self getMessageInfoDataWithParserArray:publicInfoResponse.dataArray];
        [self createNeedImageURLArray];
        int imageNum = [_needHeadImageURLArray count] + [_needImageURLArray count];
        _needImageDownLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:imageNum delegate:self];
        [_demandInformationTableView reloadData];
    }else{
        NSLog(@"刷新失败!");
    }
}

-(void)getNeedListRequestDidFailed:(GetNeedListRequest *)getNeedListRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - EditPublicInfoViewPop delegate methods

-(void)refreshPublicInfoWhileFallback
{
    [self reloadSupplyTableViewData];
}

#pragma mark- Memory menagement methods

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
    [_imageDoenLoadQueue release];
    _supplyInformationTableView = nil;
    _demandInformationTableView = nil;
    
    [_headImageURLArray release];
    [_productImageURLArray release];
    _headImageURLArray    = nil;
    _productImageURLArray = nil;
    
    [_messageArray release];
    self.supplyParserArray = nil;
    self.needParserArray   = nil;
    [super dealloc];
}

@end
