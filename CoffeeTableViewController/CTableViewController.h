//
//  CTableViewController.h
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

#import "CTableViewDataSource.h"

#import "CErrorView.h"
#import "CErrorViewProtocol.h"

#import "CLoadingViewProtocol.h"

#import "EGORefreshTableHeaderView.h"



@interface CTableViewController : UITableViewController<CTableViewDataSourceDelegate,EGORefreshTableHeaderDelegate,CErrorViewDelegate> {
    
    CTableViewDataSource       *_tableViewDataSource;
    
    UIView<CLoadingViewProtocol> *_loadingView;
    UIView<CErrorViewProtocol> *_errorView;
}

/**
 * Custom overrideable datasource object for populating the table view.
 */
@property (nonatomic,strong) CTableViewDataSource *tableViewDataSource;

/**
 * View displayed when results are being fetched from the server
 */
@property (nonatomic,strong) UIView<CLoadingViewProtocol> *loadingView;

/**
 * View displayed when an error occurs
 */
@property (nonatomic,strong) UIView<CErrorViewProtocol> *errorView;


/**
 * Forces the data source to initiate a refresh
 */
- (void)forceRefresh;

/**
 * Scroll the table view to the top
 */
- (void)scrollToTop;

/**
 * Scroll the table view to the bottom.
 */
- (void)scrollToBottomWithAnimation:(BOOL)animated;

/**
 * Method to disable pull to refresh for certain table views
 */
- (void)disablePullToRefresh;

/**
 * Returns if the table view is in a normal state and is displaying cells
 */
- (BOOL)isDisplayingCells;

/**
 * Add a model presenter mapping.
 */
- (void)addModelPresenterForClass:(Class)class 
                        withStyle:(NSInteger)style
                    withPresenter:(Class)presenter;

/**
 * Pass the newly available resource to all visible cells to check
 * for possible UI updates
 */
- (void)provideResourceToVisibleCells:(Class)objectClass
                             objectID:(NSInteger)objectID
                            objectKey:(NSString*)objectKey;

/**
 * Template method which can be overriden for custom laoding views which is a UIView 
 * displayed while the data is being loaded
 */
- (UIView<CLoadingViewProtocol>*)tableLoadingView;

/**
 * Template method which can be overriden for custom error views which is a UIView 
 * displayed on error and follows the CErrorViewProtocol.
 */
- (UIView<CErrorViewProtocol>*)tableErrorView;

/**
 * Adjust Y positioning of the supporting views.
 */
- (void)adjustSupportingViewsY:(CGFloat)delta;

@end

