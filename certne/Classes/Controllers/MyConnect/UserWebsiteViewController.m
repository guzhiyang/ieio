//
//  UserWebsiteViewController.m
//  certne
//
//  Created by apple on 13-6-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UserWebsiteViewController.h"
#import "Foundation.h"

@implementation UserWebsiteViewController
@synthesize websiteString;
@synthesize title;

#pragma mark-view lifeCycle methods

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
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    if ([title length] > 0) {
        [_navBarView settitleLabelText:title];
    }else{
        [_navBarView settitleLabelText:@"公司网址"];
    }
    [self.view addSubview:_navBarView];
    
    userWebsiteView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, kUIsIphone5?460:372)];
    userWebsiteView.scalesPageToFit=YES;
    userWebsiteView.delegate=self;
    if ([websiteString length]>0) {
        NSURL *url =[NSURL URLWithString:websiteString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [userWebsiteView loadRequest:request];
    }else{
        NSString *urlString = @"http://www.certne.com";
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [userWebsiteView loadRequest:request];
    }
    [self.view addSubview:userWebsiteView];
    
    _toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, kUIsIphone5?524:436, 320, 44)];
    _toolBar.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:_toolBar];
    
    UIButton *goback=[UIButton buttonWithType:UIButtonTypeCustom];
    [goback setFrame:CGRectMake(20, 10, 15, 20)];
    [goback setBackgroundImage:[UIImage imageNamed:@"backWhite.png"] forState:UIControlStateNormal];
    [goback addTarget:self action:@selector(goBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _goBackButton=[[UIBarButtonItem alloc]initWithCustomView:goback];

    UIButton *gofroward=[UIButton buttonWithType:UIButtonTypeCustom];
    [gofroward setFrame:CGRectMake(110, 10, 15, 20)];
    [gofroward setBackgroundImage:[UIImage imageNamed:@"forwardWhite.png"] forState:UIControlStateNormal];
    [gofroward addTarget:self action:@selector(goForwardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _goForwardButton=[[UIBarButtonItem alloc]initWithCustomView:gofroward];
    
    _refleshButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                target:self
                                                                action:@selector(refreshButtonClicked:)];
    
    UIBarButtonItem *fixSpaceButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpaceButton.width=60;
    
    UIBarButtonItem *flexibleButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [_toolBar setItems:[NSArray arrayWithObjects:_goBackButton,fixSpaceButton,_goForwardButton,flexibleButton,_refleshButton, nil]];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]//旋转进度轮
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicatorView setCenter:self.view.center];
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicatorView];
    
    self.view.backgroundColor = UIColorFromFloat(242, 242, 242);
}

#pragma mark- custom event methods

-(void)goBackButtonClicked:(id)sender
{
    if ([userWebsiteView canGoBack]) {
        [userWebsiteView goBack];
    }
}

-(void)goForwardButtonClicked:(id)sender
{
    if ([userWebsiteView canGoForward]) {
        [userWebsiteView goForward];
    }
}

-(void)refreshButtonClicked:(id)sender
{
    [userWebsiteView reload];
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark-webView delegate methods

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if ([[request.URL absoluteString]isEqualToString:@"http://www.baidu.com"]) {
//        return NO;//--屏蔽百度
//    }
    return  YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
    if ([userWebsiteView canGoBack]) {
        _goBackButton.enabled = YES;
    }else{
        _goBackButton.enabled = NO;
    }
    
    if ([userWebsiteView canGoForward]) {
        _goForwardButton.enabled = YES;
    }else{
        _goForwardButton.enabled = NO;
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"网址载入错误"
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"好的"
                                           otherButtonTitles:nil];
    [alertView show];
}

#pragma  mark- memory management methods

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)dealloc
{
    title         = nil;
    websiteString = nil;
}
@end
