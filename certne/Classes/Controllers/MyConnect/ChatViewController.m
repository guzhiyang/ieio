//
//  ChatViewController.m
//  certne
//
//  Created by apple on 13-6-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//将时间加到   self.chatArray  

#import <QuartzCore/QuartzCore.h>
#import "ChatViewController.h"
#import "ChatCustomCell.h"
#import "ChatFaceView.h"
#import "Foundation.h"

#define TOOLBARTAG		200
#define TABLEVIEWTAG	300

#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"

@implementation ChatViewController
@synthesize headNavView    = _headNavView;
@synthesize fallbackButton = _fallbackButton;
@synthesize unFriendButton = _unFriendButton;
@synthesize nameLabel      = _nameLabel;
@synthesize phraseString   = _phraseString;
@synthesize messageString  = _messageString;

@synthesize faceButton    = _faceButton;
@synthesize downView      = _downView;
@synthesize chatTextField = _chatTextField;
@synthesize chatTableView = _chatTableView;
@synthesize sendButton    = _sendButton;

@synthesize chatArray      = _chatArray;
@synthesize titleString    = _titleString;
@synthesize udpSocket      = _udpSocket;
@synthesize addImageButton = _addImageButton;
@synthesize chatTimeString = _chatTimeString;

@synthesize chatFaceView = _chatFaceView;

@synthesize name      = _name;
@synthesize headImage = _headImage;

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
    
    _chatTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, 320, 449) style:UITableViewStylePlain];
    _chatTableView.delegate       = self;
    _chatTableView.dataSource     = self;
    _chatTableView.tag            = 300;
    _chatTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _chatTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bg.png"]];
    [self.view addSubview:_chatTableView];
    
    UIImageView *tempBackGroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 55)];
    [tempBackGroundImageView setBackgroundColor:[UIColor whiteColor]];
    tempBackGroundImageView.layer.shadowOffset  = CGSizeMake(0, 0);
    tempBackGroundImageView.layer.shadowOpacity = 0.5;
    tempBackGroundImageView.layer.shadowRadius  = 5.0;
    tempBackGroundImageView.layer.shadowColor   = [UIColor grayColor].CGColor;
    [self.view addSubview:tempBackGroundImageView];
    [tempBackGroundImageView release];

    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 16, 80, 24)];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setFont:[UIFont fontWithName:FONTNAME size:24]];
    [_nameLabel setTextColor:[UIColor darkGrayColor]];
    
    if ([_name length]>0) {
        _nameLabel.text=_name;
    }else{
        _nameLabel.text=@"张东友";
    }
    
    _fallbackButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_fallbackButton setFrame:CGRectMake(20, 13, 30, 30)];
    [_fallbackButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [_fallbackButton addTarget:self action:@selector(fallBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _unFriendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_unFriendButton setFrame:CGRectMake(270, 13, 30, 30)];
    [_unFriendButton setImage:[UIImage imageNamed:@"block_button.png"] forState:UIControlStateNormal];
    [_unFriendButton setImage:[UIImage imageNamed:@"block_button.png"] forState:UIControlStateHighlighted];
    [_unFriendButton addTarget:self action:@selector(unFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    _headNavView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 55)];
    [_headNavView addSubview:tempBackGroundImageView];
    [_headNavView addSubview:_nameLabel];
    [_headNavView addSubview:_fallbackButton];
    [_headNavView addSubview:_unFriendButton];
    [self.view addSubview:_headNavView];
    
    _addImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_addImageButton setFrame:CGRectMake(10, 7, 30, 30)];
    [_addImageButton setBackgroundColor:[UIColor clearColor]];
    [_addImageButton setBackgroundImage:[UIImage imageNamed:@"add_Image.png"] forState:UIControlStateNormal];
    [_addImageButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tempchatLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 7, 175, 30)];
    [tempchatLabel setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0]];
    tempchatLabel.layer.borderWidth=1.2;
    tempchatLabel.layer.cornerRadius=4.0;
    tempchatLabel.layer.borderColor=[UIColor colorWithRed:173/255.0f green:212/255.0f blue:212/255.0f alpha:1.0].CGColor;
    
    _chatTextField=[[UITextField alloc]initWithFrame:CGRectMake(48, 14, 170, 20)];
    [_chatTextField setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0]];
    [_chatTextField setTextAlignment:NSTextAlignmentLeft];
    _chatTextField.delegate=self;
    _chatTextField.returnKeyType=UIReturnKeyDone;
    [_chatTextField setFont:[UIFont fontWithName:FONTNAME size:16]];
    [_chatTextField setPlaceholder:@"Hi,你好..."];
    
    _faceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_faceButton setFrame:CGRectMake(225, 7, 30, 30)];
    [_faceButton setBackgroundColor:[UIColor clearColor]];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"add_faceImg.png"] forState:UIControlStateNormal];
    [_faceButton addTarget:self action:@selector(showPhraseInfo:) forControlEvents:UIControlEventTouchUpInside];

    UIImage  *sendButtonImage=[UIImage imageNamed:@"button_green.png"];
    sendButtonImage=[sendButtonImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    
    _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setFrame:CGRectMake(260, 7, 50, 30)];
    [_sendButton setBackgroundColor:[UIColor clearColor]];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:15]];
    [_sendButton setBackgroundImage:sendButtonImage forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendMessage_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *tempDownImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tempDownImageView setBackgroundColor:[UIColor whiteColor]];
    tempDownImageView.layer.shadowOffset=CGSizeMake(0, 0);
    tempDownImageView.layer.shadowOpacity=0.5;
    tempDownImageView.layer.cornerRadius=5.0;
    tempDownImageView.layer.shadowColor=[UIColor grayColor].CGColor;
    
    _downView=[[UIView alloc]initWithFrame:CGRectMake(0, 524, 320, 44)];
    _downView.tag=200;
    [_downView setBackgroundColor:[UIColor whiteColor]];
    [_downView addSubview:tempDownImageView];
    [_downView addSubview:_addImageButton];
    [_downView addSubview:_faceButton];
    [_downView addSubview:tempchatLabel];
    [_downView addSubview:_chatTextField];
    [_downView addSubview:_sendButton];
    [self.view addSubview:_downView];
    [tempDownImageView release];
    [tempchatLabel release];
    
   	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.chatArray = tempArray;
	[tempArray release];
	
    NSMutableString *tempStr = [[NSMutableString alloc] initWithFormat:@""];
    self.messageString = tempStr;
    [tempStr release];
        
    //监听键盘高度的变换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    
    self.view.backgroundColor=[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
}

#pragma mark- custom event methods

-(void)fallBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)unFriend:(id)sender
{
    UIAlertView  *unFriendAlertView=[[UIAlertView alloc]initWithTitle:@"拉入黑名单" message:@"屏蔽此人消息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
    [unFriendAlertView show];
    [unFriendAlertView release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self openUDPServer];
    [self.chatTextField setText:self.messageString];//不加这个 点击的时候会再前面加一个(null)
    [self.chatTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.udpSocket close];//欧耶 bug 解除
}

-(void)addImage:(id)sender
{
    UIActionSheet *chooseImageActionsheet=[[UIActionSheet alloc] initWithTitle:@"拍摄图片"
                                                                      delegate:self
                                                             cancelButtonTitle:@"取消"
                                                        destructiveButtonTitle:nil
                                                             otherButtonTitles:@"使用相机拍照",@"从相册中选取", nil];
    chooseImageActionsheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    [chooseImageActionsheet showInView:self.view];
    [chooseImageActionsheet release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController=[[UIImagePickerController alloc]init];
            pickerController.delegate=self;
            if ([pickerController respondsToSelector:@selector(setAllowsEditing:)]) {
                pickerController.allowsEditing=YES;
            }
            pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerController animated:YES];
        }else{
            UIAlertView *cameraNotAlertView=[[UIAlertView alloc]initWithTitle:@"相机不可以在虚拟机上使用"
                                                                      message:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"好的"
                                                            otherButtonTitles:nil];
            [cameraNotAlertView show];
            [cameraNotAlertView release];
        }
    }else if (buttonIndex==1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *pickerController=[[UIImagePickerController alloc]init];
            pickerController.delegate=self;
            if ([pickerController respondsToSelector:@selector(setAllowsEditing:)]) {
                pickerController.allowsEditing=YES;
            }
            pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:pickerController animated:YES];
        }else{
            UIAlertView *photoFileAlertView=[[UIAlertView alloc]initWithTitle:@"相册打不开啊"
                                                                      message:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"haode"
                                                            otherButtonTitles:nil];
            [photoFileAlertView show];
            [photoFileAlertView release];
        }
    }else{
        [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
    }
}

#pragma mark- UIImagePickerController delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image==nil || picker==nil || info==nil) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil
                                                         message:NSLocalizedString(@"拍照不成功，请稍后再试！", nil)
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"好的", nil)
                                               otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else{
        //--上传image值
    }
    
    [picker dismissModalViewControllerAnimated:YES];
    picker.delegate=nil;
    [picker release];
    picker=nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    picker.delegate=nil;
    [picker release];
    picker=nil;
}

#pragma mark- View rotation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [_chatTableView reloadData];
    [_chatTableView setNeedsLayout];
}

#pragma mark- Udp Socket 建立基于UDP的Socket连接

-(void)openUDPServer
{
    AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
	self.udpSocket=tempSocket;
	[tempSocket release];
	//绑定端口
	NSError *error = nil;
	[self.udpSocket bindToPort:4333 error:&error];
    [self.udpSocket joinMulticastGroup:@"224.0.0.1" error:&error];
    
   	//启动接收线程
	[self.udpSocket receiveWithTimeout:-1 tag:0];
}

#pragma mark-Send Message 发送消息

-(void)sendMessage_Click:(id)sender
{
//    NSString *messageStr = self.chatTextField.text;
//    [self.messageString setString:self.chatTextField.text];
//    
//    if (messageStr == nil)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败！" message:@"发送的内容不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
//    }else
//    {
//        [self sendMassage:messageStr];
//    }
//	self.chatTextField.text = @"";
//    [self.messageString setString:self.chatTextField.text];
//    _downView.frame=CGRectMake(0, 524, 320, 44);
//	[_chatTextField resignFirstResponder];
//    [_chatFaceView removeFromSuperview];//移除表情视图
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"聊天功能暂时未开放，敬请谅解！"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"好的", nil];
    [alertView show];
    [alertView release];
}

#pragma mark- Send Message by Udp 通过UDP,发送消息

-(void)sendMassage:(NSString *)message
{    
	NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
	[sendString appendString:message];
	//开始发送
	BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
								 toHost:@"224.0.0.1"
								   port:4333
							withTimeout:-1
                                    tag:0];
    if (!res) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"内容不能为空"
														message:@"发送失败"
													   delegate:self
											  cancelButtonTitle:@"好的"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
        return;
	}
        
    // 发送后生成泡泡显示出来
    UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@",message] from:YES];
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:message, @"text", @"self", @"speaker", chatView, @"view", nil]];
	
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0]
							  atScrollPosition: UITableViewScrollPositionBottom
									  animated:YES];
}

#pragma mark- select chatface 选择系统表情

-(void)showPhraseInfo:(id)sender
{
    [self.chatTextField resignFirstResponder];//输入框也跟着下去了
    _downView=(UIView *)[self.view viewWithTag:TOOLBARTAG];
	_downView.frame = CGRectMake(0.0f, (float)(568.0-216.0-44.0), 320.0f, 44.0f);
    _chatFaceView=[[ChatFaceView alloc]initWithFrame:CGRectMake(0, 352, 320, 216)];
    _chatFaceView.delegate=self;
    [self.view addSubview:_chatFaceView];
    self.messageString =[NSMutableString stringWithFormat:@"%@",self.chatTextField.text];
}

-(void)sendTextToChatViewController:(id)sender
{
    self.phraseString=self.chatFaceView.faceString;
    [self.messageString appendString:self.phraseString];
    [self.chatTextField setText:self.messageString];
}

#pragma mark- creat paopao 生成泡泡UIView  这里可不单单是气泡 是聊天表单里面的所有子视图

-(UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf
{
    UIView *returnView =  [self assembleMessageAtIndex:text from:fromSelf];
    returnView.backgroundColor = [UIColor clearColor];//换行时候会显示背景色
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"chat_voice_bubble_r":@"chat_voice_bubble" ofType:@"png"]];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:18 topCapHeight:6]];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    UIImageView *myHeadImageView=[[UIImageView alloc]init];
    
    if(fromSelf){
        [myHeadImageView setImage:[UIImage imageNamed:@"liudehua.png"]];
        returnView.frame= CGRectMake(-3.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
        bubbleImageView.frame = CGRectMake(-12.0f, 6.0f, returnView.frame.size.width+28.0f, returnView.frame.size.height+48.0f );
        cellView.frame = CGRectMake(265.0f-bubbleImageView.frame.size.width, 0.0f,bubbleImageView.frame.size.width+50.0f, bubbleImageView.frame.size.height+30.0f);
        myHeadImageView.frame = CGRectMake(bubbleImageView.frame.size.width-5.0f, cellView.frame.size.height-60.0f, 50.0f, 50.0f);
        headImageView.hidden=YES;
    }
	else{
        if (!_headImage) {
            [headImageView setImage:[UIImage imageNamed:@"linzhiying.png"]];
        }
        else{
            [headImageView setImage:_headImage];
        }
        returnView.frame= CGRectMake(80.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height);
        bubbleImageView.frame = CGRectMake(65.0f, 6.0f, returnView.frame.size.width+28.0f, returnView.frame.size.height+48.0f);
		cellView.frame = CGRectMake(0.0f, 0.0f, bubbleImageView.frame.size.width+30.0f,bubbleImageView.frame.size.height+30.0f);
        headImageView.frame = CGRectMake(10.0f, cellView.frame.size.height-60.0f, 50.0f, 50.0f);
        myHeadImageView.hidden=YES;
    }
    
    [cellView addSubview:bubbleImageView];
    [cellView addSubview:myHeadImageView];
    [cellView addSubview:headImageView];
    [cellView addSubview:returnView];
    [bubbleImageView release];
    [myHeadImageView release];
    [headImageView release];
	return [cellView autorelease];
}

#pragma mark-Udp Delegate methods

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    [self.udpSocket receiveWithTimeout:-1 tag:0];
   	//接收到数据回调，用泡泡VIEW显示出来
	NSString *info=[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];
	
    UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@", info] from:NO];//调用上面的函数生成子视图
    
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:info, @"text", @"other", @"speaker", chatView, @"view", nil]];
	
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0]
							  atScrollPosition: UITableViewScrollPositionBottom
									  animated:YES];
	//已经处理完毕
	return YES;
}

-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    //无法发送时,返回的异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    //无法接收时，返回异常提示信息
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:[error description]
												   delegate:self
										  cancelButtonTitle:@"取消"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark- TableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *chatView = [[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
    return chatView.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CommentCellIdentifier = @"CommentCell";
	ChatCustomCell *cell = (ChatCustomCell *)[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
	if (!cell) {
        cell=[[[ChatCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellIdentifier] autorelease];
	}
    else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
    UIView *chatView = [chatInfo objectForKey:@"view"];
    chatView.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:chatView];
    return cell;
}

#pragma mark- tableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.chatTextField resignFirstResponder];
}

#pragma mark- Textfield Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.chatTextField)
    {
//        [self moveViewUp];//开始编辑聊天内容时，
    }
}

#pragma mark- Responding to keyboard events

-(void) autoMovekeyBoard: (float) h
{
    _downView=(UIView *)[self.view viewWithTag:TOOLBARTAG];
	_downView.frame = CGRectMake(0.0f, (float)(568.0-h-44.0), 320.0f, 44.0f);
}

- (void)keyboardWillShow:(NSNotification *)notification
{    
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self autoMovekeyBoard:keyboardRect.size.height];
}


- (void)keyboardWillHide:(NSNotification *)notification
{    
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self autoMovekeyBoard:0];
}

#pragma mark- Message with picture & string 图文混排

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除空格
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
    } else if (message != nil) {
        [array addObject:message];
    }
}

#define KFacialSizeWidth  30
#define KFacialSizeHeight 30
#define MAX_WIDTH 150
-(UIView *)assembleMessageAtIndex : (NSString *) message from:(BOOL)fromself
{
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:18.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = 150;
                    Y = upY;
                }
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                [img release];
                upX=KFacialSizeWidth+upX;
                if (X<150) X = upX;
            }
            else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MAX_WIDTH)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = 150;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(150, 40)];
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY+6,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:la];
                    [la release];
                    upX=upX+size.width;
                    if (X<150) {
                        X = upX;
                    }
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    return [returnView autorelease];
}

-(void)deleteContentFromTableView
{
    //删除聊天记录，未实现
}

#pragma mark-Memory management methods

-(void)viewDidUnload
{
    _chatArray      = nil;
    _chatTextField  = nil;
    _udpSocket      = nil;
    _phraseString   = nil;
    _messageString  = nil;
    _titleString    = nil;
    _chatTimeString = nil;
    _headImage      = nil;
    _name           = nil;
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
    [_nameLabel release];
    [_headNavView release];
    [_chatTextField release];
    [_chatTableView release];
    [_downView release];
    [_chatFaceView release];
    
    [super dealloc];
}

@end
