//
//  messageCell.h
//  certne
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageCell : UITableViewCell<UITextFieldDelegate>
{
}

@property (retain, nonatomic) UIButton      *headImageButton;
@property (retain, nonatomic) UITextField   *nameTextField;
@property (retain, nonatomic) UILabel       *titleLabel;

-(void)setNameTextFieldText:(NSString *)name;
-(void)setTitleLabelText:(NSString *)title;
-(void)setHeadImageButtonImage:(UIImage *)image;
-(void)cleanCompents;

@end
