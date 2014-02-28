//
//  setMessageCell.h
//  certne
//
//  Created by apple on 13-5-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setMessageCell : UITableViewCell

@property (retain, nonatomic) UIButton *testButton;
@property (retain, nonatomic) UILabel  *titleLabel;
@property (retain, nonatomic) UILabel  *contentLabel;

/**
 *	@brief	设置按钮背景
 *
 *	@param 	image 	图片
 */
-(void)setButtonBackGroundImage:(UIImage *)image;

/**
 *	@brief	 设置标题
 *
 *	@param 	title 	标题
 */
-(void)setTitleLabelText:(NSString *)title;

/**
 *	@brief	设置内容
 *
 *	@param 	content 	内容
 */
-(void)setContentLabelText:(NSString *)content;

@end
