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
    
    CTableViewDataSource *_tableViewDataSource;
    
    UIView<CLoadingViewProtocol> *_loadingView;
    UIView<CErrorViewProtocol> *_errorView;
}

/**
 * Overrideable datasource for populating the table view.
 */
@property (nonatomic,strong) CTableViewDataSource *tableViewDataSource;

/**
 * View displayed when table view goes into loading state. Overrideable using
 * the tableLoadingView method.
 */
@property (nonatomic,strong) UIView<CLoadingViewProtocol> *loadingView;

/**
 * View displayed when table view goes into error state. Overrideable using the
 * tableErrorView method.
 */
@property (nonatomic,strong) UIView<CErrorViewProtocol> *errorView;


/**
 * Forces the table view data source to initiate a refresh.
 */
- (void)forceRefresh;

/**
 * Scroll the table view to the top.
 */
- (void)scrollToTop;

/**
 * Scroll the table view to the bottom.
 */
- (void)scrollToBottomWithAnimation:(BOOL)animated;

/**
 * Disable and hide pull to refresh UI.
 */
- (void)hidePullToRefresh;

/**
 * Whether the table view is displaying a supporting error or loading view (NO) or the
 * table view cells are being displayed (YES).
 */
- (BOOL)isDisplayingCells;

/**
 * Create a mapping between a model class and it's presenter.
 */
- (void)addModelPresenterForClass:(Class)class 
                        withStyle:(NSInteger)style
                    withPresenter:(Class)presenter;

/**
 * To update the UI of visible cells, pass the object class that is updated, along with a unique id
 * and the attribute key which is modified.
 */
- (void)provideResourceToVisibleCells:(Class)objectClass
                             objectID:(NSInteger)objectID
                            objectKey:(NSString*)objectKey;

/**
 * Template method to be overidden for a custom loading view which must conform to
 * the CLoadingViewProtocol.
 */
- (UIView<CLoadingViewProtocol>*)tableLoadingView;

/**
 * Template method to be overidden for a custom error view which must conform to
 * the CErrorViewProtocol.
 */
- (UIView<CErrorViewProtocol>*)tableErrorView;

/**
 * Adjust Y positioning of the supporting views - error or loading views.
 */
- (void)adjustSupportingViewsY:(CGFloat)delta;

@end

