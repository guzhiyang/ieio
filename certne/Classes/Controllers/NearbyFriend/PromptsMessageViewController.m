//
//  PromptsMessageViewController.m
//  certne
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PromptsMessageViewController.h"
#import "Foundation.h"
#import <QuartzCore/QuartzCore.h>
#import "PushMessage.h"
#import "Global.h"

@implementation PromptsMessageViewController
@synthesize promptsMessageTableView = _promptsMessageTableView;
@synthesize messageArray            = _messageArray;

#pragma mark- View lifecycle methods

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
    
    [self getHeadImageURLArray];
//    _imageDownLoadQueue = [[ImageDownLoadQueue alloc] initWithConcurrent:[_headImageURLArray count] delegate:self];
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"打招呼信息"];
    [self.view addSubview:_navBarView];
    
    _promptsMessageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kFBaseWidth, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _promptsMessageTableView.delegate       = self;
    _promptsMessageTableView.dataSource     = self;
    _promptsMessageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_promptsMessageTableView];

    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(reloadTableViewData)
                                   userInfo:nil
                                    repeats:YES];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark - Custom event methods

-(void)getHeadImageURLArray
{
    _headImageURLArray = [NSMutableArray new];
    _headImageDic = [NSMutableDictionary new];
    
    for (NSInteger i = 0; i < [self.messageArray count]; i++) {
        PushMessage *pushMessage = [self.messageArray objectAtIndex:i];
        NSString *headImageURL = pushMessage.avatar;
        if ([headImageURL length] > 20) {
            [_headImageURLArray addObject:headImageURL];
        }
    }
}

-(void)reloadTableViewData
{
    if ([self.messageArray count] == 0) {
    }else{
        [_promptsMessageTableView visibleCells];
        [_promptsMessageTableView reloadData];
    }
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - ImageDownLoadQueue delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData
{
    [_headImageDic setObject:[UIImage imageWithData:imageData] forKey:imageURL];
    [_promptsMessageTableView visibleCells];
    [_promptsMessageTableView reloadData];
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

#pragma mark- UITableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    PromptsMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[PromptsMessageCell alloc]init];
        cell.delegate = self;
        cell.accessoryType  = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([self.messageArray count] > 0) {
        PushMessage *pushMessage = [self.messageArray objectAtIndex:indexPath.row];
        NSString *name = [pushMessage.message substringWithRange:NSMakeRange(0, 2)];
        NSArray *msg = [pushMessage.message componentsSeparatedByString:@":"];
        [cell setUserName:name];
        [cell setPromptsMessage:[msg lastObject]];
        [cell setTime:pushMessage.time];
        NSString *headImageURL = pushMessage.avatar;
        UIImage *image = [_headImageDic objectForKey:headImageURL];
        if (image) {
            [cell setUserHeadImage:image];
        }else{
//            [_imageDownLoadQueue addImageURL:headImageURL];
        }
    }
//    [cell setUserHeadImage:[UIImage imageNamed:@"linzhiying.png"]];
    [cell setAllMessage:nil indexPath:indexPath];
    
    return cell;
}

#pragma mark- UITableview delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewCell delegate methods

-(void)friendDetailInfoWithHeadImageButton:(HeadImageButton *)headImageButton
{
}

-(void)addFriendWithAddFriendButton:(HeadImageButton *)addFriendButton
{
    if (_agreeInviteRequest == nil) {
        _agreeInviteRequest = [[AgreeInviteRequest alloc] init];
        _agreeInviteRequest.delegate = self;
    }
    PushMessage *pushMessage = [_messageArray objectAtIndex:addFriendButton.cellRow];
    [_agreeInviteRequest sendAgreeInviteRequestWithSessionID:[Global shareGlobal].session_id fuid:pushMessage.uid];
}

#pragma mark - AgreeInvite delegate methods

-(void)agreeInviewRequestDidFinish:(AgreeInviteRequest *)agreeInviteRequest statusResponse:(StatusResponse *)statusResponse
{
    if (statusResponse.status == 1) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
        _tipView.backgroundColor = [UIColor blackColor];
        _tipView.alpha = 0.1;
        [self.view addSubview:_tipView];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 100, 40)];
        contentLabel.text          = @"已添加";
        contentLabel.textColor     = [UIColor whiteColor];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font          = [UIFont fontWithName:FONTNAME size:24];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(80, 244, 160, 80)];
        _contentView.layer.borderWidth  = 1.0f;
        _contentView.layer.cornerRadius = 4.0f;
        _contentView.layer.borderColor  = UIColorFromFloat(160, 160, 160).CGColor;
        _contentView.backgroundColor    = UIColorFromFloat(160, 160, 160);
        [_contentView addSubview:contentLabel];
        [self.view addSubview:_contentView];
        
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(dismissView)
                                       userInfo:nil
                                        repeats:NO];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有添加成功"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)agreeInviewRequestDidFailed:(AgreeInviteRequest *)agreeInviteRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)dismissView
{
    [_contentView removeFromSuperview];
    [_tipView removeFromSuperview];
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
}

@end
