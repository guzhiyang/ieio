//
//  LoadingViewController.m
//  certne
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoadingViewController.h"
#import "certneCardAppDelegate.h"
#import "Global.h"
#import "Foundation.h"

@implementation LoadingViewController
@synthesize defaultImageView = _defaultImageView;
@synthesize longitude        = _longitude;
@synthesize latitude         = _latitude;
@synthesize locationManager  = _locationManager;

#pragma mark-View lifeStyle methods

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
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate        = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.distanceFilter  = 100.0f;
    [CLLocationManager authorizationStatus];
    
    _defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, kFBaseHeight)];
    _defaultImageView.image = kUIsIphone5?[UIImage imageNamed:@"Default5.png"]:[UIImage imageNamed:@"Default.png"];
    _defaultImageView.contentMode = UIViewContentModeTop;
    [self.view addSubview:_defaultImageView];
    [_defaultImageView release];
        
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(loadingDone:)
                                   userInfo:@"user info"
                                    repeats:NO];
}

#pragma mark - Custom event methods

- (void)reverseLocation
{
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init] autorelease];
    
    [geoCoder reverseGeocodeLocation:_currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error) {
                           NSLog(@"error:%@",error.description);
                       }else {
                           if ([placemarks count] > 0)
                           {
                               CLPlacemark *placemark = (CLPlacemark *)[placemarks objectAtIndex:0];
                               
                               if ([placemark.subAdministrativeArea length] > 0) {
                                   NSLog(@"%@%@%@",placemark.country,placemark.administrativeArea,placemark.subAdministrativeArea);
                               }else {
                                   NSLog(@"%@%@",placemark.country,placemark.administrativeArea);
                               }
                           }
                       }
                   }];
}

-(void)loadingDone:(NSTimer *)timer
{
    SessionIDDatabase *sessionDataBase = [[SessionIDDatabase alloc] init];
    NSMutableArray *sessionArray = [sessionDataBase getAllData];
    SessionID *sessionID = [sessionArray firstObject];
    [sessionDataBase release];
    
    certneCardAppDelegate *appDelegate=(certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
    if (sessionID.sessionID == nil) {
        [appDelegate loadWelcomeView];
    }else{
        if (_userOnLineRequest == nil) {
            _userOnLineRequest = [[UserOnLineRequest alloc] init];
            _userOnLineRequest.delegate = self;
        }
        [_userOnLineRequest sendUserOnLineRequestWithSessionID:sessionID.sessionID longitude:self.longitude latitude:self.latitude deviceToken:[Global shareGlobal].deviceToken];
        
        [Global shareGlobal].currentUser = [self getUserFromSessionID:sessionID];
        [Global shareGlobal].session_id  = sessionID.sessionID;
        
        if ([[Global shareGlobal].currentUser.avatar length] > 5) {
            _imageDownLoader = [[ImageDownLoader alloc] initWithURLString:[Global shareGlobal].currentUser.avatar delegate:self];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不可以下载头像"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        
        if ([[Global shareGlobal].currentUser.avatar length] > 20) {
            NSArray *headImageArray = [[Global shareGlobal].currentUser.avatar componentsSeparatedByString:@"/"];
            NSString *headImageKey = [headImageArray lastObject];
            [Global shareGlobal].headImageKey = headImageKey;
        }
        [appDelegate loadMainView];
    }
}

-(User *)getUserFromSessionID:(SessionID *)sessionID
{
    User *currentuser = [[User alloc] init];
    currentuser.uid        = sessionID.uid;
    currentuser.name       = sessionID.name;
    currentuser.mobile     = sessionID.mobile;
    currentuser.avatar     = sessionID.avatar;
    currentuser.company    = sessionID.company;
    currentuser.department = sessionID.department;
    currentuser.position   = sessionID.position;
    currentuser.industry   = sessionID.industry;
    currentuser.qq         = sessionID.qq;
    currentuser.website    = sessionID.website;
    currentuser.email      = sessionID.email;
    currentuser.address    = sessionID.address;
    currentuser.tel        = sessionID.tel;
    currentuser.fax        = sessionID.fax;
    currentuser.zipcode    = sessionID.zipcode;
    
    return [currentuser autorelease];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

#pragma mark - Location manager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    self.longitude   = [[NSString stringWithFormat:@"%3.5f", _currentLocation.coordinate.longitude] floatValue];
    self.latitude    = [[NSString stringWithFormat:@"%3.5f", _currentLocation.coordinate.latitude] floatValue];
    [Global shareGlobal].longitude = self.longitude;
    [Global shareGlobal].latitude  = self.latitude;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Failed:%@",error);
}

#pragma makr - reverse delegate  methods

-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [geocoder cancel];
    if (placemark) {
        if ([placemark.subAdministrativeArea length] > 0) {
            NSLog(@"%@%@%@",placemark.country,placemark.administrativeArea,placemark.subAdministrativeArea);
        }else{
            NSLog(@"%@%@",placemark.country,placemark.administrativeArea);
        }
    }
}

-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"diaozale:%@",error.description);
}

#pragma mark - URLConnection delegate methods

-(void)userOnLineRequestDidFinished:(UserOnLineRequest *)userOnLineRequest response:(StatusResponse *)response
{
    NSLog(@"返回值 response = %i",response.status);
}

-(void)userOnLineRequestDidFailed:(UserOnLineRequest *)userOnLineRequest error:(NSError *)error
{
}

#pragma mark - HeadImageDownLoader delegate methods

-(void)downLoadFinish:(ImageDownLoader *)downLoader
{
}

-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
{
    UIImage *cardImage = [UIImage imageWithData:downLoader.receivedData];
    [Global shareGlobal].headImageData = downLoader.receivedData;
    
    NSArray *imageURLArray = [[Global shareGlobal].currentUser.avatar componentsSeparatedByString:@"/"];
    NSString *imageName = [imageURLArray lastObject];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *imageFile    = [documentFile stringByAppendingPathComponent:imageName];
    NSData *imageData      = UIImagePNGRepresentation(cardImage);
    [imageData writeToFile:imageFile atomically:YES];
}

-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - Memory management methods

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
    [super dealloc];
}

@end
