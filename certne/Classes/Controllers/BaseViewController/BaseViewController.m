//
//  BaseViewController.m
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark-View lifeStyle methods

-(id)init
{
    self = [super init];
    
    if (self) {
        self.isSideBarNavVC = NO;
    }
    
    return self;
}

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
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 64)];
    _navBarView.delegate = self;
    _navBarView.titleLabel.text = self.navViewTitle;
    [self.view addSubview:_navBarView];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [_navBarView settitleLabelText:self.navViewTitle];
    _navBarView.titleLabel.text = self.navViewTitle;
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    if (_isSideBarNavVC) {
        NSString *direction = [NSString stringWithFormat:@""];
        if ([Global shareGlobal].sideBarShowing) {
            direction = @"1";
        }else{
            direction = @"0";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:SidebarShowNotification object:direction];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        if (self.isViewLoaded && self.view.window == nil) {
            [self viewWillUnload];
            self.view = nil;
            [self viewDidUnload];
        }
    }
}

-(void)dealloc
{
}

@end
