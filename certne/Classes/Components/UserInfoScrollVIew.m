//
//  UserInfoScrollVIew.m
//  certne
//
//  Created by apple on 13-12-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UserInfoScrollVIew.h"
#import "Foundation.h"

/**
 *	@brief	替代表单
 */
@implementation UserInfoScrollVIew
@synthesize headImageButton     = _headImageButton;
@synthesize nameTextField       = _nameTextField;
@synthesize positionTextField   = _positionTextField;
@synthesize companyTextField    = _companyTextField;
@synthesize mobileTextField     = _mobileTextField;
@synthesize telphoneTextField   = _telphoneTextField;
@synthesize emailTextField      = _emailTextField;
@synthesize faxTextField        = _faxTextField;
@synthesize qqTextField         = _qqTextField;
@synthesize departmentTextField = _departmentTextField;
@synthesize industryTextField   = _industryTextField;
@synthesize websiteTextField    = _websiteTextField;
@synthesize addressTextField    = _addressTextField;
@synthesize zipcodeTextField    = _zipcodeTextField;
@synthesize myDelegate          = _myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         *	@brief	头像等重要信息
         */
        self.headImageButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageButton.frame = CGRectMake(55, 55, 188, 188);
        [self.headImageButton setImage:[UIImage imageNamed:@"main_headImage_bg.png"] forState:UIControlStateNormal];
        [self.headImageButton setImage:[UIImage imageNamed:@"headBtnHlg.png"] forState:UIControlStateHighlighted];
        [self.headImageButton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _nameTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(110, 270, 80, 20)];
        _nameTextField.backgroundColor = [UIColor clearColor];
        _nameTextField.font            = [UIFont fontWithName:FONTNAME size:17];
        _nameTextField.placeholder     = @"填写姓名";
        _nameTextField.textAlignment   = NSTextAlignmentCenter;

        _positionTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(110, 292, 80, 18)];
        _positionTextField.backgroundColor = [UIColor clearColor];
        _positionTextField.textColor       = UIColorFromFloat(80, 80, 80);
        _positionTextField.font            = [UIFont fontWithName:FONTNAME size:14];
        _positionTextField.placeholder     = @"编辑职位";
        _positionTextField.textAlignment   = NSTextAlignmentCenter;
        
        _companyTextField                  = [[UITextField alloc] initWithFrame:CGRectMake(50, 315, 200, 20)];
        _companyTextField.backgroundColor  = [UIColor clearColor];
        _companyTextField.font             = [UIFont fontWithName:FONTNAME size:16];
        _companyTextField.placeholder      = @"编辑公司信息";
        _companyTextField.textAlignment    = NSTextAlignmentCenter;
        
        UIView *headView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 350)];
        headView.backgroundColor = UIColorFromFloat(245, 245, 245);
        [headView addSubview:self.headImageButton];
        [headView addSubview:_nameTextField];
        [headView addSubview:_positionTextField];
        [headView addSubview:_companyTextField];
        [self addSubview:headView];
        [_nameTextField release];
        [_companyTextField release];
        [_positionTextField release];
        [headView release];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 349, 300, 1)];
        lineView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineView];
        [lineView release];
        
        UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 362, 200, 16)];
        contactLabel.text = @"联系信息";
        contactLabel.font = [UIFont boldSystemFontOfSize:15];
        contactLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:contactLabel];
        [contactLabel release];
        
        UIView *lineOneView = [[UIView alloc] initWithFrame:CGRectMake(0, 389, 300, 1)];
        lineOneView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineOneView];
        [lineOneView release];
        
        /**
         *	@brief	手机
         */
        _phoneCallButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneCallButton.frame = CGRectMake(20, 400, 40, 40);
        [_phoneCallButton setBackgroundImage:[UIImage imageNamed:@"icon_phone.png"] forState:UIControlStateNormal];
        [_phoneCallButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_phoneCallButton];
        
        _mobileTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 400, 200, 24)];
        _mobileTextField.backgroundColor = [UIColor clearColor];
        _mobileTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _mobileTextField.placeholder     = @"请输入手机号码";
        _mobileTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_mobileTextField];
        [_mobileTextField release];
        
        UILabel *phoneCallLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 424, 200, 16)];
        phoneCallLabel.textAlignment     = NSTextAlignmentLeft;
        phoneCallLabel.text              = @"联系电话";
        phoneCallLabel.backgroundColor   = [UIColor clearColor];
        phoneCallLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:phoneCallLabel];
        [phoneCallLabel release];
        
        UIView *lineTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 449, 300, 1)];
        lineTwoView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineTwoView];
        [lineTwoView release];
        
        /**
         *	@brief	固定电话
         */
        _telphoneCallButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _telphoneCallButton.frame = CGRectMake(20, 460, 40, 40);
        [_telphoneCallButton setBackgroundImage:[UIImage imageNamed:@"icon_telephone.png"] forState:UIControlStateNormal];
        [_telphoneCallButton addTarget:self action:@selector(telephoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_telphoneCallButton];
        
        _telphoneTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 460, 200, 24)];
        _telphoneTextField.backgroundColor = [UIColor clearColor];
        _telphoneTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _telphoneTextField.placeholder     = @"请输入固定电话号码";
        _telphoneTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_telphoneTextField];
        [_telphoneTextField release];
        
        UILabel *telphoneCallLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 484, 200, 16)];
        telphoneCallLabel.textAlignment     = NSTextAlignmentLeft;
        telphoneCallLabel.text              = @"固定电话";
        telphoneCallLabel.backgroundColor   = [UIColor clearColor];
        telphoneCallLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:telphoneCallLabel];
        [telphoneCallLabel release];
        
        UIView *lineThreeView = [[UIView alloc] initWithFrame:CGRectMake(0, 509, 300, 1)];
        lineThreeView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineThreeView];
        [lineThreeView release];
        
        /**
         *	@brief	邮件
         */
        _emailButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _emailButton.frame = CGRectMake(20, 520, 40, 40);
        [_emailButton setBackgroundImage:[UIImage imageNamed:@"icon_email.png"] forState:UIControlStateNormal];
        [_emailButton addTarget:self action:@selector(sendEmailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_emailButton];
        
        _emailTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 520, 200, 24)];
        _emailTextField.backgroundColor = [UIColor clearColor];
        _emailTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _emailTextField.placeholder     = @"请输入邮件地址";
        _emailTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_emailTextField];
        [_emailTextField release];
        
        UILabel *emailLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 544, 200, 16)];
        emailLabel.textAlignment     = NSTextAlignmentLeft;
        emailLabel.text              = @"邮箱地址";
        emailLabel.backgroundColor   = [UIColor clearColor];
        emailLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:emailLabel];
        [emailLabel release];
        
        UIView *lineFourView = [[UIView alloc] initWithFrame:CGRectMake(0, 569, 300, 1)];
        lineFourView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineFourView];
        [lineFourView release];
        
        /**
         *	@brief	传真
         */
        _faxButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _faxButton.frame = CGRectMake(20, 580, 40, 40);
        [_faxButton setBackgroundImage:[UIImage imageNamed:@"icon_fox.png"] forState:UIControlStateNormal];
        [_faxButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_faxButton];
        
        _faxTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 580, 200, 24)];
        _faxTextField.backgroundColor = [UIColor clearColor];
        _faxTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _faxTextField.placeholder     = @"请输入传真号码";
        _faxTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_faxTextField];
        [_faxTextField release];
        
        UILabel *faxLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 604, 200, 16)];
        faxLabel.textAlignment     = NSTextAlignmentLeft;
        faxLabel.text              = @"公司传真";
        faxLabel.backgroundColor   = [UIColor clearColor];
        faxLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:faxLabel];
        [faxLabel release];
        
        UIView *lineFiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 629, 300, 1)];
        lineFiveView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineFiveView];
        [lineFiveView release];
        
        /**
         *	@brief	QQ
         */
        _qqButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqButton.frame = CGRectMake(20, 640, 40, 40);
        [_qqButton setBackgroundImage:[UIImage imageNamed:@"icon_qq.png"] forState:UIControlStateNormal];
        [_qqButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_qqButton];
        
        _qqTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 640, 200, 24)];
        _qqTextField.backgroundColor = [UIColor clearColor];
        _qqTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _qqTextField.placeholder     = @"请输入QQ号码";
        _qqTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_qqTextField];
        [_qqTextField release];
        
        UILabel *qqLabel        = [[UILabel alloc] initWithFrame:CGRectMake(80, 664, 200, 16)];
        qqLabel.textAlignment   = NSTextAlignmentLeft;
        qqLabel.text            = @"QQ号码";
        qqLabel.backgroundColor = [UIColor clearColor];
        qqLabel.font            = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:qqLabel];
        [qqLabel release];
        
        UIView *lineSixView = [[UIView alloc] initWithFrame:CGRectMake(0, 689, 300, 1)];
        lineSixView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineSixView];
        [lineSixView release];

        
        UILabel *companyLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 702, 200, 16)];
        companyLabel.text = @"公司信息";
        companyLabel.font = [UIFont boldSystemFontOfSize:15];
        companyLabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:companyLabel];
        [companyLabel release];
        
        UIView *lineSevenView = [[UIView alloc] initWithFrame:CGRectMake(0, 729, 300, 1)];
        lineSevenView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineSevenView];
        [lineSevenView release];
        
        /**
         *	@brief	部门信息
         */
        _departmentButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _departmentButton.frame = CGRectMake(20, 740, 40, 40);
        [_departmentButton setBackgroundImage:[UIImage imageNamed:@"icon_document.png"] forState:UIControlStateNormal];
        [_departmentButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_departmentButton];
        
        _departmentTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 740, 200, 24)];
        _departmentTextField.backgroundColor = [UIColor clearColor];
        _departmentTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _departmentTextField.placeholder     = @"请输入所在部门";
        _departmentTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_departmentTextField];
        [_departmentTextField release];
        
        UILabel *departmentLabel        = [[UILabel alloc] initWithFrame:CGRectMake(80, 764, 200, 16)];
        departmentLabel.textAlignment   = NSTextAlignmentLeft;
        departmentLabel.text            = @"公司部门";
        departmentLabel.backgroundColor = [UIColor clearColor];
        departmentLabel.font            = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:departmentLabel];
        [departmentLabel release];
        
        UIView *lineEightView = [[UIView alloc] initWithFrame:CGRectMake(0, 789, 300, 1)];
        lineEightView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineEightView];
        [lineEightView release];

        /**
         *	@brief	行业
         */
        _industryButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _industryButton.frame = CGRectMake(20, 800, 40, 40);
        [_industryButton setBackgroundImage:[UIImage imageNamed:@"icon_industry.png"] forState:UIControlStateNormal];
        [_industryButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_industryButton];
        
        _industryTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 800, 200, 24)];
        _industryTextField.backgroundColor = [UIColor clearColor];
        _industryTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _industryTextField.placeholder     = @"请输入所在行业";
        _industryTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_industryTextField];
        [_industryTextField release];
        
        UILabel *industryLabel        = [[UILabel alloc] initWithFrame:CGRectMake(80, 824, 200, 16)];
        industryLabel.textAlignment   = NSTextAlignmentLeft;
        industryLabel.text            = @"所在行业";
        industryLabel.backgroundColor = [UIColor clearColor];
        industryLabel.font            = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:industryLabel];
        [industryLabel release];
        
        UIView *lineNineView = [[UIView alloc] initWithFrame:CGRectMake(0, 849, 300, 1)];
        lineNineView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineNineView];
        [lineNineView release];
        
        /**
         *	@brief	网址
         */
        _websiteButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _websiteButton.frame = CGRectMake(20, 860, 40, 40);
        [_websiteButton setBackgroundImage:[UIImage imageNamed:@"icon_website.png"] forState:UIControlStateNormal];
        [_websiteButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_websiteButton];
        
        _websiteTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 860, 200, 24)];
        _websiteTextField.backgroundColor = [UIColor clearColor];
        _websiteTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _websiteTextField.placeholder     = @"请输入公司网址";
        _websiteTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_websiteTextField];
        [_websiteTextField release];
        
        UILabel *websiteLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 884, 200, 16)];
        websiteLabel.textAlignment     = NSTextAlignmentLeft;
        websiteLabel.text              = @"公司网站";
        websiteLabel.backgroundColor   = [UIColor clearColor];
        websiteLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:websiteLabel];
        [websiteLabel release];
        
        UIView *lineTenView = [[UIView alloc] initWithFrame:CGRectMake(0, 909, 300, 1)];
        lineTenView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineTenView];
        [lineTenView release];
        
        /**
         *	@brief	地址
         */
        _addressButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _addressButton.frame = CGRectMake(20, 920, 40, 40);
        [_addressButton setBackgroundImage:[UIImage imageNamed:@"icon_address.png"] forState:UIControlStateNormal];
        [_addressButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addressButton];
        
        _addressTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 920, 200, 24)];
        _addressTextField.backgroundColor = [UIColor clearColor];
        _addressTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _addressTextField.placeholder     = @"请输入公司地址";
        _addressTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_addressTextField];
        [_addressTextField release];
        
        UILabel *addressLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 944, 200, 16)];
        addressLabel.textAlignment     = NSTextAlignmentLeft;
        addressLabel.text              = @"公司地址";
        addressLabel.backgroundColor   = [UIColor clearColor];
        addressLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:addressLabel];
        [addressLabel release];
        
        UIView *lineElevenView = [[UIView alloc] initWithFrame:CGRectMake(0, 969, 300, 1)];
        lineElevenView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self addSubview:lineElevenView];
        [lineElevenView release];
        
        /**
         *	@brief	邮编
         */
        _zipcodeButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        _zipcodeButton.frame = CGRectMake(20, 980, 40, 40);
        [_zipcodeButton setBackgroundImage:[UIImage imageNamed:@"icon_zipcode.png"] forState:UIControlStateNormal];
        [_zipcodeButton addTarget:self action:@selector(phoneCallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zipcodeButton];
        
        _zipcodeTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(80, 980, 200, 24)];
        _zipcodeTextField.backgroundColor = [UIColor clearColor];
        _zipcodeTextField.font            = [UIFont fontWithName:FONTNAME size:16];
        _zipcodeTextField.placeholder     = @"请输入邮编号码";
        _zipcodeTextField.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_zipcodeTextField];
        [_zipcodeTextField release];
        
        UILabel *zipcodeLabel          = [[UILabel alloc] initWithFrame:CGRectMake(80, 1004, 200, 16)];
        zipcodeLabel.textAlignment     = NSTextAlignmentLeft;
        zipcodeLabel.text              = @"邮政编码";
        zipcodeLabel.backgroundColor   = [UIColor clearColor];
        zipcodeLabel.font              = [UIFont fontWithName:FONTNAME size:16];
        [self addSubview:zipcodeLabel];
        [zipcodeLabel release];

        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark- Custom event methods

-(void)phoneCallButtonClicked:(id)sender
{
    //--可以考虑设置代理
}

-(void)telephoneCallButtonClicked:(id)sender
{
    //--代理传值，要传进来一个电话号码
}

-(void)sendEmailButtonClicked:(id)sender
{
    //--代理传值，传邮件
}

-(void)headImageButtonClicked:(id)sender
{
    if (_myDelegate && [(NSObject *)_myDelegate respondsToSelector:@selector(headImageButtonClicked)]) {
        [_myDelegate headImageButtonClicked];
    }
}

#pragma mark- memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
