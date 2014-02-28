/*
 
 File: Reachability.h
 Abstract: Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 
 Version: 2.0.4ddg
 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

//#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"
#define USE_DDG_EXTENSIONS 1 // Use DDG's Extensions to test network criteria.
// Since NSAssert and NSCAssert are used in this code, 
// I recommend you set NS_BLOCK_ASSERTIONS=1 in the release versions of your projects.

enum {
	
	// DDG NetworkStatus Constant Names.
	kNotReachable = 0, // Apple's code depends upon 'NotReachable' being the same value as 'NO'.
	kReachableViaWWAN, // Switched order from Apple's enum. WWAN is active before WiFi.
	kReachableViaWiFi
	
};
typedef	uint32_t NetworkStatus;

enum {
	
	// Apple NetworkStatus Constant Names.
	NotReachable     = kNotReachable,
	ReachableViaWiFi = kReachableViaWiFi,
	ReachableViaWWAN = kReachableViaWWAN
	
};


extern NSString *const kInternetConnection;
extern NSString *const kLocalWiFiConnection;
extern NSString *const kReachabilityChangedNotification;

@interface Reachability: NSObject {
	
@private
	NSString                *key_;
	SCNetworkReachabilityRef reachabilityRef;

}

@property (copy) NSString *key; // Atomic because network operations are asynchronous.

// Designated Initializer.
- (Reachability *) initWithReachabilityRef: (SCNetworkReachabilityRef) ref;

// 检测可以连接的主机名
+ (Reachability *) reachabilityWithHostName: (NSString*) hostName;

// 用来检测可以连接的IP地址
+ (Reachability *) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

// 检测是否可用默认的路由
// 应该使应用连接到一个主机
+ (Reachability *) reachabilityForInternetConnection;

// 检测是否有一个可以使用的本地WiFi
+ (Reachability *) reachabilityForLocalWiFi;

// 开始循环监听是否有连接
- (BOOL) startNotifier;
- (void)  stopNotifier;

// Comparison routines to enable choosing actions in a notification.
- (BOOL) isEqual: (Reachability *) r;

// These are the status tests.
- (NetworkStatus) currentReachabilityStatus;

// The main direct test of reachability.
- (BOOL) isReachable;

- (BOOL) isConnectionRequired; // Identical DDG variant.
//--连接到一个可用的VPN点播
- (BOOL) connectionRequired; // Apple's routine.

// Dynamic, on demand connection?
- (BOOL) isConnectionOnDemand;

// Is user intervention required?
- (BOOL) isInterventionRequired;

// Routines for specific connection testing by your app.
- (BOOL) isReachableViaWWAN;
- (BOOL) isReachableViaWiFi;

- (SCNetworkReachabilityFlags) reachabilityFlags;

@end
