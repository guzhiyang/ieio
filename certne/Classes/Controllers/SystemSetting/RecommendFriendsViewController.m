//
//  RecommendFriendsViewController.m
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RecommendFriendsViewController.h"
#import "Foundation.h"

@implementation RecommendFriendsViewController
@synthesize recommendFriendsTabelView = _recommendFriendsTabelView;
@synthesize searchFrienTextField      = _searchFrienTextField;

#pragma mark - view lifecycle methods

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
    [_navBarView settitleLabelText:@"推荐好友"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    _searchFrienTextField=[[UITextField alloc]initWithFrame:CGRectMake(55, 12, 248, 20)];
    _searchFrienTextField.delegate      = self;
    _searchFrienTextField.returnKeyType = UIReturnKeyDone;
    _searchFrienTextField.placeholder   = @"搜索好友";
    _searchFrienTextField.font = [UIFont fontWithName:FONTNAME size:14];
    
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame=CGRectMake(20, 7, 30, 30);
    [searchButton addTarget:self action:@selector(searchFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_friend.png"]];
    [searchView addSubview:_searchFrienTextField];
    [searchView addSubview:searchButton];
    [self.view addSubview:searchView];
    [_searchFrienTextField release];
    [searchView release];
    
    _recommendFriendsTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, 320, self.view.frame.size.height-108) style:UITableViewStylePlain];
    _recommendFriendsTabelView.delegate = self;
    _recommendFriendsTabelView.dataSource = self;
    _recommendFriendsTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_recommendFriendsTabelView];
    [_recommendFriendsTabelView release];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark - Custom event methods

-(void)searchFriend:(id)sender
{
    //--查询通讯录
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UITabelView datasource && delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[AddressBookCell alloc] init]autorelease];
        cell.delegate = self;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - AddressBookCell delegate methods

-(void)addressBookButtonClicked
{
    //--邀请，添加，已添加
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
