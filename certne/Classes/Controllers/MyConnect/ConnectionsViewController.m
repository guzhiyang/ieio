//
//  ConnectionsViewController.m
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//--ccuser 替换为friendsListdata

#define kHeaderViewTag 100

#import "ConnectionsViewController.h"
#import "connectionsCell.h"
#import "UserDetailMessageViewController.h"
#import "certneCardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "Foundation.h"

@implementation ConnectionsViewController
@synthesize connectionTableView = _connectionTableView;
@synthesize searchTextField     = _searchTextField;
@synthesize searchButton        = _searchButton;
@synthesize navToolBar;
@synthesize arrow_leftImageView = _arrow_leftImageView;
@synthesize arrow_leftImage     = _arrow_leftImage;
@synthesize myFriendsArray      = _myFriendsArray;
@synthesize parserFriendsArray  = _parserFriendsArray;

#pragma mark- Create data

//--用户信息以聊天信息发送时间的先后排列
-(void)getMyFriendsDataFromArray:(NSArray *)dataArray;
{
    for (NSDictionary *myFriend in dataArray) {
        FriendsInfoListData *friendInfoData = [[FriendsInfoListData alloc] init];
        
        id avatarObject = [myFriend objectForKey:@"avatar"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            friendInfoData.avatar = (NSString *)avatarObject;
        }
        
        id companybject = [myFriend objectForKey:@"company"];
        if ([[companybject class] isSubclassOfClass:[NSString class]]) {
            friendInfoData.company = (NSString *)companybject;
        }
        
        id infoObject = [myFriend objectForKey:@"info"];
        if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
            friendInfoData.info = (NSString *)infoObject;
        }
        
        id nameObject = [myFriend objectForKey:@"name"];
        if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
            friendInfoData.name = (NSString *)nameObject;
        }
        
        id positionObject = [myFriend objectForKey:@"position"];
        if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
            friendInfoData.position = (NSString *)positionObject;
        }
        
        id sortObject = [myFriend objectForKey:@"sort"];
        if ([[sortObject class] isSubclassOfClass:[NSNumber class]]) {
            friendInfoData.sort = [sortObject integerValue];
        }
        
        id uidObject = [myFriend objectForKey:@"uid"];
        if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
            friendInfoData.uid = [uidObject integerValue];
        }
        [_myFriendsArray addObject:friendInfoData];
        [friendInfoData release];
    }
}

-(void)createHeadImageArray
{
    _headImageArray = [[NSMutableArray alloc] init];
    _headImageDic   = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_myFriendsArray count]; i++) {
        FriendsInfoListData *friendInfoList = [_myFriendsArray objectAtIndex:i];
        if ([friendInfoList.avatar length] > 20) {
            NSString *headImageURL = friendInfoList.avatar;
            [_headImageArray addObject:headImageURL];
        }
    }
}

#pragma mark- View lifeCycle methods

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
    
    NSLog(@"重新加载了一遍！");
    
    _headImageDownQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:[_headImageArray count] delegate:self];
    
    _myFriendsArray = [[NSMutableArray alloc] init];
    [self getMyFriendsDataFromArray:self.parserFriendsArray];
    [self createHeadImageArray];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"我的好友"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(55, 12, 248, 20)];
    _searchTextField.delegate      = self;
    _searchTextField.returnKeyType = UIReturnKeyDone;
    _searchTextField.placeholder   = @"搜索";
    _searchTextField.font = [UIFont fontWithName:FONTNAME size:14];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.frame = CGRectMake(20, 7, 30, 30);
    [_searchButton addTarget:self action:@selector(searchFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_friend.png"]];
    [searchView addSubview:_searchTextField];
    [searchView addSubview:_searchButton];
    [self.view addSubview:searchView];
    [_searchTextField release];
    [searchView release];
    
    _connectionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, 320, kUIsIphone5?460:372)];
    _connectionTableView.dataSource     = self;
    _connectionTableView.delegate       = self;
    _connectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_connectionTableView];
    [_connectionTableView release];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f-_connectionTableView.bounds.size.height, self.view.frame.size.width, _connectionTableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [_connectionTableView addSubview:_refreshHeaderView];
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];    // 更新最后的刷新时间
    
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(reloadTableViewDataSource)
                                   userInfo:nil
                                    repeats:NO];
}

#pragma mark - Custom event methods

-(UIImage *)editImage:(UIImage *)downLoadImage
{
    CGFloat cutFloat = downLoadImage.size.height - downLoadImage.size.width;
    CGRect imageRect = CGRectMake(0, cutFloat/2, downLoadImage.size.width, downLoadImage.size.width);
    CGImageRef imageref = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageref, imageRect);
    
    CGSize size;
    size.width  = 140.0f;
    size.height = 140.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return myImage;
}

#pragma mark - 检测网络连接

- (UIView*)bannerView {
    
    if (!_bannerView) {
        
        UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0.0, self.view.frame.size.width, 38.0)];
        
        UILabel *noConnectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0.0, bannerView.frame.size.width, bannerView.frame.size.height)];
        //        [noConnectionLabel setTextColor:[UIColor redColor]];
//        [noConnectionLabel setText:@"没有网络连接!"];
        [noConnectionLabel setTextAlignment:NSTextAlignmentCenter];
        [noConnectionLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NotOnline.png"]]];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = noConnectionLabel.bounds;
        [bannerView.layer insertSublayer:gradient atIndex:0];
        
        [bannerView addSubview:noConnectionLabel];
        [noConnectionLabel release];
        
        [self setBannerView:bannerView];
        [bannerView release];
    }
    return _bannerView;
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    //--展开导航，暂时未实现；
}

#pragma mark - Getheadiamge queue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    //--将图片保存成.png格式--不能在这里保存，取不到size，
    [_headImageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
//    [_headImageDic setObject:UIImagePNGRepresentation([UIImage imageWithData:imageData]) forKey:imageURL];
    [_connectionTableView visibleCells];
    [_connectionTableView reloadData];
}

-(void)downLoadImageFailed:(NSString *)imageURL error:(NSError *)error
{
    NSLog(@"获取头像失败:%@",error);
}

#pragma mark - SearchFriend event methods

-(void)searchFriend:(id)sender
{
    [_searchTextField resignFirstResponder];
    //搜索好友功能实现
    
//    //-------------查询好友
//    NSDictionary *userData;
//    for (int i=0; i<[_myConnections count]; i++) {
//         userData=[_myConnections objectAtIndex:i];
//    }
//    
//    NSString *userName = _searchTextField.text;
//    NSLog(@"userName=%@",userName);
//    
////    userName=[userData objectForKey:@"name"];//----
//    for (NSString *key in _myConnections) {
//        NSPredicate *apredicate=[NSPredicate predicateWithFormat:@"SELF.name like %@",userName];
//        
//        NSArray *newArray=[[NSArray alloc]init];
//        newArray=[(NSArray *)_myConnections filteredArrayUsingPredicate:apredicate];
//        [_myConnections setValue:newArray forKey:key];//-----这一行有错误
//        [self.connectionTableView reloadData];
//    }
}

#pragma mark-UITextfield delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- tableView datasource

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *tempView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    tempView.backgroundColor=[UIColor clearColor];
    return [tempView autorelease];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_myFriendsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    connectionsCell *cell=[[[connectionsCell alloc]init] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//如果不需要重写cell的话可以不用重新设置
    
    UIView *tempView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)] autorelease];
    [tempView setBackgroundColor:UIColorFromFloat(248, 248, 248)];
    cell.backgroundView = tempView;
    
    if ([_myFriendsArray count] > indexPath.row) {
        FriendsInfoListData *friendsInfo = [_myFriendsArray objectAtIndex:indexPath.row];
        [cell setFriendsInfo:friendsInfo indexPath:indexPath];
        NSString *headImageURL = friendsInfo.avatar;
        UIImage *image = [_headImageDic objectForKey:headImageURL];
        if (image) {
            UIImage *headImage = [self editImage:image];
            [cell setUserHeadImage:headImage];
        }else{
            [_headImageDownQueue addImageURL:headImageURL];
        }
    }
    
    if ([cell.nameLabel.text length] == 1) {
        cell.positionLabel.frame = CGRectMake(140, 20, 80, 15);
    }else if ([cell.nameLabel.text length] == 2){
        cell.positionLabel.frame = CGRectMake(160, 20, 80, 15);
    }else if ([cell.nameLabel.text length] == 3){
        cell.positionLabel.frame = CGRectMake(180, 20, 80, 15);
    }else {
        cell.nameLabel.frame = CGRectMake(110, 15, 80, 20);
        cell.positionLabel.frame = CGRectMake(200, 20, 80, 15);
    }
    
    float duration;
    duration=(indexPath.row + 1) *0.3;
    [Animation moveLeftAnimation:cell.view animationDuration:duration wait:YES moveLength:320.0];
    
    cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark- tableView delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsInfoListData *friendsInfo = [_myFriendsArray objectAtIndex:indexPath.row];
    
    if (_getFriendDetailInfoRequest == nil) {
        _getFriendDetailInfoRequest = [[GetFriendDetailInfoRequest alloc] init];
        _getFriendDetailInfoRequest.delegate = self;
    }
    
    [_getFriendDetailInfoRequest sendGetFriendDetailInfoRequestWithSessionid:[Global shareGlobal].session_id fuid:friendsInfo.uid];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_myFriendsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        //--编辑模式
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
    NSLog(@"GetFriendDetailInfoRequestDidFailed:%@",error);
}

#pragma mark- UIScrollViewDelegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark- EGORefreshTableHeader Delegate methods

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

- (void)reloadTableViewDataSource
{
    if (_getMyFriendsInfoRequest == nil) {
        _getMyFriendsInfoRequest = [[GetMyFriendsInfoRequest alloc] init];
        _getMyFriendsInfoRequest.delegate = self;
    }
    
    [_getMyFriendsInfoRequest sendGetMyFriendsInfoRequestWithSessionid:[Global shareGlobal].session_id];
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_connectionTableView];//这里也是重新加载
}

#pragma mark - GetMyFriendsInfoRequest delegate methods

-(void)GetMyFriendsInfoRequestDidFinished:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest myFriendsInfoList:(MyFriendsInfoList *)myFriendsInfoList
{
    if (myFriendsInfoList.status == 1) {
        _reloading = YES;
        [_myFriendsArray removeAllObjects];
        [self getMyFriendsDataFromArray:myFriendsInfoList.friendListArray];
        [_connectionTableView reloadData];
    }else if (myFriendsInfoList.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"刷新失败"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)GetMyFriendsInfoRequestDidFailed:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"刷新失败!"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    _refreshHeaderView   = nil;
    _connectionTableView = nil;
    navToolBar           = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    _arrow_leftImage     = nil;
    _arrow_leftImageView = nil;
    
    [_myFriendsArray release];
    _myFriendsArray = nil;
    [self onDealloc];
    [super dealloc];
}

@end
