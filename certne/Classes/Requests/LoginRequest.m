//
//  LoginRequest.m
//  certne
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginRequest.h"
#import "LoginUserInfoParser.h"
#import "Foundation.h"
#import "certneCardAppDelegate.h"

@implementation LoginRequest
@synthesize loadingView;
@synthesize backgroundView;
@synthesize background_hidden;
@synthesize activity_hidden;
@synthesize request_cancle;
@synthesize receivedData;

-(id)init
{
    self = [super init];
    if (self) {
        loadingView = [[TKLoadingView alloc] initWithTitle:@"加载..."];
        loadingView.center = CGPointMake(kFBaseWidth/2, kFBaseHeight/2);
        [loadingView startAnimating];
        
        _window = certneCardApp.window;
        backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        [_window addSubview:backgroundView];
        [backgroundView setHidden:YES];
        [backgroundView addSubview:loadingView];
        
        activity_hidden   = NO;
        background_hidden = NO;
        request_cancle    = NO;
        
        _lock = [[NSLock alloc] init];
    }
    
    return self;
}

static LoginRequest *shareRequest = nil;

+(LoginRequest *)shareRequest
{
	@synchronized(self){
        if (shareRequest == nil) {
            shareRequest = [[LoginRequest alloc] init];
        }
    }
    return shareRequest;
}

-(void)startAnimate
{
    [_lock lock];
    
//    if (activity_hidden) {
//        loadingView.hidden = YES;
//        background_hidden = YES;
//    }else{
        loadingView.hidden = NO;
        background_hidden  = NO;
        [loadingView startAnimating];
//    }
    [backgroundView setHidden:background_hidden];
    
    [_lock unlock];
}

-(void)stopAnimate
{
    [_lock lock];
    
    activity_hidden    = YES;
    loadingView.hidden = YES;
    background_hidden  = YES;
    [loadingView stopAnimating];
    [backgroundView setHidden:background_hidden];
    
    [_lock unlock];
}

-(void)sendLoginRequestWithUseMobile:(NSString *)mobile password:(NSString *)password
{
    [self cancle];
    
    NSString *URLString = [NSString stringWithFormat:@"%@User/login", ALIYUNURL];
    NSString *post = [NSString stringWithFormat:@"mobile=%@&password=%@",mobile,password];
    NSData  *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *encodeURLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    [URLRequest setHTTPBody:postData];
    [self startAnimate];
    
    _URLConnection=[[NSURLConnection alloc]initWithRequest:URLRequest
                                                  delegate:self
                                          startImmediately:YES];
}

/**
 *	@brief	检测请求返回状态 //--2.0 ~ 4.3 已经弃用的方法
 *
 *	@param 	connection
 *	@param 	response
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if (httpResponse.statusCode==200) {
        self.receivedData = [NSMutableData data];
    }else{
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"获取的数据:%@",receiveString);
    LoginUserInfoParser *parser=[[LoginUserInfoParser alloc] init];
    id parserObject=[parser loginUserInfoParserWithJSONData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]])
    {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFailed:error:)])
        {
            [_delegate loginRequestFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[LoginUserInfo class]])
    {
        [self stopAnimate];
        LoginUserInfo *loginUserInfo=(LoginUserInfo *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFinished:loginUserInfo:)]) {
            [_delegate loginRequestFinished:self loginUserInfo:loginUserInfo];
        }
    }
}

//--连接失败，执行代理
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
        [_delegate loginRequestFailed:self error:error];
        [self stopAnimate];
    }
}

//--释放连接
-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        _URLConnection=nil;
    }
}

-(void)dealloc
{
    receivedData = nil;
    loadingView  = nil;
    _lock        = nil;
    [self cancle];
}

@end
