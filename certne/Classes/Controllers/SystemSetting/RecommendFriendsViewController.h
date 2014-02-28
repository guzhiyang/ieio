//
//  RecommendFriendsViewController.h
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressBookCell.h"
#import "NavBarView.h"

@interface RecommendFriendsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AddressBookCellDelegate,NavBarViewDelegate>
{
    UITableView     *_recommendFriendsTabelView;
    UITextField     *_searchFrienTextField;
    NavBarView      *_navBarView;
}

@property (retain, nonatomic) UITableView       *recommendFriendsTabelView;
@property (retain, nonatomic) UITextField       *searchFrienTextField;

@end
