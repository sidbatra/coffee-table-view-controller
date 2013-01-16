//
//  CustomLoadingView.m
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

#import "CustomLoadingView.h"

static NSString* const kImgAnimationFormat = @"cat-wait-%d.jpg";
static NSInteger const kAnimationFrames = 19;
static NSInteger const kSpinnerSize = 20;


@interface CustomLoadingView()

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CustomLoadingView

//----------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
        
        [self createImageView];
        [self createText];
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)createImageView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40,
                                                                           (self.frame.size.height - 135) / 2 - 21,
                                                                           240,
                                                                           135)];
    

    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:kAnimationFrames];
    
    for(NSInteger i=0; i<kAnimationFrames ; i++)
        [frames addObject:[UIImage imageNamed:[NSString stringWithFormat:kImgAnimationFormat,i+1]]];
    
    imageView.animationImages = frames;
    imageView.animationDuration = 0;
    
    [imageView startAnimating];
    
	[self addSubview:imageView];
}

//----------------------------------------------------------------------------------------------------
- (void)createText {
    
    UILabel *messageLabel			= [[UILabel alloc]
                                       initWithFrame:CGRectMake(0,self.frame.size.height / 2 - 10 + 68,self.frame.size.width,20)];
	messageLabel.backgroundColor	= [UIColor clearColor];
	messageLabel.font				= [UIFont fontWithName:@"HelveticaNeue" size:17];
	messageLabel.textColor			= [UIColor colorWithRed:0.454 green:0.454 blue:0.454 alpha:1.0];
	messageLabel.textAlignment		= NSTextAlignmentCenter;
	messageLabel.text				= @"Loading...";
    
	[self addSubview:messageLabel];
}





//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CLoadingViewProtocol

//----------------------------------------------------------------------------------------------------
- (void)hide {
    self.hidden = YES;
}

//----------------------------------------------------------------------------------------------------
- (void)show {
    self.hidden = NO;
}
@end