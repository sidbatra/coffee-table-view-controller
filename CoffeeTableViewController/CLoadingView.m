//
//  CLoadingView.m
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

#import "CLoadingView.h"

//#import "CDevice.h"

static NSInteger const kSpinnerSize     = 20;

/**
 * Private method and property declarations
 */
@interface CLoadingView()

- (void)createSpinner;
- (void)createText;

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CLoadingView

//----------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
        
        [self createSpinner];
        [self createText];
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)createSpinner {

    UIActivityIndicatorView *spinner	= [[UIActivityIndicatorView alloc]
                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	//spinner.frame	= CGRectMake(113,([CDevice sharedCDevice].screenHeightMinusStatusBar - kSpinnerSize) / 2 - [CDevice sharedCDevice].navBarHeight - 6,kSpinnerSize,kSpinnerSize);
    
    [spinner startAnimating];
	
	[self addSubview:spinner];	
}

//----------------------------------------------------------------------------------------------------
- (void)createText {
    
    UILabel *messageLabel = nil;
    //UILabel *messageLabel			= [[UILabel alloc]
    //                                    initWithFrame:CGRectMake(138.5,[CDevice sharedCDevice].screenHeightMinusStatusBar / 2 - [CDevice sharedCDevice].navBarHeight - 10 - 6,90,20)];
	messageLabel.backgroundColor	= [UIColor clearColor];
	messageLabel.font				= [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];	
	messageLabel.textColor			= [UIColor colorWithRed:0.454 green:0.454 blue:0.454 alpha:1.0];
	messageLabel.textAlignment		= NSTextAlignmentLeft;
	messageLabel.text				= @"Loading...";
    
	[self addSubview:messageLabel];
}

@end
