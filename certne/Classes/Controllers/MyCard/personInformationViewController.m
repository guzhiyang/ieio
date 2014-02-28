//
//  personInformationViewController.m
//  certne
//
//  Created by apple on 13-5-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "personInformationViewController.h"
#import "messageCell.h"
#import "certneCardViewController.h"
#import "Global.h"
#import "Foundation.h"

@implementation personInformationViewController

@synthesize headNavView        = _headNavView;
@synthesize currentTextField   = _currentTextField;
@synthesize userSelf           = _userSelf;
@synthesize userInfoScrollView = _userInfoScrollView;
@synthesize imageSaveKey       = _imageSaveKey;
@synthesize imageURL           = _imageURL;
@synthesize delegate           = _delegate;

#pragma mark - view 生命周期

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
    
    _getHeadImageSuccess = NO;
    
    _userInfoScrollView = [[UserInfoScrollVIew alloc] initWithFrame:CGRectMake(10, 85, 300, kUIsIphone5?483:395)];
    _userInfoScrollView.myDelegate  = self;
    _userInfoScrollView.contentSize = CGSizeMake(300, 1030);
    _userInfoScrollView.nameTextField.text       = [Global shareGlobal].currentUser.name;
    _userInfoScrollView.positionTextField.text   = [Global shareGlobal].currentUser.position;
    _userInfoScrollView.companyTextField.text    = [Global shareGlobal].currentUser.company;
    _userInfoScrollView.mobileTextField.text     = [Global shareGlobal].currentUser.mobile;
    _userInfoScrollView.telphoneTextField.text   = [Global shareGlobal].currentUser.tel;
    _userInfoScrollView.emailTextField.text      = [Global shareGlobal].currentUser.email;
    _userInfoScrollView.faxTextField.text        = [Global shareGlobal].currentUser.fax;
    _userInfoScrollView.qqTextField.text         = [Global shareGlobal].currentUser.qq;
    _userInfoScrollView.departmentTextField.text = [Global shareGlobal].currentUser.department;
    _userInfoScrollView.industryTextField.text   = [Global shareGlobal].currentUser.industry;
    _userInfoScrollView.websiteTextField.text    = [Global shareGlobal].currentUser.website;
    _userInfoScrollView.addressTextField.text    = [Global shareGlobal].currentUser.address;
    _userInfoScrollView.zipcodeTextField.text    = [NSString stringWithFormat:@"%i",[Global shareGlobal].currentUser.zipcode];
    _userInfoScrollView.nameTextField.delegate     = self;
    _userInfoScrollView.positionTextField.delegate = self;
    _userInfoScrollView.companyTextField.delegate  = self;
    _userInfoScrollView.mobileTextField.delegate   = self;
    _userInfoScrollView.telphoneTextField.delegate = self;
    _userInfoScrollView.emailTextField.delegate    = self;
    _userInfoScrollView.faxTextField.delegate      = self;
    _userInfoScrollView.qqTextField.delegate       = self;
    _userInfoScrollView.departmentTextField.delegate = self;
    _userInfoScrollView.industryTextField.delegate   = self;
    _userInfoScrollView.websiteTextField.delegate    = self;
    _userInfoScrollView.addressTextField.delegate    = self;
    _userInfoScrollView.zipcodeTextField.delegate    = self;
    [self.view addSubview:_userInfoScrollView];
    [_userInfoScrollView release];
    
    //--已经下载到本地，
    NSString *headImageKey = [Global shareGlobal].headImageKey;
    NSString *headImageURL = [Global shareGlobal].currentUser.avatar;

    if ([headImageKey length] > 5 && headImageURL != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFile = [paths objectAtIndex:0];
        NSString *imagePath = [documentFile stringByAppendingPathComponent:[Global shareGlobal].headImageKey];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        UIImage *headImage = [self editHeadImageFromPicker:image];
        [_userInfoScrollView.headImageButton setBackgroundImage:headImage forState:UIControlStateNormal];
    }else if ([headImageKey length] < 5 && headImageURL == nil){
        [_userInfoScrollView.headImageButton setBackgroundImage:[UIImage imageNamed:@"defaulta.png"] forState:UIControlStateNormal];
    }
    
    _headNavView = [[HeadNavView alloc]initWithFrame:CGRectMake(0, 20, 320, 65)];
    [_headNavView.fallbackButton addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    [_headNavView.titleLabel setText:@"个人信息"];
    [self.view addSubview:_headNavView];
    [_headNavView release];
    
    self.view.backgroundColor = UIColorFromFloat(210, 215, 225);
}

#pragma mark - 定制事件方法

-(void)backToHome:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(resetUserCardImageWithKey:)]) {
        if ([self.imageURL length] > 0) {
            [_delegate resetUserCardImageWithKey:self.imageSaveKey];
            [Global shareGlobal].headImageKey = self.imageSaveKey;
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];//--模态的View不好控制，最好改为pop
}

-(void)saveImageToDocument:(UIImage *)tempImage withName:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *imageFile    = [documentFile stringByAppendingPathComponent:imageName];
    NSData *imageData      = UIImagePNGRepresentation(tempImage);
    [imageData writeToFile:imageFile atomically:YES];
}

-(UIImage *)editHeadImageFromPicker:(UIImage *)pickerImage
{
    CGFloat cutFloat = pickerImage.size.height - pickerImage.size.width;
    CGRect imageRect = CGRectMake(0, cutFloat/2, pickerImage.size.width, pickerImage.size.width);
    CGImageRef imageRef = pickerImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    
    CGSize size;
    size.width = 300.0f;
    size.height = 300.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)upLoadImageToUpYun
{
    UpYun *upYun = [[UpYun alloc] init];
    upYun.delegate  = self;
    upYun.expiresIn = EXPIRES_IN;
    upYun.bucket    = BUCKET;
    upYun.passcode  = PASSCODE;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    upYun.params = params;
    
    NSArray *paths         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *imagePath    = [documentFile stringByAppendingPathComponent:self.imageSaveKey];
    UIImage *image         = [UIImage imageWithContentsOfFile:imagePath];
    NSString *saveKey      = [NSString stringWithFormat:@"/%@",self.imageSaveKey];
    [upYun uploadImage:image savekey:saveKey];
}

-(void)sendSaveUserInfoRequestWithHeadImageURL:(NSString *)headImageURL
{
    if (_saveUserInfoRequest == nil) {
        _saveUserInfoRequest = [[SaveUserInfoRequest alloc] init];
        _saveUserInfoRequest.delegate = self;
    }
    
    [_saveUserInfoRequest sendSaveUserInfoRequestWithUserAvatar:headImageURL
                                                      sessionid:[Global shareGlobal].session_id
                                                           name:self.userInfoScrollView.nameTextField.text
                                                       position:self.userInfoScrollView.positionTextField.text
                                                        company:self.userInfoScrollView.companyTextField.text
                                                         mobile:self.userInfoScrollView.mobileTextField.text
                                                       telphone:self.userInfoScrollView.telphoneTextField.text
                                                            fax:self.userInfoScrollView.faxTextField.text
                                                          email:self.userInfoScrollView.emailTextField.text
                                                             qq:self.userInfoScrollView.qqTextField.text
                                                     department:self.userInfoScrollView.departmentTextField.text
                                                       industry:self.userInfoScrollView.industryTextField.text
                                                        website:self.userInfoScrollView.websiteTextField.text
                                                        address:self.userInfoScrollView.addressTextField.text
                                                        zipcode:[self.userInfoScrollView.zipcodeTextField.text integerValue]];
}

#pragma mark - Keyboard define

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    keyboardViewController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyboardViewController addToolbarToKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	MCRelease(keyboardViewController);
}

#pragma mark- KeyboardViewController delegate

-(void)alttextFieldDidEndEditing:(UITextField *)textField
{
}

-(void)alttextViewDidEndEditing:(UITextView *)textView
{
}

-(void)editDoneButtonClicked:(id)sender
{
    if (_getHeadImageSuccess) {
        [self sendSaveUserInfoRequestWithHeadImageURL:[Global shareGlobal].currentUser.avatar];
    }else{
        [self sendSaveUserInfoRequestWithHeadImageURL:nil];
    }
}

#pragma mark- Request delegate methods

-(void)SaveUserInfoRequestDidFinished:(SaveUserInfoRequest *)saveUserInfoRequest saveUserInfoResponse:(StatusResponse *)response
{
    if (response.status == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"上传信息失败!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else if (response.status == 1){
        _sessionIDDataBase = [[SessionIDDatabase alloc] init];
        SessionID *sessoionID = [[[SessionID alloc] init] autorelease];
        sessoionID.uid        = [Global shareGlobal].currentUser.uid;
        sessoionID.sessionID  = [Global shareGlobal].session_id;
        sessoionID.name       = self.userInfoScrollView.nameTextField.text;
        sessoionID.mobile     = self.userInfoScrollView.mobileTextField.text;
        if (self.imageURL != nil) {
            sessoionID.avatar = self.imageURL;
        }else{
            sessoionID.avatar = [Global shareGlobal].currentUser.avatar;
        }
        sessoionID.company    = self.userInfoScrollView.companyTextField.text;
        sessoionID.department = self.userInfoScrollView.departmentTextField.text;
        sessoionID.position   = self.userInfoScrollView.positionTextField.text;
        sessoionID.industry   = self.userInfoScrollView.industryTextField.text;
        sessoionID.qq         = self.userInfoScrollView.qqTextField.text;
        sessoionID.website    = self.userInfoScrollView.websiteTextField.text;
        sessoionID.email      = self.userInfoScrollView.emailTextField.text;
        sessoionID.address    = self.userInfoScrollView.addressTextField.text;
        sessoionID.tel        = self.userInfoScrollView.telphoneTextField.text;
        sessoionID.fax        = self.userInfoScrollView.faxTextField.text;
        sessoionID.zipcode    = [self.userInfoScrollView.zipcodeTextField.text integerValue];
        BOOL success = [_sessionIDDataBase updateSessionID:sessoionID];
        
        [Global shareGlobal].currentUser.avatar = self.imageURL;
        
        if (success) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"上传信息成功，更新本地成功"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        [_sessionIDDataBase release];
    }
}

-(void)SaveUserInfoRequestDidFailed:(SaveUserInfoRequest *)saveUserInfoRequest error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - UIScrollView delegate methods

-(void)headImageButtonClicked
{
    UIActionSheet *headImageActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择头像"
                                                                      delegate:self
                                                             cancelButtonTitle:@"取消"
                                                        destructiveButtonTitle:nil
                                                             otherButtonTitles:@"使用相机拍照",@"从相册读取照片", nil];
    headImageActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [headImageActionSheet showInView:self.view];
    [headImageActionSheet release];
}

#pragma mark- 又拍云获取日期 保存路径

-(NSString *)getSaveKey
{
    //--保存图片的路径
    NSDate *date = [NSDate date];
    self.imageSaveKey = [NSString stringWithFormat:@"%d%d%.0f.png",[self getYear:date],[self getMonth:date],[[NSDate date] timeIntervalSince1970]];
    return self.imageSaveKey;
}

-(int)getYear:(NSDate *)date
{
    NSDateFormatter *formatter=[[[NSDateFormatter alloc] init] autorelease];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar=[[[NSCalendar alloc] initWithCalendarIdentifier:NSGenericException] autorelease];
    NSInteger intflag=NSYearCalendarUnit;
    NSDateComponents *compent=[calendar components:intflag fromDate:date];
    int year = [compent year];
    return year;
}

-(int)getMonth:(NSDate *)date
{
    NSDateFormatter *dateformatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGenericException] autorelease];
    NSInteger intflag = NSMonthCalendarUnit;
    NSDateComponents *compent = [calendar components:intflag fromDate:date];
    int month = [compent month];
    return month;
}

#pragma mark- 又拍云图片代理 upYun delegate methods

-(void)upYun:(UpYun *)upYun requestDidSucceedWithResult:(id)result
{
    _getHeadImageSuccess = YES;
    self.imageURL = [NSString stringWithFormat:@"http://bcn-image.b0.upaiyun.com/%@",self.imageSaveKey];
    [self sendSaveUserInfoRequestWithHeadImageURL:self.imageURL];
}

//--进度
-(void)upYun:(UpYun *)upYun requestDidSendBytes:(long long)bytes progress:(float)progress
{
}

-(void)upYun:(UpYun *)upYun requestDidFailWithError:(NSError *)error
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"上传失败"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"好的",@"取消", nil];
    [alertView show];
    [alertView release];
}

#pragma mark- 系统ActionSheet代理

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            if ([pickerController respondsToSelector:@selector(setAllowsEditing:)]) {
                pickerController.allowsEditing = YES;
            }
            pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerController animated:YES];
        }else{
            UIAlertView *cameraNotAlertView=[[UIAlertView alloc]initWithTitle:@"相机不可以在模拟器上使用"
                                                                      message:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"好的"
                                                            otherButtonTitles:nil];
            [cameraNotAlertView show];
            [cameraNotAlertView release];
        }
    }else if (buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            if ([pickerController respondsToSelector:@selector(setAllowsEditing:)]) {
                pickerController.allowsEditing = YES;
            }
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:pickerController animated:YES];
        }else{
            UIAlertView *photoFileAlertView = [[UIAlertView alloc]initWithTitle:@"相册打不开啊"
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"好的"
                                                              otherButtonTitles:nil];
            [photoFileAlertView show];
            [photoFileAlertView release];
        }
    }else{
        [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
    }
}

#pragma mark- UIImagePickerController 图片获取器代理

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    UIImage *headImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (picker == nil || info == nil || headImage == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"选取照片出错，请稍后再试!", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"好的", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        [_userInfoScrollView.headImageButton setBackgroundImage:[self editHeadImageFromPicker:headImage] forState:UIControlStateNormal];
        [self saveImageToDocument:headImage withName:[self getSaveKey]];
        [Global shareGlobal].headImageKey = [self getSaveKey];
    }
    
    [self upLoadImageToUpYun];
    
    [picker dismissModalViewControllerAnimated:NO];
    picker.delegate = nil;
    [picker release];
    picker = nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    picker.delegate = nil;
    [picker release];
    picker = nil;
}

#pragma mark-UITextfield 文本框取消键盘和遮挡代理

-(void)textAnimate:(UITextField *)textField Up:(BOOL)up
{
    const int moveDistance   = 215;
    const float moveDuration = 0.2f;
    int movement = (up?-moveDistance:moveDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationDuration:moveDuration];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    float moveHeight=760.0f;
//    float moveDistance=moveHeight+60.0;
//    
//    [messageTableView setContentOffset:CGPointMake(0,moveDistance) animated:YES];
//    [self textAnimate:textField Up:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    [_userSelfArray addObject:textField.text];
//    [messageTableView setContentOffset:CGPointMake(0, 600) animated:YES];
//    [self textAnimate:textField Up:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- Memory 内存管理

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



