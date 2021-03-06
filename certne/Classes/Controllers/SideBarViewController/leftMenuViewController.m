//
//  leftMenuViewController.m
//  certne
//
//  Created by apple on 13-5-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "leftMenuViewController.h"
#import "Global.h"
#import "NearbyFriendViewController.h"

@interface leftMenuViewController ()
{
    int _selectIdnex;
}
@end

@implementation leftMenuViewController
@synthesize menuTableView;
@synthesize iconArray = _iconArray;

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
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
        
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
    backgroundImageView.image = [UIImage imageNamed:@"test_left.png"];
    [self.view addSubview:backgroundImageView];
    
    menuDataList = [[NSMutableArray alloc]initWithObjects:@"我的名片",@"我的好友",@"附近查找",@"最近联系",@"发布供需",@"系统设置", nil];
    
    UIImage *around_Image        = [UIImage imageNamed:@"mycard.png"];
    UIImage *manageImage         = [UIImage imageNamed:@"myship.png"];
    UIImage *myImage             = [UIImage imageNamed:@"nearby.png"];
    UIImage *supply_image        = [UIImage imageNamed:@"chat.png"];
    UIImage *recent_contactImage = [UIImage imageNamed:@"supply.png"];
    UIImage *system_settingImage = [UIImage imageNamed:@"mySetting.png"];
    
    _iconArray = [[NSArray alloc]initWithObjects:around_Image,manageImage,myImage,supply_image,recent_contactImage,system_settingImage, nil];
    
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)])
        {
            [_delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
            _selectIdnex = 0;
        }
    }
    
    //--各个导航界面初始化
//    _certneCardViewController         = [[certneCardViewController alloc] init];
    _connectViewController            = [[ConnectionsViewController alloc]init];
    _recentContactViewController      = [RecentContactViewController new];
    _publishInformationViewController = [PublishInformationViewController new];
    _systemSettingViewController      = [SystemSettingViewController new];
    
    [self getConnectionFriendsInfo];
//    [self getNearbyUserListData];
    [self getSupplyListData];
    [self getNeedListData];
    [self getRecentContactUserData];
    
    //这里有个Bug 空出了20px的高度
    menuTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, 230, kFBaseHeight - 20) style:UITableViewStylePlain];
    menuTableView.delegate   = self;
    menuTableView.dataSource = self;
    menuTableView.bounces    = NO;
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    menuTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:menuTableView];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark - Get MyFriendsInfo methods

-(void)getConnectionFriendsInfo
{
    if (_getMyFriendsInfoRequest == nil) {
        _getMyFriendsInfoRequest = [[GetMyFriendsInfoRequest alloc] init];
        _getMyFriendsInfoRequest.delegate = self;
    }
    
    [_getMyFriendsInfoRequest sendGetMyFriendsInfoRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)GetMyFriendsInfoRequestDidFinished:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest myFriendsInfoList:(MyFriendsInfoList *)myFriendsInfoList
{
    if (myFriendsInfoList.status == 1) {
        _getFriendsTempArray = myFriendsInfoList.friendListArray;
    }else if (myFriendsInfoList.status == 0){
        _getFriendsResponse = myFriendsInfoList.msg;
    }
}

-(void)GetMyFriendsInfoRequestDidFailed:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Get NearByUserdata methods

//-(void)getNearbyUserListData
//{
//    if (_getNearbyUserListRequest == nil) {
//        _getNearbyUserListRequest = [[GetNearbyUserListRequest alloc] init];
//        _getNearbyUserListRequest.delegate = self;
//    }
//    
//    [_getNearbyUserListRequest sendGetNearbyUserListRequestWithSessionid:[Global shareGlobal].session_id longitude:[Global shareGlobal].longitude latitude:[Global shareGlobal].latitude];
//}
//
//-(void)GetNearbyUserListRequestDidFinished:(GetNearbyUserListRequest *)getNearbyUserListRequest nearbyUserList:(NearbyUserList *)nearbyUserList
//{
//    if (nearbyUserList.status == 1) {
//        _getNearbyUserTempArray = nearbyUserList.nearbyUserArray;
//    }else if (nearbyUserList.status == 0){
//        NSLog(@"nearbyUserList.msg:%@",nearbyUserList.msg);
//    }
//}
//
//-(void)GetNearbyUserListRequestDidFailed:(GetNearbyUserListRequest *)getNearbyUserListRequest error:(NSError *)error
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
//                                                        message:@"请检查网络设置"
//                                                       delegate:self
//                                              cancelButtonTitle:@"好的"
//                                              otherButtonTitles:nil];
//    [alertView show];
//}

#pragma mark - Get SupplyList data

-(void)getSupplyListData
{
    if (_getSupplyListRequest == nil) {
        _getSupplyListRequest = [[GetSupplyListRequest alloc] init];
        _getSupplyListRequest.delegate = self;
    }
    
    [_getSupplyListRequest sendPublicBuinessMessageRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)getSupplyListRequestDidFinished:(GetSupplyListRequest *)getSupplyListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse
{
    if (publicInfoResponse.status == 1) {
        _getSupplyListArray = publicInfoResponse.dataArray;
        _getSupplyResponse  = publicInfoResponse.msg;
    }else if (publicInfoResponse.status == 0){
        NSLog(@"getSupplyListRequestDidFailed:%@",publicInfoResponse.msg);
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
}

#pragma mark - Get NeedList data

-(void)getNeedListData
{
    if (_getNeedListRequest == nil) {
        _getNeedListRequest = [[GetNeedListRequest alloc] init];
        _getNeedListRequest.delegate = self;
    }
    
    [_getNeedListRequest sendGetNeedListRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)getNeedListRequestDidFinished:(GetNeedListRequest *)getNeedListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse
{
    if (publicInfoResponse.status == 1) {
        _getNeedListArray = publicInfoResponse.dataArray;
        _getNeedResponse  = publicInfoResponse.msg;
    }else if (publicInfoResponse.status == 0){
        NSLog(@"getSupplyListRequestDidFailed:%@",publicInfoResponse.msg);
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
}

#pragma mark - getRecentContact user Data

-(void)getRecentContactUserData
{
    if (_getContactUserListRequest == nil) {
        _getContactUserListRequest = [[GetContactUserListRequest alloc] init];
        _getContactUserListRequest.delegate = self;
    }
    
    [_getContactUserListRequest sendGetContactUserListRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)GetContactUserListRequestDidFinished:(GetContactUserListRequest *)getContactUserListRequest recentContactUserList:(RecentContactUserList *)recentContactUserList
{
    if (recentContactUserList.status == 1) {
        _getContactUserTempArray = recentContactUserList.dataArray;
    }else if (recentContactUserList.status == 0){
        NSLog(@"GetContactUserListRequestDidFailed:%@",recentContactUserList.msg);
    }
}

-(void)GetContactUserListRequestDidFailed:(GetContactUserListRequest *)getContactUserListRequest error:(NSError *)error
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuDataList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kUIsIphone5?88.0f:75.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerTempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    [footerTempView setBackgroundColor:[UIColor whiteColor]];
    return footerTempView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    LeftSidebarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LeftSidebarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    cell.iconImageView.image = [_iconArray objectAtIndex:indexPath.row];
    cell.titleLabel.text     = [menuDataList objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
            if (indexPath.row == _selectIdnex) {
                [_delegate leftSideBarSelectWithController:[self subConWithIndex:indexPath.row]];
//                [_delegate leftSideBarSelectWithController:_certneCardViewController];
            }
            else if(indexPath.row == 1)
            {
                _connectViewController.parserFriendsArray = _getFriendsTempArray;
                UINavigationController *connectNavVC = [[UINavigationController alloc] initWithRootViewController:_connectViewController];
                connectNavVC.navigationBarHidden = YES;
                [_delegate leftSideBarSelectWithController:connectNavVC];
            }
            else if(indexPath.row == 2)
            {
                NearbyFriendViewController *nearbyFriendView = [[NearbyFriendViewController alloc] init];
                UINavigationController *nearbyFriendNavVC = [[UINavigationController alloc] initWithRootViewController:nearbyFriendView];
                nearbyFriendView.navViewTitle = [menuDataList objectAtIndex:indexPath.row];
                nearbyFriendView.isSideBarNavVC = YES;
                nearbyFriendNavVC.navigationBarHidden = YES;
                [_delegate leftSideBarSelectWithController:nearbyFriendNavVC];
            }
            else if(indexPath.row == 3)
            {
                _recentContactViewController.contactUserParserArray = _getContactUserTempArray;
                UINavigationController *recentContactNavVC = [[UINavigationController alloc] initWithRootViewController:_recentContactViewController];
                _recentContactViewController.navViewTitle = [menuDataList objectAtIndex:indexPath.row];
                _recentContactViewController.isSideBarNavVC = YES;
                recentContactNavVC.navigationBarHidden = YES;
                [_delegate leftSideBarSelectWithController:recentContactNavVC];
            }
            else if(indexPath.row == 4)
            {
                _publishInformationViewController.supplyParserArray = _getSupplyListArray;
                _publishInformationViewController.needParserArray   = _getNeedListArray;
                UINavigationController *publishInfoNavVC = [[UINavigationController alloc] initWithRootViewController:_publishInformationViewController];
                _publishInformationViewController.navViewTitle = [menuDataList objectAtIndex:indexPath.row];
                _publishInformationViewController.isSideBarNavVC = YES;
                publishInfoNavVC.navigationBarHidden = YES;
                [_delegate leftSideBarSelectWithController:publishInfoNavVC];
            }
            else
            {
                UINavigationController *systemSettingNavVC = [[UINavigationController alloc] initWithRootViewController:_systemSettingViewController];
                _systemSettingViewController.navViewTitle = [menuDataList objectAtIndex:indexPath.row];
                _systemSettingViewController.isSideBarNavVC = YES;
                systemSettingNavVC.navigationBarHidden = YES;
                [_delegate leftSideBarSelectWithController:systemSettingNavVC];
            }
        }
    }
}

-(UIViewController *)subConWithIndex:(int)index
{
    certneCardViewController *certneViewController = [[certneCardViewController alloc]init];
    UINavigationController *certneCardNavVC = [[UINavigationController alloc] initWithRootViewController:certneViewController];
    return certneCardNavVC;
}

#pragma mark- Memory management methods

- (void)viewWillUnload
{
    [super viewWillUnload];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    _systemSettingViewController = nil;
    _recentContactViewController = nil;
    _connectViewController       = nil;
    _iconArray = nil;
    
    _getFriendsTempArray = nil;
    _getFriendsResponse  = nil;
}

@end
