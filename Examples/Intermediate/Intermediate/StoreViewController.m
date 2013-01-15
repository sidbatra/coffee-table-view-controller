//
//  StoreViewController.m
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

#import "StoreViewController.h"
#import "StoreViewDataSource.h"
#import "UserPresenter.h"
#import "User.h"
#import "StorePresenter.h"
#import "Store.h"
#import "MessagePresenter.h"
#import "Message.h"


@interface StoreViewController ()

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation StoreViewController

//----------------------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    
    if(self) {
        
        [self addModelPresenterForClass:[Store class]
                              withStyle:kModelPresenterDefaultStyle
                          withPresenter:[StorePresenter class]];

        [self addModelPresenterForClass:[User class]
                              withStyle:kUserPresenterStyleWithByline //TIP: Try replacing with kModelPresenterDefaultStyle
                          withPresenter:[UserPresenter class]];
        
        [self addModelPresenterForClass:[Message class]
                              withStyle:kModelPresenterDefaultStyle
                          withPresenter:[MessagePresenter class]];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userImageLoaded:)
                                                     name:kNUserImageLoaded
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(storeImageLoaded:)
                                                     name:kNStoreImageLoaded
                                                   object:nil];
        
        
        self.tableViewDataSource = [[StoreViewDataSource alloc] init];
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
    
    [(StoreViewDataSource*)self.tableViewDataSource loadDelayedData];
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
- (void)storeImageLoaded:(NSNotification*)notification {
    [self provideResourceToVisibleCells:notification.object
                             updatedKey:@"image"];
}

//----------------------------------------------------------------------------------------------------
- (void)userImageLoaded:(NSNotification*)notification {
    [self provideResourceToVisibleCells:notification.object
                             updatedKey:@"image"];
}

@end
