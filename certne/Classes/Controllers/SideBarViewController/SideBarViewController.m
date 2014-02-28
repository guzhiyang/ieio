//
//  SideBarViewController.m
//  certne
//
//  Created by apple on 13-5-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SideBarViewController.h"
#import "certneCardAppDelegate.h"
#import "leftMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SideBarViewController ()<SiderBarDelegate>

@property (retain, nonatomic) leftMenuViewController   *leftSideBarViewController;

@end

@implementation SideBarViewController
{
    UIViewController  *currentMainController;//--检测当前加载的视图控制器
    UITapGestureRecognizer *tapGestureRecognizer;//--点击视图动作
    UIPanGestureRecognizer *panGestureReconginzer;//--拖动视图动作
//    BOOL sideBarShowing;
    CGFloat currentTranslate;//--偏移距离
}
static  SideBarViewController *rootViewCon;
const int ContentOffset           = 100;
const int ContentMinOffset        = 60;
const float MoveAnimationDuration = 0.2;//--动画的移动时间
int clickNum = 0;//--单击次数计数器

@synthesize sideBarShowing = _sideBarShowing;

+ (id)share
{
    return rootViewCon;
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
        
    if (rootViewCon) {
        rootViewCon = nil;
    }
    _sideBarShowing = NO;
    currentTranslate = 0;
    _contentView.layer.shadowOffset  = CGSizeMake(0, 0);
    _contentView.layer.shadowColor   = [UIColor blackColor].CGColor;
    _contentView.layer.shadowOpacity = 1.0;
    
    leftMenuViewController *left=[[leftMenuViewController alloc]init];
    left.delegate = self;
    _leftSideBarViewController = left;
    [_navBackView addSubview:_leftSideBarViewController.view];
    
    panGestureReconginzer  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInContentView:)];
    panGestureReconginzer.delegate = self;
    [self.contentView addGestureRecognizer:panGestureReconginzer];
}

#pragma mark-(LeftMenuViewController)SideBar delegate methods

- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    if (direction!=SideBarShowDirectionNone)
    {
        UIView *view ;
        view = self.leftSideBarViewController.view;
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}

- (void)leftSideBarSelectWithController:(UIViewController *)controller
{
    //--给contentView 添加ViewController 并关闭sideBar
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    
    if (currentMainController == nil) {
		controller.view.frame = self.contentView.bounds;
		currentMainController = controller;
		[self addChildViewController:currentMainController];
		[self.contentView addSubview:currentMainController.view];
		[currentMainController didMoveToParentViewController:self];
	}
    else if (currentMainController != controller && controller !=nil) {
		controller.view.frame = self.contentView.bounds;
		[currentMainController willMoveToParentViewController:nil];
		[self addChildViewController:controller];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:currentMainController
						  toViewController:controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[currentMainController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
									currentMainController = controller;
								}
         ];
	}
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}

#pragma mark-PanGesture methods

//--有时候上面的视图没有完全划过来 
- (void)panInContentView:(UIPanGestureRecognizer *)panGesture
{
    //CGPoint  point=[abc locationInView:self.view];//--point 是不断随手指移动的位置坐标 全是正的
    CGPoint  point=[panGesture translationInView:self.contentView];//--point 是相对与起始点的坐标 有正负

    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (point.x<0 && !_sideBarShowing) {
                return;
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            if (point.x<0 && !_sideBarShowing) {
                return;
            }
    
            CGFloat translation = [panGesture translationInView:self.contentView].x;
            self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);//--只是水平移动
            
            UIView *view ;
            if (translation + currentTranslate>0)
            {
                view = self.leftSideBarViewController.view;
            }else 
            {
                view = self.contentView;
            }
            [self.navBackView bringSubviewToFront:view];//--给下面的视图加载View
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            if (point.x<0 && !_sideBarShowing) {
                return;
            }
            
            currentTranslate = self.contentView.transform.tx;//--确定手势结束之后的当前contentView移动的距离
            
            //--sideBar没有展示和展示出来的情况判断
            if (!_sideBarShowing) {
                if (fabs(currentTranslate)<ContentMinOffset) {
                    //--fabs是将currentTranslate的值转化为double
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                }else if(currentTranslate > ContentMinOffset)
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                }
                else{
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:0.1];
                }
            }
            else{
                if (fabs(currentTranslate)<(ContentOffset-ContentMinOffset))
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                }
                else if(currentTranslate>(ContentOffset-ContentMinOffset))
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                }
                else{
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:0.1];
                }
            }
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        {
            currentTranslate = self.contentView.transform.tx;//--确定手势结束之后的当前contentView移动的距离
            //--sideBar没有展示和展示出来的情况判断
            if (!_sideBarShowing) {
                if (fabs(currentTranslate)<ContentMinOffset) {
                    //--fabs是将currentTranslate的值转化为double
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                }else if(currentTranslate>ContentMinOffset)
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                }
                else{
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:0.1];
                }
            }
            else{
                if (fabs(currentTranslate)<ContentOffset-ContentMinOffset)
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                }
                else if(currentTranslate>ContentOffset-ContentMinOffset)
                {
                    [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                }
                else{
                    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:0.1];
                }
            }
            break;
        }
            
        case UIGestureRecognizerStateFailed:
            break;
            
        default:
            break;
    }
}

- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            //--如何让view定住不移动,可能需要更改pan手势
            case SideBarShowDirectionNone:
            {
                self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            default:
                break;
        }
	};
    
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
            if (tapGestureRecognizer) {
                [self.contentView removeGestureRecognizer:tapGestureRecognizer];
                tapGestureRecognizer = nil;
            }
            _sideBarShowing = NO;    
        }
        else
        {
            [self contentViewAddTapGestures];
            _sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
	};
    
    //--用户事件队列是先清除，然后再加上去的
    self.contentView.userInteractionEnabled = NO;//--清除和用户交互的事件队列（包括点击事件和键盘）
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];//--UIView 指定执行时间执行动画 完成后指定一个结果
}

#pragma mark- PanGesture delegate methods

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (!gestureRecognizer.enabled) {
        return NO;
    }
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark-Add TapGesture and methods

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    clickNum++;
//}

- (void)contentViewAddTapGestures
{
    if (tapGestureRecognizer) {
        [self.contentView   removeGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer = nil;
    }
    
    tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//    if (clickNum==1) {
//        [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//        _sideBarShowing=YES;
//    }else if(clickNum%2==0 && (clickNum>2)){
//        [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//        _sideBarShowing=NO;
//    }else if(clickNum%2==1 && (clickNum>1)){
//        [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//        _sideBarShowing=YES;
//    }
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    //-- SideBarViewController一直加载在内存中没有释放
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_leftSideBarViewController release];
    [_navBackView release];
    [_contentView release];
    [panGestureReconginzer release];
    [tapGestureRecognizer release];
    
    _navBackView=nil;
    _contentView=nil;
    _leftSideBarViewController=nil;
    currentMainController=nil;
    
    [super dealloc];
}

@end
