//
//  NearbyFriendNextViewController.m
//  certne
//
//  Created by apple on 13-6-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NearbyFriendNextViewController.h"
#import "Foundation.h"
#import "Global.h"

@implementation NearbyFriendNextViewController
@synthesize user          = _user;
@synthesize headImageView = _headImageView;
@synthesize nameLabel     = _nameLabel;
@synthesize positionLabel = _positionLabel;
@synthesize chatTextfield = _chatTextfield;
@synthesize headImageURL  = _headImageURL;
@synthesize activityView  = _activityView;

#pragma mark- View lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isLoading = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    UIButton *fallBackButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [fallBackButton setFrame:CGRectMake(270, 40, 30, 30)];
    [fallBackButton setBackgroundImage:[UIImage imageNamed:@"close_green.png"] forState:UIControlStateNormal];
    [fallBackButton addTarget:self action:@selector(fallback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fallBackButton];
    
    _headImageDownLoader = [[[ImageDownLoader alloc] initWithURLString:self.headImageURL delegate:self] autorelease];
    
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(65, 75, 190, 190)];
    [self.view addSubview:_headImageView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 160, 20, 20)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [_activityView startAnimating];
    [self.view addSubview:_activityView];
    [_activityView release];
    
    UIImageView *headImageBg=[[UIImageView alloc]initWithFrame:CGRectMake(65, 75, 190, 190)];
    [headImageBg setImage:[UIImage imageNamed:@"headImage_big_circle.png"]];
    [self.view addSubview:headImageBg];
    [headImageBg release];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 285, 120, 24)];
    _nameLabel.text = self.user.name;
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_nameLabel];
        
    _positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 310, 160, 20)];
    _positionLabel.text = self.user.position;
    [_positionLabel setTextAlignment:NSTextAlignmentCenter];
    [_positionLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_positionLabel setTextColor:[UIColor darkGrayColor]];
    [_positionLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_positionLabel];
    
    _companyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 351, 240, 20)];
    _companyNameLabel.text=self.user.company;
    [_companyNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_companyNameLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_companyNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_companyNameLabel];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 331, 240, 20)];
    _addressLabel.text = [NSString stringWithFormat:@"%i米", self.user.distance];
    [_addressLabel setTextAlignment:NSTextAlignmentCenter];
    [_addressLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_addressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_addressLabel];
    
    _chatTextfield=[[MarginTextField alloc] initWithFrame:CGRectMake(20,kUIsIphone5?420:380, 280, 30)];
    _chatTextfield.placeholder   = @"Hi,你好啊~";
    _chatTextfield.delegate      = self;
    _chatTextfield.returnKeyType = UIReturnKeyDone;
    _chatTextfield.layer.borderColor = UIColorFromFloat(55, 171, 170).CGColor;
    _chatTextfield.layer.borderWidth  = 1.0f;
    _chatTextfield.layer.cornerRadius = 4.0f;
    _chatTextfield.dx = 5.0f;
    _chatTextfield.dy = 5.0f;
    _chatTextfield.font = [UIFont fontWithName:FONTNAME size:15];
    _chatTextfield.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chatTextfield];
    [_chatTextfield release];
    
    UIImage *chatImage = [UIImage imageNamed:@"sheet_button.png"];
    UIImage *stretchChatImage = [chatImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
        
    chatButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton setFrame:CGRectMake(20,kUIsIphone5?465:420, 280, 40)];
    [chatButton setTitle:@"打招呼" forState:UIControlStateNormal];
    [chatButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:15]];
    [chatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chatButton setBackgroundImage:stretchChatImage forState:UIControlStateNormal];
    [chatButton addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark- Custom event methods

-(void)fallback:(id)sender
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)chat:(id)sender
{
    //--发送打招呼消息
    NSString *chatMessage = _chatTextfield.text;
    [_chatTextfield resignFirstResponder];
        
    if ([chatMessage length] == 0) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"消息不能为空"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"好的", nil];
        [alertView show];
        [alertView release];
    }else{
        if (_sayHelloResponseRequest == nil) {
            _sayHelloResponseRequest = [[SayHelloResponseRequest alloc] init];
            _sayHelloResponseRequest.delegate = self;
        }
        
        [_sayHelloResponseRequest sendSayHelloResponseRequestWithMobile:[Global shareGlobal].currentUser.mobile session_id:[Global shareGlobal].session_id auid:self.user.uid message:chatMessage];
    }
}

-(UIImage *)editHeadImage:(UIImage *)downLoadImage
{
    CGFloat cutFloat = downLoadImage.size.height - downLoadImage.size.width;
    CGRect imageRect = CGRectMake(0, cutFloat/2, downLoadImage.size.width, downLoadImage.size.width);
    CGImageRef imageRef = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 300.0f;
    size.height = 300.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - URLConnection delegate methods

-(void)SayHelloResponseRequestDidFinished:(SayHelloResponseRequest *)sayhelloResponseRequest sayhelloResponse:(StatusResponse *)sayHelloResponse
{
    if (sayHelloResponse.status == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送成功!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)SayHelloResponseRequestDidFailed:(SayHelloResponseRequest *)sayhelloResponseRequest error:(NSError *)error
{
    NSLog(@"SayHelloResponseRequestDidFailed:%@",error);
}

#pragma mark - ImageDownLoader delegate methods

-(void)downLoadFinish:(ImageDownLoader *)downLoader
{
    _isLoading = NO;
    [_activityView stopAnimating];
    UIImage *downImage = [UIImage imageWithData:downLoader.receivedData];
    UIImage *image = [self editHeadImage:downImage];
    _headImageView.image = image;
}

-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
{
}

-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
{
    _isLoading = NO;
    [_activityView stopAnimating];
    NSLog(@"下载图片失败:%@",error);
}

#pragma mark - Textfield delegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] > 25 || [string isEqualToString:@"abc"]) {
        return NO;
    }else
        return YES;
}

-(void)textFieldAnimate:(UITextField *)textField up:(BOOL)up
{
    const CGFloat movement     = 155.0f;
    const CGFloat moveDuration = 0.2f;
    CGFloat moveDistance = (up?-movement:movement);
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:moveDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, moveDistance);
    [UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self textFieldAnimate:textField up:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldAnimate:textField up:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- memory Management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_headImageView release];
    [_nameLabel release];
    [_positionLabel release];
    [_companyNameLabel release];
    [_addressLabel release];
    [super dealloc];
}

@end
