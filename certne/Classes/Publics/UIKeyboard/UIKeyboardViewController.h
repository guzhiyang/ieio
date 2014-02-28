//
//  UIKeyboardViewController.h
//
//
//  Created by  YFengchen on 13-1-4.
//  Copyright 2013 __zhongyan__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardView.h"
#import "Foundation.h"

@protocol UIKeyboardViewControllerDelegate;

@interface UIKeyboardViewController : NSObject <UITextFieldDelegate, UIKeyboardViewDelegate, UITextViewDelegate> {
	CGRect keyboardBounds;
	UIKeyboardView *keyboardToolbar;
    id <UIKeyboardViewControllerDelegate> _boardDelegate;
    UIView *objectView;
}

@property (nonatomic, assign) id <UIKeyboardViewControllerDelegate> boardDelegate;

@end

@interface UIKeyboardViewController (UIKeyboardViewControllerCreation)

- (id)initWithControllerDelegate:(id <UIKeyboardViewControllerDelegate>)delegateObject;

@end

@interface UIKeyboardViewController (UIKeyboardViewControllerAction)

- (void)addToolbarToKeyboard;

@end

@protocol UIKeyboardViewControllerDelegate <NSObject>

@optional

/**
 *	@brief	文本框返回值
 *
 *	@param 	textField 	UITextField
 */
- (void)alttextFieldDidEndEditing:(UITextField *)textField;

/**
 *	@brief	文本视图返回值
 *
 *	@param 	textView 	UITextView
 */
- (void)alttextViewDidEndEditing:(UITextView *)textView;

/**
 *	@brief	完成按钮的点击事件
 *
 *	@param 	sender 	参数类型未知
 */
- (void)editDoneButtonClicked:(id)sender;

@end
