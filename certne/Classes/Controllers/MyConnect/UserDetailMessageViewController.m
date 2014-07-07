//
//  UserDetailMessageViewController.m
//  certne
//
//  Created by apple on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UserDetailMessageViewController.h"
#import "Foundation.h"
#import "Global.h"

@implementation UserDetailMessageViewController
@synthesize userDetailMessageTableView = _userDetailMessageTableView;
@synthesize userInfoArray    = _userInfoArray;
@synthesize friendDetailData = _friendDetailData;
@synthesize friendInfoMsg    = _friendInfoMsg;

#pragma mark - create userDetail data

-(void)createUserDetailInfo
{
    _publishMsgArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *publishMsg in self.userInfoArray) {
        InfoData *detailData = [[InfoData alloc] init];
        
        id infoIDObject = [publishMsg objectForKey:@"info_id"];
        if ([[infoIDObject class] isSubclassOfClass:[NSString class]]) {
            detailData.infoID = [infoIDObject integerValue];
        }
        
        id imgObject = [publishMsg objectForKey:@"imgs"];
        if ([[imgObject class] isSubclassOfClass:[NSString class]]) {
            detailData.img = (NSString *)imgObject;
        }
        
        id descObject = [publishMsg objectForKey:@"desc"];
        if ([[descObject class] isSubclassOfClass:[NSString class]]) {
            detailData.desc = (NSString *)descObject;
        }
        
        id addressObject = [publishMsg objectForKey:@"publish_address"];
        if ([[addressObject class] isSubclassOfClass:[NSString class]]) {
            detailData.publishAddress = (NSString *)addressObject;
        }
        
        id infoTypeObject = [publishMsg objectForKey:@"info_type"];
        if ([[infoIDObject class] isSubclassOfClass:[NSString class]]) {
            detailData.infoType = [infoTypeObject integerValue];
        }
        
        id addTimeObject = [publishMsg objectForKey:@"add_time"];
        if ([[addTimeObject class] isSubclassOfClass:[NSString class]]) {
            detailData.addTime = (NSString *)addTimeObject;
        }
        [_publishMsgArray addObject:detailData];
    }
}

-(void)createImageURLArray
{
//    _imageURLArray = [[NSMutableArray alloc] init];
    _imageURLArray = [NSMutableArray arrayWithObjects:nil];
    _imageDictionary = [NSMutableDictionary dictionary];
//    _imageDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_publishMsgArray count]; i++) {
        InfoData *infoData = [_publishMsgArray objectAtIndex:i];
        NSString *imageURL = infoData.img;
        [_imageURLArray addObject:imageURL];
    }
}

#pragma mark- View lifecycle

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
    
    [self createUserDetailInfo];
    
//    _headImageDownloader = [[ImageDownLoader alloc] initWithURLString:self.friendDetailData.avatar delegate:self];
    
    //--imageQueue 图片下载队列
    [self createImageURLArray];
//    _imageDownLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:[_imageURLArray count] delegate:self];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"用户信息"];
    [self.view addSubview:_navBarView];
    
    _userDetailMessageTableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 74, kFBaseWidth - 20, kUIsIphone5?484:396) style:UITableViewStylePlain];
    _userDetailMessageTableView.delegate        = self;
    _userDetailMessageTableView.dataSource      = self;
    _userDetailMessageTableView.backgroundColor = [UIColor clearColor];
    _userDetailMessageTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_userDetailMessageTableView];
    
    //--添加弹出菜单
    QBKOverlayMenuViewOffset offset;
    offset.bottomOffset = 44;
    _overlayMenuView = [[QBKOverlayMenuView alloc] initWithDelegate:self position:kQBKOverlayMenuViewPositionBottom offset:offset];
    [_overlayMenuView setParentView:self.view];
    [_overlayMenuView addButtonWithImage:[UIImage imageNamed:@"overLay_info.png"] index:0];
    [_overlayMenuView addButtonWithImage:[UIImage imageNamed:@"overLay_web.png"] index:1];
    [_overlayMenuView addButtonWithImage:[UIImage imageNamed:@"overLay_favourite.png"] index:2];
    [_overlayMenuView addButtonWithImage:[UIImage imageNamed:@"overLay_chat.png"] index:3];
    [_overlayMenuView addButtonWithImage:[UIImage imageNamed:@"overLay_phone.png"] index:4];
    
    self.view.backgroundColor = UIColorFromFloat(216, 215, 210);
}

#pragma mark - Custom event methods

-(UIImage *)editImage:(UIImage *)downLoadImage
{
    CGFloat imageWidth  = downLoadImage.size.width;
    CGFloat imageHeight = downLoadImage.size.height;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect imageRect    = CGRectMake(0, cutFloat/2, imageWidth, imageWidth*11/12);
    CGImageRef imageref = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageref, imageRect);
    
    CGSize size;
    size.width  = 300.0f;
    size.height = 275.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return myImage;
}

-(UIImage *)editHeadImage:(UIImage *)headImageDownLoad
{
    CGFloat imageWidth  = headImageDownLoad.size.width;
    CGFloat imageHeight = headImageDownLoad.size.height;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect imageRect    = CGRectMake(0, cutFloat/2, imageWidth, imageWidth);
    CGImageRef imageRef = headImageDownLoad.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 40.0f;
    size.height = 40.0f;
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
    [self.navigationController popViewControllerAnimated:NO];
}

//#pragma mark - HeadImageDownLoad delegate methods
//
//-(void)downLoadFinish:(ImageDownLoader *)downLoader
//{
//}
//
//-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
//{
//    _headImageData = downLoader.receivedData;
//}
//
//-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
//                                                        message:@"请检查网络设置"
//                                                       delegate:self
//                                              cancelButtonTitle:@"好的"
//                                              otherButtonTitles:nil];
//    [alertView show];
//}

#pragma mark- ImageDownLoadQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_imageDictionary setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_userDetailMessageTableView visibleCells];
    [_userDetailMessageTableView reloadData];
}

-(void)downLoadImageFailed:(NSString *)imageURL error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark- TableView datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_publishMsgArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoData *infoData = [_publishMsgArray objectAtIndex:indexPath.row];
    CGFloat height = [UserDetailMessageCardCell caculateCellHeightWithPublishMessage:infoData.desc];
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UserDetailMessageCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UserDetailMessageCardCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    if ([_publishMsgArray count] > indexPath.row) {
        InfoData *infoData = [_publishMsgArray objectAtIndex:indexPath.row];
        [cell setUserPublishMessage:self.friendDetailData publicInfo:infoData indexPath:indexPath];
        
        if (_headImageData) {
            UIImage *image = [UIImage imageWithData:_headImageData];
            UIImage *headImage = [self editHeadImage:image];
            [cell setHeadImage:headImage];
        }
        
        NSString *imageURL = infoData.img;
        UIImage *image = [_imageDictionary objectForKey:imageURL];
        if (image) {
            UIImage *productImage = [self editImage:image];
            [cell setProductImage:productImage];
        }else{
//            [_imageDownLoadQueue addImageURL:imageURL];
        }
    }
    
    return cell;
}

#pragma mark- HeadImageButton clicked methods

-(void)loadUserCardView:(HeadImageButton *)headImagebutton
{
    //--该界面已删除
    NSLog(@"该界面已删除！");
}

#pragma mark- TableView  delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark- 弹出菜单代理方法

-(void)overlayMenuView:(QBKOverlayMenuView *)overlayMenuView didActivateAdditionalButtonWithIndex:(NSInteger)index
{
    NSString *chinaPhone = [NSString stringWithFormat:@"+86%@",self.friendDetailData.mobile];
    
    if (index == 4) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",chinaPhone];//--返回通讯录
//        NSString  *phoneNumber=[[NSString alloc]initWithFormat:@"telprompt://%@",number];//电话结束返回程序,私有API
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
        if (_addToContactListRequest == nil) {
            _addToContactListRequest = [[AddToContactListRequest alloc] init];
            _addToContactListRequest.delegate = self;
        }
        
        [_addToContactListRequest sendAddToContactListRequestWithSessionID:[Global shareGlobal].session_id cuid:[self.friendDetailData.uid integerValue]];
    }else if (index == 3){
        //--转向发短信界面，这个需要拼接字符串，将sms:和用户的电话号码拼接
        NSString *urlString=[NSString stringWithFormat:@"sms%@",chinaPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }else if (index == 2){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加到我的收藏夹"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"取消",@"好的", nil];
        [alertView show];
    }else if (index == 1){
        NSString *website = [NSString stringWithFormat:@"http://%@",self.friendDetailData.website];
        UserWebsiteViewController *userWebsiteViewController = [[UserWebsiteViewController alloc] init];
        userWebsiteViewController.websiteString = website;
        [self.navigationController pushViewController:userWebsiteViewController animated:NO];
    }else if (index == 0){
        setMessageViewController *setmessageViewControl = [[setMessageViewController alloc] init];
        setmessageViewControl.friendDetailData = self.friendDetailData;
        [self.navigationController pushViewController:setmessageViewControl animated:NO];
    }
}

-(void)didPerformFoldActionInOverlayMenuView:(QBKOverlayMenuView *)overlaymenuView
{
}

-(void)didPerformUnfoldActionInOverlayMenuView:(QBKOverlayMenuView *)overlaymenuView
{
}

#pragma mark - AddToContactList delegate methods

-(void)addToContactListRequestDidFinished:(AddToContactListRequest *)addToContactListRequest response:(StatusResponse *)response
{
    if (response.status == 1) {
        NSLog(@"已添加到联系列表");
    }else{
        NSLog(@"没有收到信息");
    }
}

-(void)addToContactListRequestDidFailed:(AddToContactListRequest *)addToContactListRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    _publishMsgArray      = nil;
    self.friendDetailData = nil;
    self.friendInfoMsg    = nil;
    self.userInfoArray    = nil;
}

@end
