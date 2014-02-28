//
//  DetialPublishMessageViewController.m
//  certne
//
//  Created by apple on 13-9-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DetialPublishMessageViewController.h"
#import "Foundation.h"

@implementation DetialPublishMessageViewController
@synthesize publicInfo    = _publicInfo;
@synthesize messageLabel  = _messageLabel;
@synthesize messageHeight = _messageHeight;

#pragma mark- View lifeStyle methods

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
    [_navBarView settitleLabelText:@"商机详情"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    [self getImageFromDownLoader];
    _productImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _productImageButton.frame = CGRectMake(0, 62, 300, 275);
    [_productImageButton addTarget:self action:@selector(enlargeImage:) forControlEvents:UIControlEventTouchUpInside];
    
    _headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headImageButton.frame = CGRectMake(10, 10, 42, 42);
    [_headImageButton addTarget:self action:@selector(headImageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 42, 42)];
    coverImageView.image = [UIImage imageNamed:@"headImage_cover.png"];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 10, 200, 20)];
    _userNameLabel.textAlignment   = NSTextAlignmentLeft;
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.textColor       = [UIColor blackColor];
    _userNameLabel.font = [UIFont fontWithName:FONTNAME size:16];
    _userNameLabel.text = self.publicInfo.name;
    
    _userCopanyLabel=[[UILabel alloc] initWithFrame:CGRectMake(62, 32, 200, 20)];
    _userCopanyLabel.textAlignment   = NSTextAlignmentLeft;
    _userCopanyLabel.backgroundColor = [UIColor clearColor];
    _userCopanyLabel.textColor       = [UIColor blackColor];
    _userCopanyLabel.font = [UIFont fontWithName:FONTNAME size:12];
    _userCopanyLabel.text = self.publicInfo.company;
    
    NSString *headViewBgImagePath = [[NSBundle mainBundle] pathForResource:@"cover_product" ofType:@"png"];
    UIImageView *headViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62, 300, 275)];
    headViewBg.image = [UIImage imageWithContentsOfFile:headViewBgImagePath];
    
    NSString  *cornerImagePath=[[NSBundle mainBundle] pathForResource:@"right_up_corner" ofType:@"png"];
    UIImageView *cornerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(280, 0, 20, 20)];
    cornerImageView.image=[UIImage imageWithContentsOfFile:cornerImagePath];
    
    _headView=[[UIView alloc] initWithFrame:CGRectMake(10, 74, 300, 337)];
    _headView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_productImageButton];
    [_headView addSubview:headViewBg];
    [_headView addSubview:cornerImageView];
    [_headView addSubview:_userNameLabel];
    [_headView addSubview:_userCopanyLabel];
    [_headView addSubview:_headImageButton];
    [_headView addSubview:coverImageView];
    [self.view addSubview:_headView];
    [_headView release];
    [_userNameLabel release];
    [_userCopanyLabel release];
    [coverImageView release];
    [headViewBg release];
    
    _messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, self.messageHeight)];
    _messageLabel.textAlignment = NSTextAlignmentLeft;
    _messageLabel.numberOfLines = 15;
    _messageLabel.lineBreakMode = UILineBreakModeCharacterWrap|UILineBreakModeTailTruncation;
    _messageLabel.font = [UIFont fontWithName:FONTNAME size:13];
    _messageLabel.text = self.publicInfo.desc;
    _messageLabel.backgroundColor=[UIColor clearColor];
            
    NSString *contentViewImagePath = [[NSBundle mainBundle] pathForResource:@"detail_contentViewBg" ofType:@"png"];
    UIImage *contentImage = [UIImage imageWithContentsOfFile:contentViewImagePath];
    UIImageView *contentViewBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 141)];
    contentViewBgImage.image = contentImage;
    
    NSString *date  = [NSString stringWithFormat:@"%@",self.publicInfo.addTime];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day   = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *hour  = [date substringWithRange:NSMakeRange(11, 2)];
    NSString *min   = [date substringWithRange:NSMakeRange(14, 2)];
    NSString *dateString = [NSString stringWithFormat:@"%@月 %@日 %@:%@",month,day,hour,min];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 122, 150, 20)];
    _dateLabel.text          = dateString;
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont fontWithName:FONTNAME size:13];
    _dateLabel.backgroundColor = [UIColor clearColor];
    
    _locationLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 122, 150, 20)];
    _locationLabel.text = self.publicInfo.publishAddress;
    _locationLabel.font = [UIFont fontWithName:FONTNAME size:13];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.backgroundColor = [UIColor clearColor];
    
    NSString    *dateImagePath=[[NSBundle mainBundle] pathForResource:@"date_bg" ofType:@"png"];
    UIImage     *dateImage=[UIImage imageWithContentsOfFile:dateImagePath];
    UIImageView *dateImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 117, 300, 30)];
    dateImageView.image = dateImage;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 411, 300, 147)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:contentViewBgImage];
    [_contentView addSubview:dateImageView];
    [_contentView addSubview:_dateLabel];
    [_contentView addSubview:_locationLabel];
    [_contentView addSubview:_messageLabel];
    [self.view addSubview:_contentView];
    [contentViewBgImage release];
    [dateImageView release];
    [_locationLabel release];
    [_contentView release];
    [_messageLabel release];
            
    self.view.backgroundColor = UIColorFromFloat(216, 215, 210);
}

#pragma mark- Custom event methods

-(void)headImageButtonClicked
{
}

-(void)getImageFromDownLoader
{
    _imageDownLoader = [[ImageDownLoader alloc] initWithURLString:self.publicInfo.img delegate:self];
    _headImageDownLoader = [[ImageDownLoader alloc] initWithURLString:self.publicInfo.avatar delegate:self];
}

-(void)createImage:(NSData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData];
    [NSThread detachNewThreadSelector:@selector(setProductImage:)
                             toTarget:self
                           withObject:image];
}

-(void)setProductImage:(UIImage *)image
{
    [_productImageButton setBackgroundImage:[self getImageFromOriginalImage:image] forState:UIControlStateNormal];
}

-(void)enlargeImage:(id)sender
{
    UIImage *image = [UIImage imageWithData:_imageData];
    _largeImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _largeImageButton.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_largeImageButton setBackgroundImage:image forState:UIControlStateNormal];
    [_largeImageButton addTarget:self action:@selector(fallBackToHomeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_largeImageButton];
}

-(void)fallBackToHomeView
{
    _largeImageButton.hidden = YES;
}

#pragma mark - ImageDownLoader delegate methods

-(void)downLoadFinish:(ImageDownLoader *)downLoader
{
    //--
}

-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
{
    if ([downLoader isEqual:_imageDownLoader]) {
        _imageData = [[NSData alloc] init];
        _imageData = downLoader.receivedData;
        
        [NSThread detachNewThreadSelector:@selector(createImage:)
                                 toTarget:self
                               withObject:downLoader.receivedData];
    }else if ([downLoader isEqual:_headImageDownLoader]){
        UIImage *image = [UIImage imageWithData:downLoader.receivedData];
        UIImage *headImage = [self getHeadImageFromDownLoadImage:image];
        [_headImageButton setBackgroundImage:headImage forState:UIControlStateNormal];
    }
}

-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
{
    NSLog(@"下载图片失败:%@",error);
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark- UIImage capture methods

-(UIImage *)getImageFromOriginalImage:(UIImage *)originalImage
{
    CGFloat imageWidth  = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect  myImageRect = CGRectMake(0, cutFloat/2, imageWidth, imageWidth*11/12);
    CGImageRef imageRef = originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    
    CGSize  size;
    size.width  = 300.0f;
    size.height = 275.0f;
    UIGraphicsBeginImageContext(size);
    
    CGContextRef    context=UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage *myImage=[UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return myImage;
}

-(UIImage *)getHeadImageFromDownLoadImage:(UIImage *)downLoadImage
{
    CGFloat imageWidth = downLoadImage.size.width;
    CGFloat imageHeight = downLoadImage.size.height;
    CGFloat cutFloat = imageHeight - imageWidth;
    CGRect imageRect = CGRectMake(0, cutFloat/2, imageWidth, imageWidth);
    CGImageRef imageRef = downLoadImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 42.0f;
    size.height = 42.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, imageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
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
    _userNameLabel.text = nil;
    _messageLabel.text  = nil;
    [super dealloc];
}

@end
