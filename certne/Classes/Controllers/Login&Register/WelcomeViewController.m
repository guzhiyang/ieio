//
//  WelcomeViewController.m
//  certne
//
//  Created by apple on 13-9-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "certneCardAppDelegate.h"
#import "Foundation.h"

@implementation WelcomeViewController
@synthesize usageScrollView = _usageScrollView;
@synthesize pageControl     = _pageControl;

#pragma mark- View lifestyle methods

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
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    _usageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
    [self.view addSubview:_usageScrollView];
    [_usageScrollView release];
    
    _usageScrollView.contentSize=CGSizeMake(kFBaseWidth*3, kFBaseHeight);
    _usageScrollView.delegate = self;
    _usageScrollView.bounces  = NO;
    _usageScrollView.showsHorizontalScrollIndicator = NO;
    _usageScrollView.showsVerticalScrollIndicator   = NO;
    _usageScrollView.maximumZoomScale = 1.0;
    _usageScrollView.maximumZoomScale = 1.0;
    _usageScrollView.pagingEnabled    = YES;
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kFBaseWidth*3, 568)];
    [_usageScrollView addSubview:_contentView];
    [_contentView release];
    
    NSString *image1Path = [[NSBundle mainBundle] pathForResource:@"explain_first" ofType:@"png"];
    UIImage *image1 = [[UIImage alloc] initWithContentsOfFile:image1Path];
    NSString *image2Path = [[NSBundle mainBundle] pathForResource:@"explain_second" ofType:@"png"];
    UIImage *image2 = [[UIImage alloc] initWithContentsOfFile:image2Path];
    NSString *image3Path = [[NSBundle mainBundle] pathForResource:@"explain_last" ofType:@"png"];
    UIImage *image3 = [[UIImage alloc] initWithContentsOfFile:image3Path];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:image1,image2,image3, nil];
    [image1 release];
    [image2 release];
    [image3 release];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *guideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kFBaseWidth*i, 0, 320, kFBaseHeight)];
        guideImageView.image = [imageArray objectAtIndex:i];
        [_contentView addSubview:guideImageView];
        [guideImageView release];
    }
    [imageArray release];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120, kUIsIphone5?485:410, 80, 20)];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = UIColorFromFloat(165, 165, 165);
    _pageControl.currentPageIndicatorTintColor = UIColorFromFloat(65, 165, 165);
    [_pageControl addTarget:self action:@selector(pageControlClicked) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    [_pageControl release];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"button_green" ofType:@"png"];
    UIImage *btnImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIImage *streImage = [btnImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [btnImage release];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(50, kUIsIphone5?510:430, 100, 38);
    [loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:streImage forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
    [loginButton addTarget:self action:@selector(longin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(170, kUIsIphone5?510:430, 100, 38);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:streImage forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
    [registerButton addTarget:self action:@selector(registerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark- Custom event methods

-(void)pageControlClicked
{
    [_usageScrollView setContentOffset:CGPointMake(_pageControl.currentPage*kFBaseWidth, 0) animated:NO];
}

-(void)longin
{
    certneCardAppDelegate *appDelegate=(certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadLoginView];
}

-(void)registerView
{
    certneCardAppDelegate *appDelegate=(certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [appDelegate loadRegisterView];
}

#pragma mark- ScrollView delegate methods

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _contentView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _usageScrollView.contentOffset.x/kFBaseWidth;
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
    _contentView     = nil;
    _pageControl     = nil;
    _usageScrollView = nil;
    [super dealloc];
}

@end
