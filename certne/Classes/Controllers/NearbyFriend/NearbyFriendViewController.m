//
//  NearbyFriendViewController.m
//  certne
//
//  Created by apple on 13-6-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Global.h"
#import "Foundation.h"
#import "NearbyUserCell.h"
#import "NearbyFriendViewController.h"
#import "NearbyFriendNextViewController.h"
#import "PromptsMessageViewController.h"
#import "PushMessageDataBase.h"

@implementation NearbyFriendViewController
@synthesize nearbyFriendTabelView = _nearbyFriendTabelView;
@synthesize nearbyUserArray       = _nearbyUserArray;
@synthesize nearbyUserParserArray = _nearbyUserParserArray;
@synthesize pushMessageArray      = _pushMessageArray;

#pragma mark- createData for TableView

-(void)createNearbyUserDataWithArray:(NSArray *)dataArray
{
    
    for (NSDictionary *nearbyUser in self.nearbyUserParserArray) {
        NearbyUser *user = [[NearbyUser alloc] init];
        
        id avatarObject = [nearbyUser objectForKey:@"avatar"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            user.avatar = (NSString *)avatarObject;
        }
        
        id nameObject = [nearbyUser objectForKey:@"name"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            user.name = (NSString *)nameObject;
        }
        
        id positionObject = [nearbyUser objectForKey:@"position"];
        if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
            user.position = (NSString *)positionObject;
        }
        
        id infoObject = [nearbyUser objectForKey:@"info"];
        if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
            user.info = (NSString *)infoObject;
        }
        
        id companyObject = [nearbyUser objectForKey:@"company"];
        if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
            user.company = (NSString *)companyObject;
        }
        
        id uidObject = [nearbyUser objectForKey:@"uid"];
        if ([[uidObject class] isSubclassOfClass:[NSString class]]) {
            user.uid = [uidObject integerValue];
        }
        
        id distanceObject = [nearbyUser objectForKey:@"distance"];
        if ([[distanceObject class] isSubclassOfClass:[NSNumber class]]) {
            user.distance = [distanceObject integerValue];
        }

        id mobileObject = [nearbyUser objectForKey:@"mobile"];
        if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
            user.mobile = (NSString *)mobileObject;
        }
        
        [_nearbyUserArray addObject:user];
        [user autorelease];
    }
}

-(void)createHeadImageArray
{
    _headImageArray = [[NSMutableArray alloc] init];
    _headImageDic = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_nearbyUserArray count]; i++) {
        NearbyUser *user = [_nearbyUserArray objectAtIndex:i];
        NSString *headImageURL = user.avatar;
        if ([headImageURL length] > 20) {
            //--如果有人没有传头像就会数组越界--这个问题要解决
            [_headImageArray addObject:headImageURL];
        }
    }
}

-(NSString *)getBadgeNumber
{
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    NSString *badgeString = [NSString stringWithFormat:@"%i",badgeNumber];
    return badgeString;
}

-(void)getPushMessage
{
    PushMessageDataBase *pushMessageDatabase = [[PushMessageDataBase alloc] init];
    self.pushMessageArray = [pushMessageDatabase getAllData];
    [pushMessageDatabase release];
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
    
    [self getPushMessage];
    
    _headImageQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:1 delegate:self];
    _nearbyUserArray = [[NSMutableArray alloc] init];
    [self createNearbyUserDataWithArray:self.nearbyUserParserArray];
    [self createHeadImageArray];

    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"附近好友"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, 320, 1)];
    [lineImageView setBackgroundColor:UIColorFromFloat(224, 224, 224)];
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    UIButton *checkMessageButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkMessageButton setFrame:CGRectMake(280, 27, 30, 30)];
    [checkMessageButton setBackgroundImage:[UIImage imageNamed:@"greeting_chat.png"] forState:UIControlStateNormal];
    [checkMessageButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [checkMessageButton addTarget:self action:@selector(checkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkMessageButton];
    
    _chatMessageLabel = [PromptsLabel sharePromptsLabel];
    _chatMessageLabel.frame = CGRectMake(297, 27, 16, 16);
    if ([self.pushMessageArray count] > 0) {
        PushMessage *pushMessage =[self.pushMessageArray objectAtIndex:0];
        _chatMessageLabel.promptsNumber = pushMessage.totalNum;
    }
//    _chatMessageLabel.promptsNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    _chatMessageLabel.text = [NSString stringWithFormat:@"%i",_chatMessageLabel.promptsNumber];
    if (_chatMessageLabel.promptsNumber > 0) {
        [self.view addSubview:_chatMessageLabel];
    }
    
    _nearbyFriendTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, kUIsIphone5?504:416)];
    _nearbyFriendTabelView.delegate       = self;
    _nearbyFriendTabelView.dataSource     = self;
    _nearbyFriendTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_nearbyFriendTabelView];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *tempView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _nearbyFriendTabelView.bounds.size.height, _nearbyFriendTabelView.bounds.size.width, _nearbyFriendTabelView.bounds.size.height)];
        tempView.delegate = self;
        [_nearbyFriendTabelView addSubview:tempView];
        _refreshHeaderView = tempView;
        [_refreshHeaderView release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    //--每隔30秒刷新一次，太浪费服务器资源
//    [NSTimer scheduledTimerWithTimeInterval:30
//                                     target:self
//                                   selector:@selector(reLoadTableViewData)
//                                   userInfo:nil
//                                    repeats:YES];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark - Custom event methods

-(void)checkButtonClicked:(id)sender
{
    _chatMessageLabel.hidden = YES;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //--弹出信息界面
//    PromptsMessageViewController *promptsMessageViewController = [[PromptsMessageViewController alloc] init];
//    promptsMessageViewController.messageArray = self.pushMessageArray;
//    [self.navigationController pushViewController:promptsMessageViewController animated:NO];

    if (_readNoticeRequest == nil) {
        _readNoticeRequest = [[ReadNoticeRequest alloc] init];
        _readNoticeRequest.delegate = self;
    }
    
    [_readNoticeRequest sendReadNoticeRequestWithSessionID:[Global shareGlobal].session_id];
    
    _promptsMessageViewController = [[PromptsMessageViewController alloc] init];
    [self.navigationController pushViewController:_promptsMessageViewController animated:NO];
}

-(UIImage *)editHeadImage:(UIImage *)downLoadImage
{
    CGFloat cutFloat = downLoadImage.size.height - downLoadImage.size.width;
    CGRect imageRect = CGRectMake(0, cutFloat/2, downLoadImage.size.width, downLoadImage.size.width);
    CGImageRef imageRef = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width  = 140.0f;
    size.height = 140.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

-(BOOL)clearPushMessage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths firstObject];
    NSString *sqlPath = [documentFile stringByAppendingPathComponent:PUSHMESSAGEDBNAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL clearPushMessage = [fileManager removeItemAtPath:sqlPath error:nil];
    return clearPushMessage;
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    //--展开导航界面
}

#pragma mark - HeadImage downQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_headImageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_nearbyFriendTabelView visibleCells];
    [_nearbyFriendTabelView reloadData];
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

#pragma mark- tableView datasource

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
    return [_nearbyUserArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearbyUserCell *cell = [[[NearbyUserCell alloc] init] autorelease];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.accessoryType   = UITableViewCellAccessoryNone;
    
    [cell cleanComponents];
    
    if ([_nearbyUserArray count] > indexPath.row) {
        NearbyUser *user = [_nearbyUserArray objectAtIndex:indexPath.row];
        [cell setUserMessage:user indexPath:indexPath];
        NSString *headImageURL = user.avatar;
        UIImage *image = [_headImageDic objectForKey:headImageURL];
        if (image) {
            UIImage *headImage = [self editHeadImage:image];
            [cell setUserHeadImage:headImage];
        }else{
            [_headImageQueue addImageURL:headImageURL];
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
    duration = (indexPath.row + 1 )*0.3;
    [Animation moveLeftAnimation:cell.animationView animationDuration:duration wait:YES moveLength:320.0];

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    [tempView setBackgroundColor:[UIColor clearColor]];
    return [tempView autorelease];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark- tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.nearbyFriendTabelView deselectRowAtIndexPath:indexPath animated:YES];
    
    NearbyUser *user = [_nearbyUserArray objectAtIndex:indexPath.row];
    NearbyFriendNextViewController *nearbyFriendNextViewController = [[NearbyFriendNextViewController alloc]init];
    nearbyFriendNextViewController.user = user;
    nearbyFriendNextViewController.headImageURL = [_headImageArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nearbyFriendNextViewController animated:NO];
    [nearbyFriendNextViewController release];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark - RefreshTableViewData delegate methods

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reLoadTableViewData];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)reLoadTableViewData
{
    if (_getNearbyUserListRequest == nil) {
        _getNearbyUserListRequest = [[GetNearbyUserListRequest alloc] init];
        _getNearbyUserListRequest.delegate = self;
    }
    
    [_getNearbyUserListRequest sendGetNearbyUserListRequestWithSessionid:[Global shareGlobal].session_id longitude:[Global shareGlobal].longitude latitude:[Global shareGlobal].latitude];
}

-(void)doneLoadingTableViewData
{
    _isLoading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_nearbyFriendTabelView];
}

#pragma mark - GetNearbyUserListRequest delegate methods

-(void)GetNearbyUserListRequestDidFinished:(GetNearbyUserListRequest *)getNearbyUserListRequest nearbyUserList:(NearbyUserList *)nearbyUserList
{
    if (nearbyUserList.status == 1) {
        _isLoading = YES;
        [_nearbyUserArray removeAllObjects];
        [self createNearbyUserDataWithArray:nearbyUserList.nearbyUserArray];
        [_nearbyFriendTabelView reloadData];
    }else if(nearbyUserList.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"刷新附近的好友失败!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)GetNearbyUserListRequestDidFailed:(GetNearbyUserListRequest *)getNearbyUserListRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - ReadNoticeRequest delegate methods

-(void)readNoticeRequestDidFinish:(ReadNoticeRequest *)readNoticeRequest statusResponse:(StatusResponse *)statusResponse
{
    if (statusResponse.status == 1) {
        _chatMessageLabel.hidden = YES;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        _promptsMessageViewController.messageArray = self.pushMessageArray;
        BOOL success =[self clearPushMessage];
        if (success) {
            NSLog(@"信息清理成功!");
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除失败!"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开推动消息失败"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)readNoticeRequestDidFailed:(ReadNoticeRequest *)readNoticeRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark- memroy Management methods

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
    if (_getNearbyUserListRequest) {
        [_getNearbyUserListRequest cancle];
    }
    [_headImageQueue release];
    [_headImageArray release];
    [_headImageDic release];
    _headImageQueue = nil;
    _headImageArray = nil;
    _headImageDic   = nil;
    [super dealloc];
}

@end
