//
//  UserCell.h
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

#import "UserCell.h"
#import <QuartzCore/QuartzCore.h>

NSInteger const kUserCellHeight = 51;



@interface UserCell() {
    UIImageView *userImageView;
    
    UILabel  *userNameLabel;
    UILabel  *userMessageLabel;
    UILabel *bottomBorder;
    
    UIButton *followButton;
        
    BOOL _highlighted;
}

@property (nonatomic,assign) BOOL highlighted;

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation UserCell

@synthesize userID      = _userID;
@synthesize delegate    = _delegate;
@synthesize highlighted = _highlighted;

//----------------------------------------------------------------------------------------------------
- (id)initWithStyle:(UITableViewCellStyle)style 
	reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
				reuseIdentifier:reuseIdentifier];
	
    if (self) {        
        self.contentView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
        
        [self createBorders];
        [self createUserImageView];
        [self createUserNameLabel];
        [self createUserMessageLabel];
        [self createFollowButton];
        
		self.selectionStyle = UITableViewCellSelectionStyleBlue;	
	}
	
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)resetUI {
    userImageView.image = nil;
}

//----------------------------------------------------------------------------------------------------
- (void)createBorders {
    //UILabel *topBorder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width,1)];
    //topBorder.backgroundColor = [UIColor colorWithRed:0.972 green:0.972 blue:0.972 alpha:1.0];

    //[self.contentView addSubview:topBorder];
    
    
    bottomBorder = [[UILabel alloc] initWithFrame:CGRectMake(0, kUserCellHeight-1, self.contentView.frame.size.width,1)];
    bottomBorder.backgroundColor = [UIColor colorWithRed:0.862 green:0.862 blue:0.862 alpha:1.0];
    
    [self.contentView addSubview:bottomBorder];
}

//----------------------------------------------------------------------------------------------------
- (void)createUserImageView {
    userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
    userImageView.backgroundColor = [UIColor colorWithRed:0.862 green:0.862 blue:0.862 alpha:1.0];
    //userImageView.layer.cornerRadius = 3;
    //userImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:userImageView];
}

//----------------------------------------------------------------------------------------------------
- (void)createUserNameLabel {
    userNameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60,10,158,30)];
    
    userNameLabel.backgroundColor    = [UIColor clearColor];
    userNameLabel.font               = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    userNameLabel.textColor          = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    userNameLabel.highlightedTextColor  = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    userNameLabel.textAlignment      = NSTextAlignmentLeft;
    //userNameLabel.layer.shadowColor  = [UIColor colorWithRed:0.972 green:0.972 blue:0.972 alpha:1.0].CGColor;
    //userNameLabel.layer.shadowOffset = CGSizeMake(0,1);
    //userNameLabel.layer.shadowRadius = 0;
    //userNameLabel.layer.shadowOpacity = 1.0;
    
    [self.contentView addSubview:userNameLabel];
}

//----------------------------------------------------------------------------------------------------
- (void)createUserMessageLabel {
    userMessageLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60,22,158,24)];
    
    userMessageLabel.backgroundColor        = [UIColor clearColor];
    userMessageLabel.font                   = [UIFont fontWithName:@"HelveticaNeue" size:11];
    userMessageLabel.textColor              = [UIColor colorWithRed:0.5372 green:0.5372 blue:0.5372 alpha:1.0];
    userMessageLabel.highlightedTextColor   = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    userMessageLabel.textAlignment          = NSTextAlignmentLeft;
    userMessageLabel.hidden                 = YES;
    
    [self.contentView addSubview:userMessageLabel];
}

//----------------------------------------------------------------------------------------------------
- (void)createFollowButton {
    followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    followButton.frame = CGRectMake(224,12,83,25);
    
    [followButton setBackgroundImage:[UIImage imageNamed:@"list-btn-follow-off.png"]
                            forState:UIControlStateNormal];
    
    [followButton setBackgroundImage:[UIImage imageNamed:@"list-btn-follow-on.png"]
                            forState:UIControlStateHighlighted];
    
    [followButton addTarget:self
                     action:@selector(didTouchUpInsideFollowButton:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:followButton];
}

//----------------------------------------------------------------------------------------------------
- (void)setUserImage:(UIImage*)image {
    userImageView.image = image;
}

//----------------------------------------------------------------------------------------------------
- (void)setUserName:(NSString*)userName {
    userNameLabel.text = userName;
}

//----------------------------------------------------------------------------------------------------
- (void)setUserName:(NSString*)userName
         andMessage:(NSString*)message {
    
    userNameLabel.frame     = CGRectMake(60,02,158,30);
    userNameLabel.font      = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    userNameLabel.text      = userName;
    
    userMessageLabel.text   = message;
    userMessageLabel.hidden = NO;
}

//----------------------------------------------------------------------------------------------------
- (void)setHighlighted:(BOOL)highlighted
			  animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
	
     if(highlighted && !self.highlighted) {
         self.highlighted = YES;
         bottomBorder.backgroundColor = [UIColor colorWithRed:0.862 green:0.862 blue:0.862 alpha:1.0];
     }
     else if(!highlighted && self.highlighted) {
         self.highlighted = NO;
     }
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UI Events

//----------------------------------------------------------------------------------------------------
- (void)didTouchUpInsideFollowButton:(UIButton*)button {
    [self.delegate userCellFollowButtonClicked:self.userID];
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Static methods

//----------------------------------------------------------------------------------------------------
+ (NSInteger)heightForCell {
    return kUserCellHeight;
}



@end
