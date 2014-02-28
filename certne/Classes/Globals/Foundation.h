//
//  Foundation.h
//  certne
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//--全局常量存放地址

//--本地服务器地址
#define LOCALURL @"http://192.168.1.171/"

//--阿里云服务器地址
#define ALIYUNURL @"http://115.29.185.105/"

//--链接延时时长
#define TIMEOUTINTERAL 30

//--空间名
#define BUCKET @"bcn-image"

//--表单api功能密钥
#define PASSCODE @"hr1XFMvKzURvkpVmK1dKLXaC5lI="

//--上传图片时间限制
#define EXPIRES_IN 60

//--百度地图定位密钥
#define BaiDuMapAK @"259E4D099781a61d0e4e6ed695a56e7e"

#define FONTNAME @"STHeitiTC-Light"

//--自定义释放内存
#if DEBUG
#define MCRelease(x) [x release]
#else
#define MCRelease(x) [x release], x = nil
#endif

//--版本检测
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//--手机类型检测
#define kFBaseHeight [[UIScreen mainScreen]bounds].size.height

#define kUIsIphone4 kFBaseHeight == 480

#define kUIsIphone5 kFBaseHeight == 568

//导航栏的高度
#define kFBaseNavHeight 44
//状态栏的高度
#define kFBaseStatusHeight 20
//界面的宽
#define kFBaseWidth [[UIScreen mainScreen]bounds].size.width
//界面的高
#define kFBaseHeight [[UIScreen mainScreen]bounds].size.height
//没有状态条的高度
#define kFBaseHeightNoStatus (kFBaseHeight-kFBaseStatusHeight)
//没有状态条和导航栏的高度
#define kFBaseHeightNoStatusNoNav (kFBaseHeight - kFBaseStatusHeight - kFBaseNavHeight)

//--发布供求时的类别
#define SUPPLYTYPE 1

#define NEEDTYPE 2

//--数据表名称
#define SESSIONDBNAME @"session.sqlite"

#define PUSHMESSAGEDBNAME @"pushMessage.sqlite"

//--定义RGB颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//--使用
//[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];

//--定义浮点值颜色
#define UIColorFromFloat(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define themeColor [UIColor colorWithRed:65/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f];

