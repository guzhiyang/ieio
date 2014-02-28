//
//  certneCardAppDelegate.m
//  certne
//
//  Created by apple on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "certneCardAppDelegate.h"
#import "SideBarViewController.h"
#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import "Global.h"
#import "PushMessage.h"

@implementation certneCardAppDelegate

#pragma mark- Memroy management methods

-(void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark- LoadingView and LoginView and MainView methods

-(void)loadingView
{
    self.loadingViewController = [[[LoadingViewController alloc]init] autorelease];
    self.window.rootViewController = self.loadingViewController;
}

-(void)loadWelcomeView
{
    WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc]init];
    self.window.rootViewController = welcomeViewController;
    [welcomeViewController release];
}

-(void)loadLoginView
{
    LoginViewController  *loginViewController = [[LoginViewController alloc]init];
    self.loginNavigationController = [[[UINavigationController alloc]initWithRootViewController:loginViewController] autorelease];
    self.loginNavigationController.navigationBar.hidden = YES;
    self.window.rootViewController = self.loginNavigationController;
    [loginViewController release];
}

-(void)loadRegisterView
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    UINavigationController *registerNavigationController = [[[UINavigationController alloc]initWithRootViewController:registerViewController] autorelease];
    registerNavigationController.navigationBarHidden = YES;
    self.window.rootViewController = registerNavigationController;
    [registerViewController release];
}

-(void)loadMainView
{
    SideBarViewController *sideBarViewController = [[SideBarViewController alloc] init];

    UINavigationController *sideBarNavigationController = [[UINavigationController alloc]initWithRootViewController:sideBarViewController];
    sideBarNavigationController.navigationBar.hidden = YES;
    self.window.rootViewController = sideBarNavigationController;
    [sideBarViewController release];
    [sideBarNavigationController release];
}

-(void)loadMainViewAnimateDone
{
    [self.loginNavigationController.view removeFromSuperview];
    self.loginNavigationController = nil;
}

#pragma mark - Custom event methods

//- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
//{
//	Message* message = [[Message alloc] init];
//	message.date = [NSDate date];
//    
//	NSString* alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//    
//	NSMutableArray* parts = [NSMutableArray arrayWithArray:[alertValue componentsSeparatedByString:@": "]];
//	message.senderName = [parts objectAtIndex:0];
//	[parts removeObjectAtIndex:0];
//	message.text = [parts componentsJoinedByString:@": "];
//    
//	int index = [dataModel addMessage:message];
//    
//	if (updateUI)
//		[self.chatViewController didSaveMessage:message atIndex:index];
//    
//	[message release];
//}

#pragma mark - Application lifecycle methods

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor clearColor];
    [self loadingView];
    [self.window makeKeyAndVisible];
    
//    if (!application.enabledRemoteNotificationTypes) {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeNewsstandContentAvailability | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//    }
    
    if (launchOptions != nil) {
        NSDictionary *dictionary =[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送通知"
                                                                message:@"这里显示推送的消息"
                                                               delegate:nil
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

//--切换到后台时执行，可以在这里保存数据，执行逻辑业务
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

//--这个项目要蒋六个viewcontroller设置为rootViewController

//--切换到前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //--程序唤醒的时候检查是否有推送消息发来
//    [NSTimer scheduledTimerWithTimeInterval:1
//                                     target:self
//                                   selector:@selector(registerForRemoteNotificationToGetToken)
//                                   userInfo:nil
//                                    repeats:NO];
}

//--应用完全退出时执行，ios6在后台的方法调用不到，所以不要在这里保存数据
- (void)applicationWillTerminate:(UIApplication *)application
{
}

-(void)applicationDidFinishLaunching:(UIApplication *)application
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
}

//--获取推送消息的方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    _pushMessageDataBase = [[PushMessageDataBase alloc] init];
    [_pushMessageDataBase createPushMessageDataTable];
    
    NSString *acme1String = [[userInfo objectForKey:@"aps"] objectForKey:@"acme1"];
    NSString *uid    = nil;
    NSString *avatar = nil;
    NSString *time   = nil;
    NSArray *pushArray = [acme1String componentsSeparatedByString:@","];
    if ([pushArray count] > 2) {
        uid = [pushArray objectAtIndex:0];
        avatar = [pushArray objectAtIndex:1];
        time = [pushArray objectAtIndex:2];
    }
    
    PushMessage *pushMessage = [[PushMessage alloc] init];
    pushMessage.uid = [[uid substringWithRange:NSMakeRange(4, [uid length] - 4)] integerValue];
    pushMessage.avatar = [avatar substringWithRange:NSMakeRange(7, [avatar length] - 7)];
    pushMessage.time = [time substringWithRange:NSMakeRange(5, [time length] - 5)];
    pushMessage.totalNum = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] integerValue];
    pushMessage.message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    [_pushMessageDataBase addPushMessage:pushMessage];
    [pushMessage release];
    
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != NULL) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *myDeviceToken = [NSString stringWithFormat:@"%@",deviceToken];
    NSString *device = [myDeviceToken substringWithRange:NSMakeRange(1, [myDeviceToken length]-2)];
    [Global shareGlobal].deviceToken = device;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"没有得到手机令牌: %@", error);
}

@end
