//
//  MessageCell.m
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

#import "MessageCell.h"

@interface MessageCell() {
    UILabel  *messageLabel;
}
@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation MessageCell

//----------------------------------------------------------------------------------------------------
- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
				reuseIdentifier:reuseIdentifier];
	
    if (self) {
        self.contentView.clipsToBounds = YES;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.contentView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        [self createMessageLabel];
	}
	
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)createMessageLabel {
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,20,self.frame.size.width,30)];
    
    messageLabel.numberOfLines        = 1;
    messageLabel.backgroundColor      = [UIColor clearColor];
    messageLabel.font                 = [UIFont fontWithName:@"HelveticaNeue" size:13];
    messageLabel.textColor            = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    messageLabel.highlightedTextColor = [UIColor whiteColor];
    messageLabel.textAlignment        = NSTextAlignmentCenter;
    
    [self.contentView addSubview:messageLabel];
}

//----------------------------------------------------------------------------------------------------
- (void)setText:(NSString *)text {
    messageLabel.text = text;
}

//----------------------------------------------------------------------------------------------------
+ (NSInteger)height {
    return 60;
}

@end
