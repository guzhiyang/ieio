//
//  PromptsLabel.m
//  certne
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PromptsLabel.h"

static PromptsLabel *kPromptsLabel=nil;

@implementation PromptsLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"prompts_msg.png"]];
    }
    return self;
}

+(PromptsLabel *)sharePromptsLabel
{
    if (kPromptsLabel==nil) {
        kPromptsLabel=[[PromptsLabel alloc] init];
        kPromptsLabel.font=[UIFont boldSystemFontOfSize:12];
        kPromptsLabel.textColor=[UIColor whiteColor];
        kPromptsLabel.textAlignment=NSTextAlignmentCenter;
//        if (kPromptsLabel.promptsNumber==0) {
//            kPromptsLabel.hidden=YES;
//        }else
//            kPromptsLabel.hidden=NO;
    }
    return kPromptsLabel;
}

+(void)releasePromptsLabel
{
    [kPromptsLabel release];
}

-(void)dealloc
{
    [super dealloc];
}

@end
