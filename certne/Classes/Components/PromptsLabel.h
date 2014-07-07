//
//  PromptsLabel.h
//  certne
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptsLabel : UILabel
{
    NSInteger   _promptsNumber;
}

@property (assign, nonatomic) NSInteger     promptsNumber;


+(PromptsLabel *)sharePromptsLabel;
+(void)releasePromptsLabel;

@end
