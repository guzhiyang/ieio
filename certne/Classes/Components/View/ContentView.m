//
//  ContentView.m
//  certne
//
//  Created by apple on 13-8-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
@synthesize delegate=_delegate;
@synthesize panGestureRecognizer=_panGestureRecognizer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInContentView:)];
    }
    return self;
}

-(void)dealloc
{
    [_panGestureRecognizer release];
    _panGestureRecognizer=nil;
    _delegate=nil;
    [super dealloc];
}

@end
