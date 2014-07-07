//
//  GetNearbyUserListRequest.m
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetNearbyUserListRequest.h"
#import "Foundation.h"
#import "certneCardAppDelegate.h"

@implementation GetNearbyUserListRequest
@synthesize delegate     = _delegate;
@synthesize receivedData = _receivedData;
@synthesize activity_hidden;
@synthesize background_hidden;

-(id)init
{
    self = [super init];
    
    if (self) {
        _loadingView = [[TKLoadingView alloc] initWithTitle:@"加载中..."];
        _loadingView.center = CGPointMake(kFBaseWidth/2, kFBaseHeight/2);
        [_loadingView startAnimating];
        
        _window = certneCardApp.window;
        _backgroundView = [[UIView alloc] initWithFrame:_window.frame];
        _backgroundView.backgroundColor = [UIColor clearColor];
        [_backgroundView addSubview:_loadingView];
        [_backgroundView setHidden:YES];
        [_window addSubview:_backgroundView];
        
        activity_hidden = NO;
        background_hidden = NO;
        
        _lock = [[NSLock alloc] init];
    }
    
    return self;
}

static GetNearbyUserListRequest *getNearbyUserListRequest = nil;

+(GetNearbyUserListRequest *)shareRequest
{
    @synchronized(self){
        if (getNearbyUserListRequest == nil) {
            getNearbyUserListRequest = [[GetNearbyUserListRequest alloc] init];
        }
    }
    return getNearbyUserListRequest;
}

-(void)startAnimate
{
    [_lock lock];
    
    _loadingView.hidden = NO;
    activity_hidden     = NO;
    background_hidden   = NO;
    [_backgroundView setHidden:background_hidden];
    
    [_lock unlock];
}

-(void)stopAnimate
{
    [_lock lock];
    
    _loadingView.hidden = YES;
    activity_hidden     = YES;
    background_hidden   = YES;
    [_backgroundView setHidden:background_hidden];
    
    [_lock unlock];
}

-(void)sendGetNearbyUserListRequestWithSessionid:(NSString *)sessionid longitude:(CGFloat)longitude latitude:(CGFloat)latitude
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&longitude=%f&latitude=%f",sessionid,longitude,latitude];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Around/getUserList",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    [self startAnimate];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                     delegate:self
                                             startImmediately:TIMEOUTINTERAL];
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        _URLConnection = nil;
    }
}

#pragma mark - URLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"附近好友:%@",receivedString);
    
    [self stopAnimate];
    
    NearbyUserListParser *parser = [[NearbyUserListParser alloc] init];
    id parserObject = [parser NearbyUserListParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NearbyUserList class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFinished:nearbyUserList:)]) {
            NearbyUserList *nearbyUserList = (NearbyUserList *)parserObject;
            [_delegate GetNearbyUserListRequestDidFinished:self nearbyUserList:nearbyUserList];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFailed:error:)]) {
            [_delegate GetNearbyUserListRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self stopAnimate];
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFailed:error:)]) {
        [_delegate GetNearbyUserListRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
}

@end
