//
//  setMessageViewController.m
//  certne
//
//  Created by apple on 13-5-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "setMessageViewController.h"
#import "DetailMessageViewController.h"
#import "setMessageCell.h"
#import "HeadNavView.h"
#import "Foundation.h"

@implementation setMessageViewController
@synthesize contactTableView;
@synthesize headNavView = _headNavView;

#pragma mark - Custom event methods

-(void)createUserInfoArray
{
    UIImage *iphoneImage   = [UIImage imageNamed:@"icon_phone.png"];
    UIImage *telPhoneImage = [UIImage imageNamed:@"icon_telephone.png"];
    UIImage *emailImage    = [UIImage imageNamed:@"icon_email.png"];
    UIImage *faxImage      = [UIImage imageNamed:@"icon_fox.png"];
    UIImage *qqImage       = [UIImage imageNamed:@"icon_qq.png"];
    UIImage *documentImage = [UIImage imageNamed:@"icon_document.png"];
    UIImage *industryImage = [UIImage imageNamed:@"icon_industry.png"];
    UIImage *websiteImage  = [UIImage imageNamed:@"icon_website.png"];
    UIImage *addressImage  = [UIImage imageNamed:@"icon_address.png"];
    UIImage *zipcodeImage  = [UIImage imageNamed:@"icon_zipcode.png"];
    
    _btnImageArray = [[NSArray alloc] initWithObjects:iphoneImage,telPhoneImage,emailImage,faxImage,qqImage,documentImage,industryImage,websiteImage,addressImage,zipcodeImage, nil];

    _titleArray = [[NSArray alloc] initWithObjects:@"联系电话",@"固定电话",@"邮箱地址",@"公司传真",@"QQ号码",@"公司部门",@"所在行业",@"公司网站",@"公司地址",@"邮政编码", nil];
    
    _userInfoArray = [[NSMutableArray alloc] initWithObjects:self.friendDetailData.mobile,self.friendDetailData.tel,self.friendDetailData.email,self.friendDetailData.fax,self.friendDetailData.qq,self.friendDetailData.department,self.friendDetailData.industry,self.friendDetailData.website,self.friendDetailData.address,self.friendDetailData.zipcode, nil];
}

#pragma mark - View lifecycle methods

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
    
    [self createUserInfoArray];
    
    _sectionText = [[NSArray alloc]initWithObjects:@"联系信息",@"公司信息", nil];
    
    contactTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 65, 300, kUIsIphone5?493:415) style:UITableViewStylePlain];
    contactTableView.delegate   = self;
    contactTableView.dataSource = self;
    contactTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:contactTableView];
    
    _headNavView = [[HeadNavView alloc] initWithFrame:CGRectMake(0, 20, 320, 65)];
    [_headNavView.fallbackButton setFrame:CGRectMake(20, 17, 30, 30)];
    [_headNavView.fallbackButton setImage:[UIImage imageNamed:@"arrow_up.png"] forState:UIControlStateNormal];
    [_headNavView.fallbackButton addTarget:self action:@selector(fallBack:) forControlEvents:UIControlEventTouchUpInside];
    [_headNavView.titleLabel setText:self.friendDetailData.name];
    [self.view addSubview:_headNavView];
    
    self.view.backgroundColor = UIColorFromFloat(210, 215, 225);
}

#pragma tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count]/2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    
    UIImageView *line_downImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 300, 1)];
    [line_downImageView setBackgroundColor:UIColorFromFloat(210, 215, 225)];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 1, 300, 38)];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont fontWithName:FONTNAME size:14]];
    [label setText:sectionTitle];
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView addSubview:line_downImageView];
    [sectionView addSubview:label];
    
    return sectionView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionText objectAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"_setMessageCELL";
    
    setMessageCell *cell=(setMessageCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (!cell) {
        cell = [[setMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        [cell setButtonBackGroundImage:[_btnImageArray objectAtIndex:indexPath.row]];
        [cell setTitleLabelText:[_titleArray objectAtIndex:indexPath.row]];
        if ([_userInfoArray count] == 0) {
            [cell setContentLabelText:@"未填写"];
        }else{
            [cell setContentLabelText:[_userInfoArray objectAtIndex:indexPath.row]];
        }
    }else{
        [cell setButtonBackGroundImage:[_btnImageArray objectAtIndex:indexPath.row + 5]];
        [cell setTitleLabelText:[_titleArray objectAtIndex:indexPath.row + 5]];
        if ([_userInfoArray count] == 0) {
            [cell setContentLabelText:@"未填写"];
        }else{
            [cell setContentLabelText:[_userInfoArray objectAtIndex:indexPath.row + 5]];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)fallBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark- Memory management methods

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)dealloc
{
}
@end
