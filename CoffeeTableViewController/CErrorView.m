//
//  CErrorView.m
//
//  Created by Siddharth Batra
//  Copyright 2013. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CErrorView.h"

static NSInteger const kSpinnerSize     = 20;
static NSString* const kImgRefresh      = @"refresh-gray.png";
static NSString* const kMsgRefreshText  = @"Try again";



@interface CErrorView()

- (void)createText;
- (void)createRefreshImage;
- (void)createRefreshText;
- (void)createViewButton;

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CErrorView

@synthesize delegate = _delegate;

//----------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor =  [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
        
        [self createText];
        [self createRefreshImage];
        [self createRefreshText];
        [self createViewButton];
        
        [self hide];
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)createText {
    
    messageLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                               self.frame.size.height / 2 -10 - 14 - 19,
                                                                               self.frame.size.width,
                                                                               20)];	
	messageLabel.backgroundColor	= [UIColor clearColor];
	messageLabel.font				= [UIFont fontWithName:@"HelveticaNeue" size:17];	
	messageLabel.textColor			= [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
	messageLabel.textAlignment		= NSTextAlignmentCenter;
    
	[self addSubview:messageLabel];
}

//----------------------------------------------------------------------------------------------------
- (void)createRefreshImage {
    refreshImageView                    = [[UIImageView alloc] initWithFrame:CGRectMake(116.5,
                                                                                        self.frame.size.height / 2 - 14,
                                                                                        13,
                                                                                        15)];
	refreshImageView.image              = [UIImage imageNamed:kImgRefresh];
	
	[self addSubview:refreshImageView];
}

//----------------------------------------------------------------------------------------------------
- (void)createRefreshText {
    refreshLabel                    = [[UILabel alloc] initWithFrame:CGRectMake(138.5,
                                                                                 self.frame.size.height / 2 - 14 - 2,
                                                                                 90,
                                                                                 20)];	
	refreshLabel.backgroundColor	= [UIColor clearColor];
	refreshLabel.font				= [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];	
	refreshLabel.textColor			= [UIColor colorWithRed:0.454 green:0.454 blue:0.454 alpha:1.0];
	refreshLabel.textAlignment		= NSTextAlignmentLeft;
    refreshLabel.text               = kMsgRefreshText;
    
	[self addSubview:refreshLabel];
}

//----------------------------------------------------------------------------------------------------
- (void)createViewButton {
    viewButton          = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame    = self.frame;
    
    [viewButton addTarget:self
                   action:@selector(didTapViewButton:)
         forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:viewButton];
}



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CErrorViewProtocol

//----------------------------------------------------------------------------------------------------
- (void)setErrorMessage:(NSString *)message {
    messageLabel.text = message;
}

//----------------------------------------------------------------------------------------------------
- (void)hide {
    refreshLabel.hidden     = YES;
    refreshImageView.hidden = YES;
    viewButton.enabled      = NO;
    
    self.hidden = YES;
}

//----------------------------------------------------------------------------------------------------
- (void)showWithRefreshUI:(BOOL)showRefreshUI {
    
    if(showRefreshUI) {
        refreshLabel.hidden     = NO;
        refreshImageView.hidden = NO;
        viewButton.enabled      = YES;
    }
    
    self.hidden = NO;
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UI Events

//----------------------------------------------------------------------------------------------------
- (void)didTapViewButton:(UIButton*)button {
    
    SEL sel = @selector(errorViewTouched);
    
    if(![self.delegate respondsToSelector:sel])
        return;
    
    [self.delegate errorViewTouched];
}


@end
