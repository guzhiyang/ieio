//
//  DetailMessageViewController.m
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DetailMessageViewController.h"
#import "ConnectionsViewController.h"
#import "setMessageViewController.h"
#import "ChatViewController.h"
#import "UserWebsiteViewController.h"

@implementation DetailMessageViewController
@synthesize headImageView;
@synthesize backgroundView;
@synthesize bgImageView;

@synthesize nameLabel;
@synthesize positionLabel;
@synthesize companyLabel;

@synthesize closeButton;
@synthesize phoneButton;
@synthesize chatButton;
@synthesize testButton;
@synthesize cardButton;
@synthesize websiteButton;

@synthesize messageViewController=_messageViewController;
@synthesize chatViewController=_chatViewController;
@synthesize user=_user;

int a=0;

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
    
    headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
//    [headImageView setImage:[UIImage imageNamed:@"head_first.png"]];
    headImageView.image=[UIImage imageWithContentsOfFile:self.user.urlImagePath];
    [self.view addSubview:headImageView];
    
    closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"close_hlight.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton setFrame:CGRectMake(270, 40, 30, 30)];
    [closeButton addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 448, 320, 60)];
    [bgImageView setImage:[UIImage imageNamed:@"backgview.png"]];
//    [temptestImageView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:bgImageView];
    
    backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 508, 320, 60)];
//    [backgroundView setImage:[UIImage imageNamed:@"backgview.png"]];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backgroundView];
    
    phoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [phoneButton setFrame:CGRectMake(35, 523, 30, 30)];
    [phoneButton setImage:[UIImage imageNamed:@"icon_phoneCall.png"] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(phoneCall:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    chatButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton setFrame:CGRectMake(90, 523, 30, 30)];
    [chatButton setImage:[UIImage imageNamed:@"icon_chat.png"] forState:UIControlStateNormal];
    [chatButton addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatButton];
    
    testButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setFrame:CGRectMake(145, 523, 30, 30)];
    [testButton setImage:[UIImage imageNamed:@"icon_favourite.png"] forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(addAttention:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
    websiteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [websiteButton setFrame:CGRectMake(200, 523, 30, 30)];
    [websiteButton setImage:[UIImage imageNamed:@"icon_web.png"] forState:UIControlStateNormal];
    [websiteButton addTarget:self action:@selector(openWebsite:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:websiteButton];
    
    cardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [cardButton setFrame:CGRectMake(255, 523, 30, 30)];
    [cardButton setImage:[UIImage imageNamed:@"icon_infomation.png"] forState:UIControlStateNormal];
    [cardButton addTarget:self action:@selector(setMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardButton];
    
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)backToHome:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:NO];
}

-(void)phoneCall:(id)sender
{
    NSString  *number=@"+86 10086";
    NSString  *phoneNumber=[[NSString alloc]initWithFormat:@"tel://%@",number];//电话结束返回通讯录
//    NSString  *phoneNumber=[[NSString alloc]initWithFormat:@"telprompt://%@",number];//电话结束返回程序
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    [phoneNumber release];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://1017574338@qq.com"]];//发短信界面
}

-(void)chat:(id)sender
{
    _chatViewController=[[ChatViewController alloc]init];
    [self.navigationController pushViewController:_chatViewController animated:NO];
}

-(void)addAttention:(id)sender
{
    UIAlertView *attentionAlertView=[[UIAlertView alloc]initWithTitle:@"加关注" message:@"将名片添加到收藏夹" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
    [attentionAlertView show];
    [attentionAlertView release];
}

-(void)setMessage:(id)sender
{
    _messageViewController=[[setMessageViewController alloc]init];
    [self.navigationController pushViewController:_messageViewController animated:NO];
    [_messageViewController release];
}

-(void)openWebsite:(id)sender
{
    UserWebsiteViewController *userWebsiteViewController=[[UserWebsiteViewController alloc]init];
    userWebsiteViewController.websiteString=@"http://www.certne.com";
    [self.navigationController pushViewController:userWebsiteViewController animated:NO];
    [userWebsiteViewController release];
}

-(void)hiddenTheButton
{
    closeButton.hidden=YES;
    backgroundView.hidden=YES;
    bgImageView.hidden=YES;
    phoneButton.hidden=YES;
    chatButton.hidden=YES;
    testButton.hidden=YES;
    websiteButton.hidden=YES;
    cardButton.hidden=YES;
}

-(void)showTheButtonView
{
    closeButton.hidden=NO;
    backgroundView.hidden=NO;
    bgImageView.hidden=NO;
    phoneButton.hidden=NO;
    chatButton.hidden=NO;
    testButton.hidden=NO;
    websiteButton.hidden=NO;
    cardButton.hidden=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    a++;
    [self touch];
}

-(void)touch
{
    if (a==1) {
        [self hiddenTheButton];
    }
    else if (a%2==1 && (a>2))
    {
        [self hiddenTheButton];
    }
    else if((a%2==0) && (a>1))
    {
        [self showTheButtonView];
    }
}

#pragma mark- Memory management methods

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
    [bgImageView release];
    [headImageView release];
    [backgroundView release];
    [_chatViewController release];
    
    headImageView=nil;
    backgroundView=nil;
    
    [super dealloc];
}

@end
