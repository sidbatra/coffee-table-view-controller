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

#import <UIKit/UIKit.h>

@class User;
@protocol UserCellDelegate;


@interface UserCell : UITableViewCell {
    NSInteger _userID;
    
    __weak id<UserCellDelegate> _delegate;
}

@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,weak) id<UserCellDelegate> delegate;

/**
 * Reset cell UI before changing the values.
 */
- (void)resetUI;

/**
 * Set the user image in the cell.
 */
- (void)setUserImage:(UIImage*)image;

/**
 * Set the user name in the cell.
 */
- (void)setUserName:(NSString*)userName;

/**
 * Set the user name and message in the cell
 */
- (void)setUserName:(NSString*)userName
         andMessage:(NSString*)message;


/**
 * Return the height of the cell.
 */
+ (NSInteger)heightForCell;

@end



@protocol UserCellDelegate

@required

- (void)userCellSelected:(User*)user;
- (void)userCellFollowButtonClicked:(NSInteger)userID;

@end

