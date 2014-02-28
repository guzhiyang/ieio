//
//  ChangeCardViewController.m
//  certne
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//-- 获取用户的id的方法已设计好，待测试

#import "ChangeCardViewController.h"
#import "ChangeCardUserCell.h"
#import "Global.h"
#import "Foundation.h"
#import "CardListData.h"

@implementation ChangeCardViewController
@synthesize changeCardTableView = _changeCardTableView;
@synthesize currentIndex        = _currentIndex;
@synthesize userListArray       = _userListArray;
@synthesize userArray           = _userArray;
@synthesize headImageURLArray   = _headImageURLArray;

#pragma mark- Create cardMessage data

-(void)crerateUserData
{
    _userArray = [[NSMutableArray alloc] init];

    for (NSDictionary *user in self.userListArray) {
        CardListData *cardListData = [[CardListData alloc] init];

        id avatarObject = [user objectForKey:@"avatar"];
        if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
            cardListData.avatar = (NSString *)avatarObject;
        }
        
        id nameObject = [user objectForKey:@"name"];
        if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
            cardListData.name = (NSString *)nameObject;
        }
        
        id positionObject = [user objectForKey:@"position"];
        if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
            cardListData.position = (NSString *)positionObject;
        }
        
        id infoObject = [user objectForKey:@"info"];
        if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
            cardListData.info = (NSString *)infoObject;
        }
        
        id companyObject = [user objectForKey:@"company"];
        if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
            cardListData.company = (NSString *)companyObject;
        }
        
        id uidObject = [user objectForKey:@"uid"];
        if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
            cardListData.uid = [uidObject integerValue];
        }
        
        [_userArray addObject:cardListData];
        [cardListData release];
    }
}

-(void)getHeadImageURLArray
{
    self.headImageURLArray = [[NSMutableArray alloc] init];
    _headImageDic = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i = 0; i < [_userArray count]; i++) {
        CardListData *userData = [_userArray objectAtIndex:i];
        NSString *headImageURL = userData.avatar;
        if ([headImageURL length] > 20) {
            [self.headImageURLArray addObject:headImageURL];
        }
    }
}

#pragma mark- View stylelife methods

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
    
    //--获取交换名片的用户信息
    [self crerateUserData];
    [self getHeadImageURLArray];
    _imageDownLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:[self.headImageURLArray count] delegate:self];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"交换名片"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    _changeCardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kFBaseWidth, kUIsIphone5?384:358) style:UITableViewStylePlain];
    _changeCardTableView.delegate       = self;
    _changeCardTableView.dataSource     = self;
    _changeCardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_changeCardTableView];
    [_changeCardTableView release];
    
    UIImage *changeButtonImage = [UIImage imageNamed:@"sheet_button.png"];
    changeButtonImage          = [changeButtonImage stretchableImageWithLeftCapWidth:5 topCapHeight:8];
    
    UIButton *changeCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCardButton.frame     = CGRectMake(20, kUIsIphone5?488:432, 280, 38);
    [changeCardButton setTitle:@"交换名片" forState:UIControlStateNormal];
    [changeCardButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [changeCardButton setBackgroundImage:changeButtonImage forState:UIControlStateNormal];
    [changeCardButton addTarget:self action:@selector(changeCardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeCardButton];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark- Custom event methods

-(void)changeCardButtonClicked:(id)sender
{
    NSString *session_id = [Global shareGlobal].session_id;
    
    //--从点击的表单中获得用户的uid值,注意需要修改
//    NSInteger uid = 20;
    
    if (_doExchangeRequest == nil) {
        _doExchangeRequest = [[DoExchangeRequest alloc] init];
        _doExchangeRequest.delegate = self;
    }
    
    [_doExchangeRequest sendDoExchangeRequestWithSessionid:session_id Uid:self.selectedUserID];
}

-(UIImage *)editHeadImageFromDownLoadImage:(UIImage *)downImage
{
    CGFloat imageWidth  = downImage.size.width;
    CGFloat imageHeight = downImage.size.height;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect imageRect    = CGRectMake(0, cutFloat/2, imageWidth, imageWidth);
    CGImageRef imageRef = downImage.CGImage;
    CGImageRef imageSubRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.height = 68.0f;
    size.width  = 68.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, imageSubRef);
    UIImage *image = [UIImage imageWithCGImage:imageSubRef];
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark- DoExchangeRequest delegate methods

-(void)DoExchangeRequestDidFinished:(DoExchangeRequest *)doExchangeRequest doExchangeResponse:(StatusResponse *)doExchangeResponse
{
    if (doExchangeResponse.status == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:doExchangeResponse.msg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else if (doExchangeResponse.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:doExchangeResponse.msg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)DoExchangeRequestDidFailed:(DoExchangeRequest *)doExchagneRequest error:(NSError *)error
{
    NSLog(@"DoExchangeRequestDidFailed:%@",error);
}

#pragma mark- TableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    ChangeCardUserCell *cell = (ChangeCardUserCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[ChangeCardUserCell alloc] init] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell cleanComponents];
    
    if ([_userArray count] > indexPath.row) {
        CardListData *userData = [_userArray objectAtIndex:indexPath.row];
        [cell setUserInfo:userData indexPath:indexPath];
        NSString *headImageURL = userData.avatar;
        UIImage *image = [_headImageDic objectForKey:headImageURL];
        if (image) {
            UIImage *headImage = [self editHeadImageFromDownLoadImage:image];
            [cell setUserHeadImage:headImage];
        }else{
            [_imageDownLoadQueue addImageURL:headImageURL];
        }
    }
    
    CGFloat duration;
    duration = (indexPath.row +1)*0.3;
    [Animation moveLeftAnimation:cell.view animationDuration:duration wait:YES moveLength:320.0];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *selectCell=[tableView cellForRowAtIndexPath:indexPath];
    if (selectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        selectCell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        selectCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    self.selectedUserID = [[NSString alloc] init];
    for (NSInteger i = 0; i < indexPath.row; i++) {
        
        if (selectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            CardListData *cardListData  = [_userArray objectAtIndex:indexPath.row];
            NSString *uidString = [NSString stringWithFormat:@"%i", cardListData.uid];
            uidString = [uidString stringByAppendingFormat:@",%@", uidString];
            self.selectedUserID = uidString;
        }
    }
}

#pragma mark - ImageDownLoadQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_headImageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_changeCardTableView visibleCells];
    [_changeCardTableView reloadData];
}

-(void)downLoadImageFailed:(NSString *)imageURL error:(NSError *)error
{
    NSLog(@"图片队列下载失败:%@",error);
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
    [_headImageDic release];
    [_headImageURLArray release];
    [_imageDownLoadQueue release];
    self.headImageURLArray = nil;
    self.userArray = nil;
    [super dealloc];
}

@end
