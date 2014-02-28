//
//  EditPublicInformationViewController.m
//  certne
//
//  Created by apple on 13-9-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "EditPublicInformationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Foundation.h"
#import "Global.h"

@implementation EditPublicInformationViewController
@synthesize informationTextView = _informationTextView;
@synthesize addImageButton      = _addImageButton;
@synthesize imageSaveKey        = _imageSaveKey;
@synthesize delegate            = _delegate;

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
        
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"发布信息"];
    [_navBarView.fallBackButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    _addImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _addImageButton.frame = CGRectMake(10, 80, 300, 100);
    _addImageButton.layer.borderColor = UIColorFromFloat(180, 180, 180).CGColor;
    [_addImageButton setBackgroundImage:[UIImage imageNamed:@"edit_msg_image.png"] forState:UIControlStateNormal];
    [_addImageButton addTarget:self action:@selector(addProductPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addImageButton];
    
    _informationTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 195, 300, 100)];
    _informationTextView.textAlignment = NSTextAlignmentLeft;
    _informationTextView.delegate      = self;
    _informationTextView.returnKeyType = UIReturnKeyDone;
    _informationTextView.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:_informationTextView];
    [_informationTextView release];
    
    _supplyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _supplyButton.frame = CGRectMake(10, 310, 150, 30);
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    [_supplyButton addTarget:self action:@selector(publicSupplyInformationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_supplyButton];
    
    _supplyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 150, 30)];
    _supplyLabel.text = @"发布供应";
    _supplyLabel.textAlignment = NSTextAlignmentCenter;
    _supplyLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [self.view addSubview:_supplyLabel];
    [_supplyLabel release];
    
    _demandButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _demandButton.frame = CGRectMake(160, 310, 150, 30);
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    [_demandButton addTarget:self action:@selector(publicDemandInformationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_demandButton];
    
    _demandLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 310, 150, 30)];
    _demandLabel.text          = @"发布需求";
    _demandLabel.textAlignment = NSTextAlignmentCenter;
    _demandLabel.textColor     = [UIColor whiteColor];
    _demandLabel.font          = [UIFont fontWithName:FONTNAME size:16];
    [self.view addSubview:_demandLabel];
    [_demandLabel release];
    
    self.view.backgroundColor = UIColorFromFloat(210, 210, 210);
}

#pragma mark- Custom event methods

-(void)publicSupplyInformationClicked:(id)sender
{
    [_informationTextView resignFirstResponder];
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    _supplyLabel.textColor = [UIColor blackColor];
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    _demandLabel.textColor = [UIColor whiteColor];

    [self upLoadImageToUpYun];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://bcn-image.b0.upaiyun.com/%@",self.imageSaveKey];
    
    if (_publishMessageRequest == nil) {
        _publishMessageRequest = [[PublishMessageRequest alloc] init];
        _publishMessageRequest.delegate = self;
    }
    
    [_publishMessageRequest sendPublishMessageRequestWithMobile:[Global shareGlobal].mobile
                                                      sessionid:[Global shareGlobal].session_id
                                                      imagesUrl:imageURL
                                                           desc:_informationTextView.text
                                                           type:SUPPLYTYPE
                                                      longitude:[Global shareGlobal].longitude
                                                       latitude:[Global shareGlobal].latitude];
}

-(void)publicDemandInformationClicked:(id)sender
{
    [_informationTextView resignFirstResponder];
    [_supplyButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_off.png"] forState:UIControlStateNormal];
    _supplyLabel.textColor = [UIColor whiteColor];
    [_demandButton setBackgroundImage:[UIImage imageNamed:@"publish_msg_on.png"] forState:UIControlStateNormal];
    _demandLabel.textColor = [UIColor blackColor];
    
    [self upLoadImageToUpYun];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://bcn-image.b0.upaiyun.com/%@",self.imageSaveKey];
    
    if (_publishMessageRequest == nil) {
        _publishMessageRequest = [[PublishMessageRequest alloc] init];
        _publishMessageRequest.delegate = self;
    }
    
    [_publishMessageRequest sendPublishMessageRequestWithMobile:[Global shareGlobal].mobile
                                                      sessionid:[Global shareGlobal].session_id
                                                      imagesUrl:imageURL
                                                           desc:_informationTextView.text
                                                           type:NEEDTYPE
                                                      longitude:[Global shareGlobal].longitude
                                                       latitude:[Global shareGlobal].latitude];
}

-(void)addProductPhoto:(id)sender
{
    UIActionSheet *chooseImageActionSheet = [[UIActionSheet alloc] initWithTitle:@"拍摄图片"
                                                                        delegate:self
                                                               cancelButtonTitle:@"取消"
                                                          destructiveButtonTitle:nil
                                                               otherButtonTitles:@"使用相机拍照",@"从相册中读取", nil];
    chooseImageActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [chooseImageActionSheet showInView:self.view];
    [chooseImageActionSheet release];
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(refreshPublicInfoWhileFallback)]) {
        [_delegate refreshPublicInfoWhileFallback];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- ActionSheet delegate methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate              = self;
            pickerController.allowsEditing         = YES;
            pickerController.showsCameraControls   = NO;
            pickerController.navigationBarHidden   = YES;
            pickerController.wantsFullScreenLayout = YES;
            
            OverlayViewController *overlayController = [[OverlayViewController alloc] init];
            pickerController.cameraOverlayView = overlayController.view;
            [overlayController release];
            
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerController animated:YES];
        }else{
            UIAlertView *cameraNotAlertView = [[UIAlertView alloc]initWithTitle:@"相机不可以在虚拟机上使用"
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"好的"
                                                              otherButtonTitles:nil];
            [cameraNotAlertView show];
            [cameraNotAlertView release];
        }
    }else if(buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate             = self;
            pickerController.allowsEditing        = YES;
            pickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            pickerController.sourceType           = UIImagePickerControllerSourceTypePhotoLibrary;
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
        [actionSheet dismissWithClickedButtonIndex:2 animated:NO];
    }
}

#pragma mark - OverLayView delegate methods

-(void)didTakePicture:(UIImage *)picture
{
    //--从相机获取图片
}

-(void)didFinishedWithCramer
{
    //--相机完成照相
}

#pragma mark- UIImagePickerController delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    if (nil == picker || nil == info || nil == image) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"拍照出错，稍后再试！"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"好的"
                                                otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        //--下面的方法处理的获得的图片
        UIImage *buttonImage=[self getImageFromOriginalImage:image];
        [_addImageButton setImage:buttonImage forState:UIControlStateNormal];
        
        [self saveImage:image withName:[self getSaveKey]];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
    picker.delegate = self;
    [picker release];
    picker = nil;
}

#pragma mark- GetImageFromPickerImage methods 处理从imagePicker得到的图片

-(UIImage *)getImageFromOriginalImage:(UIImage *)originalImage
{
    CGFloat imageWidth  = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    CGFloat cutFloat    = imageHeight - imageWidth;
    CGRect myImagerect  = CGRectMake(0, cutFloat/2, imageWidth, imageWidth/3);
    CGImageRef imageref = originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageref, myImagerect);
    
    CGSize size;
    size.width  = 300.0f;
    size.height = 100.0f;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImagerect, subImageRef);
    UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return myImage;
}

#pragma mark - Save Image To Document 保存图片到沙盒

-(void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:YES];
}

#pragma mark- UpYun 上传图片到服务器

-(void)upLoadImageToUpYun
{
    UpYun *upYun = [[UpYun alloc] init];
    upYun.delegate  = self;
    upYun.expiresIn = EXPIRES_IN;
    upYun.bucket    = BUCKET;
    upYun.passcode  = PASSCODE;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    upYun.params = params;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *imagePath = [documentFile stringByAppendingPathComponent:self.imageSaveKey];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    NSString *saveKey = [NSString stringWithFormat:@"/%@",self.imageSaveKey];
    [upYun uploadImage:image savekey:saveKey];
}

-(NSString *)getSaveKey
{
    NSDate *date = [NSDate date];
    self.imageSaveKey = [NSString stringWithFormat:@"%d%d%.0f.png",[self getYearWithDate:date],[self getMonthDate:date],[[NSDate date] timeIntervalSince1970]];
    NSLog(@"saveKey = %@",self.imageSaveKey);
    return self.imageSaveKey;
}

-(int)getYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger intFlag = NSYearCalendarUnit;
    NSDateComponents *compent = [calendar components:intFlag fromDate:date];
    [calendar release];
    int year = [compent year];
    return year;
}

-(int)getMonthDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger intFlag = NSMonthCalendarUnit;
    NSDateComponents *compent = [calendar components:intFlag fromDate:date];
    [calendar release];
    int month=[compent month];
    return month;
}

#pragma mark - UpYun delegate methods

-(void)upYun:(UpYun *)upYun requestDidSucceedWithResult:(id)result
{
    NSString *resultString = (NSString *)result;
    NSLog(@"resultSring :%@",resultString);
}

-(void)upYun:(UpYun *)upYun requestDidFailWithError:(NSError *)error
{
    NSLog(@"上传图片失败:%@",error);
}

#pragma mark- TextView delegate methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - PublishMessageRequest delegate methods

-(void)publishMessageRequestDidFinished:(PublishMessageRequest *)publishMessageRequest statusResponse:(StatusResponse *)statusResponse
{
    if (statusResponse.status == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发布成功！"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发布失败！"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"请重试!"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)publishMessageRequestDidFailed:(PublishMessageRequest *)publishMessageRequest error:(NSError *)error
{
    NSLog(@"publishMessageRequestDidFailed:%@",error);
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _informationTextView = nil;
    [super dealloc];
}

@end
