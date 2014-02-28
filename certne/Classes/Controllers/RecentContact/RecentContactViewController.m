//
//  RecentContactViewController.m
//  certne
//
//  Created by apple on 13-6-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RecentContactViewController.h"
#import "RecentContactCell.h"
#import "UserDetailMessageViewController.h"
#import "Global.h"
#import "Foundation.h"

@implementation RecentContactViewController
@synthesize recentContactTabelView = _recentContactTabelView;
@synthesize contactUserParserArray = _contactUserParserArray;

#pragma mark- Create data for tableview

-(void)getContactUserDataWithArray:(NSArray *)dataArray
{
    for (NSDictionary *contactUser in dataArray) {
        ContactUser *user = [[ContactUser alloc] init];
        
        id avatarObject = [contactUser objectForKey:@"avatar"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            user.avatar = (NSString *)avatarObject;
        }
        
        id nameObject = [contactUser objectForKey:@"name"];
        if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
            user.name = (NSString *)nameObject;
        }
        
        id positionObject = [contactUser objectForKey:@"position"];
        if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
            user.position = (NSString *)positionObject;
        }
        
        id infoObject = [contactUser objectForKey:@"info"];
        if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
            user.info = (NSString *)infoObject;
        }
        
        id companyObject = [contactUser objectForKey:@"company"];
        if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
            user.company = (NSString *)companyObject;
        }
        
        id uidObject = [contactUser objectForKey:@"uid"];
        if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
            user.uid = [uidObject integerValue];
        }
        
        id sortObject = [contactUser objectForKey:@"sort"];
        if ([[sortObject class] isSubclassOfClass:[NSNumber class]]) {
            user.sort = [sortObject integerValue];
        }
        [_contactUserArray addObject:user];
        [user release];
    }
}

-(void)getImageURLData
{
    _imageURLArray = [[NSMutableArray alloc] init];
    _imageDic = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_contactUserArray count]; i++) {
        ContactUser *user = [_contactUserArray objectAtIndex:i];
        if ([user.avatar length] > 10) {
            NSString *imageURL = user.avatar;
            [_imageURLArray addObject:imageURL];
        }
    }
}

#pragma mark- view lifeCycle methods

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
    
    /**
     *	@brief	获取联系好友纪录信息
     */
    _contactUserArray = [[NSMutableArray alloc] init];
    [self getContactUserDataWithArray:self.contactUserParserArray];
    
    [self getImageURLData];
    _imageDownloadImageQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:[_imageURLArray count] delegate:self];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"最近联系"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 65, 320, 1)];
    [lineImageView setBackgroundColor:UIColorFromFloat(224, 224, 224)];
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    _recentContactTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, kUIsIphone5?504:416)];
    _recentContactTabelView.delegate   = self;
    _recentContactTabelView.dataSource = self;
    _recentContactTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_recentContactTabelView];
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _recentContactTabelView.bounds.size.height, _recentContactTabelView.bounds.size.width, _recentContactTabelView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [_recentContactTabelView addSubview:_refreshHeaderView];
        [_refreshHeaderView release];
    }
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

#pragma mark - NavbarView delegate methods

-(void)fallBackButtonClicked
{
    //--展开导航
}

#pragma mark- tableView datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contactUserArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //--如果使用重用，刷新一次cell会向左滑动一次
//    static NSString *CustomCellIdentifier=@"_connectionsCell";
//    
//    RecentContactCell *cell=(RecentContactCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
//    if (!cell) {
//        cell=[[[RecentContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType  = UITableViewCellAccessoryNone;
//    }
    
    RecentContactCell *cell = [[[RecentContactCell alloc] init] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryNone;

    
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)];
    [tempView setBackgroundColor:UIColorFromFloat(251, 251, 251)];
    cell.backgroundView=tempView;
    [tempView release];
    
    [cell cleanComponents];
    
    if ([_contactUserArray count]>indexPath.row) {
        ContactUser *user = [_contactUserArray objectAtIndex:indexPath.row];
        [cell setUserMessage:user indexPath:indexPath];
        NSString *headImageURL = user.avatar;
        UIImage *image = [_imageDic objectForKey:headImageURL];
        if (image) {
            UIImage *headImage = [self editImage:image];
            [cell setUserHeadImage:headImage];
        }else{
            [_imageDownloadImageQueue addImageURL:headImageURL];
        }
    }
    
    if ([cell.nameLabel.text length] == 1) {
        cell.positionLabel.frame = CGRectMake(140, 20, 80, 15);
    }else if ([cell.nameLabel.text length] == 2){
        cell.positionLabel.frame = CGRectMake(160, 20, 80, 15);
    }else if ([cell.nameLabel.text length] == 3){
        cell.positionLabel.frame = CGRectMake(180, 20, 80, 15);
    }else {
        cell.nameLabel.frame     = CGRectMake(110, 15, 80, 20);
        cell.positionLabel.frame = CGRectMake(200, 20, 80, 15);
    }
    
    float duration;
    duration=(indexPath.row + 1 ) * 0.3;
    [Animation moveLeftAnimation:cell.view animationDuration:duration wait:YES moveLength:320.0];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *tempView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
}

#pragma mark- tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactUser *user = [_contactUserArray objectAtIndex:indexPath.row];
    
    if (_getFriendDetailInfoRequest == nil) {
        _getFriendDetailInfoRequest = [[GetFriendDetailInfoRequest alloc] init];
        _getFriendDetailInfoRequest.delegate = self;
    }
    
    [_getFriendDetailInfoRequest sendGetFriendDetailInfoRequestWithSessionid:[Global shareGlobal].session_id fuid:user.uid];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [_contactUserArray removeObjectAtIndex:indexPath.row];
        [_recentContactTabelView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        //--编辑状态
    }
}

#pragma mark - ImageDownLoadImageQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_imageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_recentContactTabelView visibleCells];
    [_recentContactTabelView reloadData];
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

#pragma mark - GetFriendsDetailMsg delegate methods

-(void)GetFriendDetailInfoRequestDidFinished:(GetFriendDetailInfoRequest *)getFriendDetailInfoRequest friendDetailInfo:(FriendInfoAndMessage *)friendDetailInfo
{
    if (friendDetailInfo.status == 1) {
        UserDetailMessageViewController *userDetailMessageViewController = [[UserDetailMessageViewController alloc] init];
        userDetailMessageViewController.friendDetailData = friendDetailInfo.data;
        userDetailMessageViewController.userInfoArray = friendDetailInfo.infoArray;
        [self.navigationController pushViewController:userDetailMessageViewController animated:NO];
    }else{
        NSLog(@"获取好友联系信息数组失败");
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

#pragma mark - ReloadTableViewData delegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewData];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _isLoading;
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

-(void)reloadTableViewData
{
    if (_getContactUserListRequest == nil) {
        _getContactUserListRequest = [[GetContactUserListRequest alloc] init];
        _getContactUserListRequest.delegate = self;
    }
    
    [_getContactUserListRequest sendGetContactUserListRequestWithSessionid:[Global shareGlobal].session_id];
}

-(void)doneLoadingTableViewData
{
    _isLoading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_recentContactTabelView];
}

#pragma mark - GetContactUserListRequest delegate methods

-(void)GetContactUserListRequestDidFinished:(GetContactUserListRequest *)getContactUserListRequest recentContactUserList:(RecentContactUserList *)recentContactUserList
{
    if (recentContactUserList.status == 1) {
        _isLoading = YES;
        [_contactUserArray removeAllObjects];
        [self getContactUserDataWithArray:recentContactUserList.dataArray];
        [_recentContactTabelView reloadData];
    }else if (recentContactUserList.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"刷新失败!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
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
    [alertView release];
}

#pragma mark - memory management methods

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillUnload
{
    [super viewWillUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    if (_getContactUserListRequest) {
        [_getContactUserListRequest cancle];
    }
    
    if (_getFriendDetailInfoRequest) {
        [_getFriendDetailInfoRequest cancle];
    }
    
    [_imageDic release];
    [_imageURLArray release];
    [_imageDownloadImageQueue release];
    _imageDic                = nil;
    _imageURLArray           = nil;
    _imageDownloadImageQueue = nil;
    
    [_recentContactTabelView release];
    _contactUserArray = nil;
    [super dealloc];
}
@end
