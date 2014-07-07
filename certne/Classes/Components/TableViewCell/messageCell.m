//
//  messageCell.m
//  certne
//
//  Created by apple on 13-5-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "messageCell.h"
#import "Foundation.h"

@implementation messageCell

@synthesize headImageButton;
@synthesize nameTextField;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //nameTextField 加载的是个人信息的内容
        nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, 220, 24)];
        [nameTextField setTextColor:[UIColor blackColor]];
        nameTextField.returnKeyType=UIReturnKeyDone;
        nameTextField.delegate=self;
        [nameTextField setBackgroundColor:[UIColor clearColor]];
        [nameTextField setTextAlignment:NSTextAlignmentLeft];
        [nameTextField setFont:[UIFont fontWithName:FONTNAME size:16]];
        [self.contentView addSubview:nameTextField];
        
        //titleLabel 加载的是个人信息的类型        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 34, 200, 16)];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [titleLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:titleLabel];
        
        //调换为按钮
        headImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [headImageButton setFrame:CGRectMake(20, 10, 40, 40)];
        [self.contentView addSubview:headImageButton];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
        lineView.backgroundColor=[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0f];
        [self.contentView addSubview:lineView];
        }
    return self;
}

-(void)cleanCompents
{
    self.nameTextField.text=nil;
    self.titleLabel.text=nil;
}

-(void)setHeadImageButtonImage:(UIImage *)image
{
    [self.headImageButton setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)setNameTextFieldText:(NSString *)name
{
    self.nameTextField.text=name;
}

-(void)setTitleLabelText:(NSString *)title
{
    self.titleLabel.text=title;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
