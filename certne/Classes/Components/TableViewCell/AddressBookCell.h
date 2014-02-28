//
//  AddressBookCell.h
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressBookCellDelegate;

@interface AddressBookCell : UITableViewCell
{
    UILabel     *_nameLabel;
    id<AddressBookCellDelegate>     _delegate;
}

@property (retain, nonatomic) UILabel   *nameLabel;
@property (assign, nonatomic) id<AddressBookCellDelegate>   delegate;

@end

@protocol AddressBookCellDelegate <NSObject>

-(void)addressBookButtonClicked;

@end
