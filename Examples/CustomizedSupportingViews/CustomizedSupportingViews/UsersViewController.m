//
//  UsersViewController.m
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

#import "UsersViewController.h"
#import "UsersViewDataSource.h"
#import "UserPresenter.h"
#import "User.h"
#import "CustomLoadingView.h"

@interface UsersViewController ()

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation UsersViewController

//----------------------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    
    if(self) {

        [self addModelPresenterForClass:[User class]
                              withStyle:kUserPresenterStyleWithByline //TIP: Try replacing with kModelPresenterDefaultStyle
                          withPresenter:[UserPresenter class]];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userImageLoaded:)
                                                     name:kNUserImageLoaded
                                                   object:nil];
        
        
        self.tableViewDataSource = [[UsersViewDataSource alloc] init];
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//----------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    
    [(UsersViewDataSource*)self.tableViewDataSource loadDelayedUsers];
}

//----------------------------------------------------------------------------------------------------
- (UIView*)tableLoadingView {
    CGRect frame = self.view.frame;
    return [[CustomLoadingView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UserCell Events

//----------------------------------------------------------------------------------------------------
- (void)userCellSelected:(User*)user {
    NSLog(@"User clicked: %@",user.name);
}

//----------------------------------------------------------------------------------------------------
- (void)userCellFollowButtonClicked:(NSInteger)userID {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:[NSString stringWithFormat:@"Follow clicked for user id %d",userID]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Notifications

//----------------------------------------------------------------------------------------------------
- (void)userImageLoaded:(NSNotification*)notification {
    [self provideResourceToVisibleCells:notification.object
                             updatedKey:@"image"];
}

@end
