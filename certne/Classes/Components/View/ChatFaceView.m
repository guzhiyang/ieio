//
//  ChatFaceView.m
//  certne
//
//  Created by apple on 13-6-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChatFaceView.h"
#import "ChatViewController.h"

@implementation ChatFaceView
@synthesize faceScrollView     = _faceScrollView;
@synthesize facePageControl    = _facePageControl;
@synthesize addImageButton     = _addImageButton;
@synthesize phraseArray        = _phraseArray;
@synthesize chatViewController = _chatViewController;
@synthesize faceString         = _faceString;

#pragma mark- View lifecycle methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _faceScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, 320, 135)];
        _faceScrollView.contentSize=CGSizeMake(960, 135);
        _faceScrollView.showsHorizontalScrollIndicator=NO;
        _faceScrollView.scrollEnabled=YES;
        _faceScrollView.pagingEnabled=YES;
        _faceScrollView.delegate=self;
        [self addSubview:_faceScrollView];
        
        _facePageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 145, 320, 21)];
        _facePageControl.numberOfPages=3;
        _facePageControl.currentPage=0;
        [self addSubview:_facePageControl];
        
        _addImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setFrame:CGRectMake(0, 176, 320, 40)];
        [_addImageButton setBackgroundColor:[UIColor cyanColor]];
        [_addImageButton setTitle:@"添加文件" forState:UIControlStateNormal];
        [self addSubview:_addImageButton];
        
        _phraseArray=[[NSMutableArray alloc]init];
        for (int i=0; i<72; i++) {
            UIImage *faceImage=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
            NSMutableArray *dictionaryFace = (NSMutableArray *)[NSMutableDictionary dictionary];
            [dictionaryFace setValue:faceImage forKey:[NSString stringWithFormat:@"[/%d]",i]];
            [self.phraseArray addObject:dictionaryFace];
            
            self.backgroundColor=[UIColor darkGrayColor];
        }
        [self showEmojiView];
    }
    return self;
}

-(void)showEmojiView
{
    int xIndex=0;
    
    int yIndex=0;
    
    int emojiRangeArray[]={0,10,20,30,40,50,60,70,71};
    
    for (int j=0; j<8; j++)
    {
        
        int startIndex=emojiRangeArray[j];
        int endIndex=emojiRangeArray[j+1];
        
        for (int i=startIndex; i<endIndex; i++)
        {
            UIButton *tempButton=[UIButton buttonWithType:UIButtonTypeCustom];
            
            tempButton.frame=CGRectMake(xIndex*40, 10+yIndex*44, 32, 32);
            NSMutableDictionary *tempDic=[_phraseArray objectAtIndex:i];
            UIImage *tempImage=[tempDic valueForKey:[NSString stringWithFormat:@"[/%d]",i]];
            [tempButton setBackgroundImage:tempImage forState:UIControlStateNormal];
            tempButton.tag=i;
            
            [tempButton addTarget:self action:@selector(didSelectFace:) forControlEvents:UIControlEventTouchUpInside];
            [_faceScrollView addSubview:tempButton];
            
            yIndex += 1;
            if (yIndex==3)
            {
                yIndex=0;
                xIndex+=1;
            }

        }
    }
}

-(void)didSelectFace:(id)sender
{
    UIButton *tempBtn=(UIButton *)sender;
    NSMutableDictionary *temDic=[_phraseArray objectAtIndex:tempBtn.tag];
    NSArray *tempArray=[temDic allKeys];
    _faceString=[NSString stringWithFormat:@"%@",[tempArray objectAtIndex:0]];
    
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(sendTextToChatViewController:)]) {
            [_delegate sendTextToChatViewController:self];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page=_faceScrollView.contentOffset.x/300;
    _facePageControl.currentPage=page;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

-(void)changePage:(id)sender
{
    int page=_facePageControl.currentPage;
    [_faceScrollView setContentOffset:CGPointMake(320*page, 0)];
}

#pragma mark- Memory management methods

-(void)dealloc
{
    [_faceScrollView release];
    [_facePageControl release];
    [_phraseArray release];
    [_faceString release];
    
    _faceString      = nil;
    _phraseArray     = nil;
    _facePageControl = nil;
    _faceScrollView  = nil;
    [super dealloc];
}

@end
