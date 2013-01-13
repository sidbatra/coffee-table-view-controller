//
//  CErrorView.h
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

#import <UIKit/UIKit.h>

#import "CErrorViewProtocol.h"

@protocol CErrorViewDelegate;

/**
 * Generic view for displaying error messages
 */
@interface CErrorView : UIView<CErrorViewProtocol> {
    UILabel         *messageLabel;
    UILabel         *refreshLabel;
    
    UIButton        *viewButton;
    
    UIImageView     *refreshImageView;
    
    __weak id<NSObject,CErrorViewDelegate>    _delegate;
}

/**
 * Protocol less delegate allowing error view to
 * be easily interchaged throughout the app
 */
@property (nonatomic,weak) id<NSObject,CErrorViewDelegate> delegate;

@end


/**
 * Protocol for delegates of CErrorView
 */
@protocol CErrorViewDelegate

@optional

/**
 * Fired when the user touches anywhere on the error view.
 */
- (void)errorViewTouched;


@end
