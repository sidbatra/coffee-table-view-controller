//
//  CTableViewController.m
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

#import "CTableViewController.h"
#import "CModelPresenterProtocol.h"
#import "CLoadingView.h"


NSInteger const kModelPresenterDefaultStyle = 0;


static NSString* const kModelKeyPresenter          = @"ModelKeyPresenter";
static NSString* const kModelKeyPresenterStyle     = @"ModelKeyPresenterStyle";
static NSString* const kModelKeyIdentifier         = @"ModelKeyIdentifier";
static NSString* const kPresenterClassSuffix       = @"Presenter";



@interface CTableViewController() {
    NSMutableDictionary         *_modelPresenters;
    
    BOOL                        _isPullToRefreshActive;
    BOOL                        _disablePullToRefresh;
}

/**
 * Holds a mapping of the Presenter class, Presenter style and Identifier
 * for each model class.
 */
@property (nonatomic,strong) NSMutableDictionary *modelPresenters;

@property (nonatomic,assign) BOOL isPullToRefreshActive;

@property (nonatomic,assign) BOOL disablePullToRefresh;


/**
 * Enable scrolling & bouncing for the table view
 */
- (void)enableScrolling;

/**
 * Disable scrolling & bouncing for the table view
 */
- (void)disableScrolling;

/**
 * Return the model presenter NSDictionary for the given object's class
 */
- (NSDictionary*)presenterForModel:(id)object;

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CTableViewController

@synthesize tableViewDataSource     = _tableViewDataSource;
@synthesize modelPresenters         = _modelPresenters;
@synthesize loadingView             = _loadingView;
@synthesize errorView               = _errorView;
@synthesize refreshHeaderView       = _refreshHeaderView;
@synthesize isPullToRefreshActive   = _isPullToRefreshActive;
@synthesize disablePullToRefresh    = _disablePullToRefresh;

 
//----------------------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    
    if (self) {
        self.modelPresenters = [NSMutableDictionary dictionary];
    }
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)dealloc {
    self.tableView  = nil;
}

//----------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
        
    CGRect frame		= self.view.frame;
	frame.origin.y		= 0; 
	self.view.frame		= frame;
    
    [self disableScrolling];

    self.tableView.backgroundColor  = [UIColor whiteColor];
	self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;

    
    self.tableViewDataSource.delegate = self;
    
    
    if(!self.refreshHeaderView && !self.disablePullToRefresh) {
        self.refreshHeaderView = [self tableRefreshHeaderView];
        self.refreshHeaderView.delegate = self;
    }
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    
    if(!self.loadingView)
        self.loadingView = [self tableLoadingView];
    
    [self.view addSubview:self.loadingView];
    
    
    if(!self.errorView)
        self.errorView = [self tableErrorView];
    
    [self.view addSubview:self.errorView];
}

//----------------------------------------------------------------------------------------------------
- (void)viewDidUnload {
    [super viewDidUnload];
}

//----------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Private interface


//----------------------------------------------------------------------------------------------------
- (void)provideResourceToVisibleCells:(id)updatedObject
                           updatedKey:(NSString*)updatedKey {
    
    if(![self isViewLoaded])
        return;
    
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    
	for (NSIndexPath *indexPath in visiblePaths) {            
        
        id object = [self.tableViewDataSource objectAtIndex:indexPath.row
                                                 forSection:indexPath.section];
        
        NSDictionary *presenter = [self presenterForModel:object];
        
        Class<CModelPresenterProtocol> modelPresenter = [presenter objectForKey:kModelKeyPresenter];
        NSInteger modelPresenterStyle = [(NSNumber*)[presenter objectForKey:kModelKeyPresenterStyle] integerValue];
        
        id cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        [modelPresenter updatePresentationForCell:cell
                                         ofObject:object
                            withPresentationStyle:modelPresenterStyle
                                withUpdatedObject:updatedObject
                                    andUpdatedKey:updatedKey];
    }
}

//----------------------------------------------------------------------------------------------------
- (void)enableScrolling {
    self.tableView.scrollEnabled    = YES;    
    self.tableView.bounces          = YES;
}

//----------------------------------------------------------------------------------------------------
- (void)disableScrolling {
    self.tableView.scrollEnabled    = NO;    
    self.tableView.bounces          = NO;
}

//----------------------------------------------------------------------------------------------------
- (NSDictionary*)presenterForModel:(id)object {
    return [self.modelPresenters objectForKey:NSStringFromClass([object class])];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Public interface

//----------------------------------------------------------------------------------------------------
- (void)adjustSupportingViewsY:(CGFloat)delta {
    CGRect frame = self.loadingView.frame;
    frame.origin.y -= delta;
    frame.size.height += delta;
    self.loadingView.frame = frame;
    
    frame = self.errorView.frame;
    frame.origin.y -= delta;
    frame.size.height += delta;
    self.errorView.frame = frame;
}

//----------------------------------------------------------------------------------------------------
- (UIView<CRefreshHeaderViewProtocol>*)tableRefreshHeaderView {
    UIView<CRefreshHeaderViewProtocol> *refreshHeaderView = [[CRefreshHeaderView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                  0.0f - self.tableView.bounds.size.height,
                                                                                  self.view.frame.size.width,
                                                                                  self.tableView.bounds.size.height)];
    refreshHeaderView.delegate = self;
    
    return refreshHeaderView;
}

//----------------------------------------------------------------------------------------------------
- (UIView<CLoadingViewProtocol>*)tableLoadingView {
    CGRect frame = self.view.frame;
    return [[CLoadingView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
}

//----------------------------------------------------------------------------------------------------
 - (UIView<CErrorViewProtocol>*)tableErrorView {
     CGRect frame = self.view.frame;
     
     CErrorView *errorView  = [[CErrorView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
     errorView.delegate      = self;
 
     return errorView;
}

//----------------------------------------------------------------------------------------------------
- (void)forceRefresh {
    [self.errorView hide];
    [self scrollToTop];
    [self.loadingView show];
    
    [self disableScrolling];
    
    [self.tableViewDataSource refreshInitiated];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollToTop {
    [self.tableView scrollRectToVisible:CGRectMake(0,0,1,1) 
                               animated:NO];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollToBottomWithAnimation:(BOOL)animated {
    NSInteger section = [self.tableViewDataSource totalSections]-1;
    
    
    if(![self.tableViewDataSource totalObjectsForSection:section])
        return;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self.tableViewDataSource totalObjectsForSection:section]-1
                                                inSection:section];
    
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop 
                                  animated:animated];
}

//----------------------------------------------------------------------------------------------------
- (void)hidePullToRefresh {
    self.disablePullToRefresh = YES;
    
    [self.refreshHeaderView removeFromSuperview];
    self.refreshHeaderView = nil;
}

//----------------------------------------------------------------------------------------------------
- (BOOL)isDisplayingCells {
    return self.errorView.hidden & self.loadingView.hidden;
}

//----------------------------------------------------------------------------------------------------
- (void)addModelPresenterForClass:(Class)class 
                        withStyle:(NSInteger)style
                    withPresenter:(Class)presenter {
    
    [self.modelPresenters setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                     presenter,kModelKeyPresenter,
                                     [NSNumber numberWithInteger:style],kModelKeyPresenterStyle,
                                     [NSString stringWithFormat:@"%@_%d",[presenter class],style], kModelKeyIdentifier, nil] forKey:NSStringFromClass([class class])];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UITableViewDataSource

//----------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableViewDataSource totalSections];
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tableViewDataSource totalObjectsForSection:section];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UITableViewDelegate

//----------------------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    id object = [self.tableViewDataSource objectAtIndex:indexPath.row
                                             forSection:indexPath.section];
    
    NSDictionary *presenter = [self presenterForModel:object];

    Class<CModelPresenterProtocol> modelPresenter = [presenter objectForKey:kModelKeyPresenter];
    NSInteger modelPresenterStyle = [(NSNumber*)[presenter objectForKey:kModelKeyPresenterStyle] integerValue];
    
    
	return [modelPresenter heightForObject:object
                     withPresentationStyle:modelPresenterStyle];
}

//----------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = [self.tableViewDataSource objectAtIndex:indexPath.row
                                         forSection:indexPath.section];
    
    NSDictionary *presenter = [self presenterForModel:object];
    
    Class<CModelPresenterProtocol> modelPresenter = [presenter objectForKey:kModelKeyPresenter];
    NSInteger modelPresenterStyle = [(NSNumber*)[presenter objectForKey:kModelKeyPresenterStyle] integerValue];
    NSString* modelIdentifier = [presenter objectForKey:kModelKeyIdentifier];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:modelIdentifier];
    
	return [modelPresenter cellForObject:object
                            withBaseCell:cell
                      withCellIdentifier:modelIdentifier
                            withDelegate:self
                    andPresentationStyle:modelPresenterStyle];
}

//----------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    id object = [self.tableViewDataSource objectAtIndex:indexPath.row
                                         forSection:indexPath.section];
    
    NSDictionary *presenter = [self presenterForModel:object];

    Class<CModelPresenterProtocol> modelPresenter = [presenter objectForKey:kModelKeyPresenter];
    NSInteger modelPresenterStyle = [(NSNumber*)[presenter objectForKey:kModelKeyPresenterStyle] integerValue];
    
    id cell = [self.tableView cellForRowAtIndexPath:indexPath];
    

    [modelPresenter cellClickedForObject:object
                            withBaseCell:cell
                   withPresentationStyle:modelPresenterStyle
                            withDelegate:self];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UIScrollViewDelegate

//----------------------------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{		
	[self.refreshHeaderView scrollViewDidScroll:scrollView];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[self.refreshHeaderView scrollViewDidEndDragging:scrollView];
}
 

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CTableViewDataSourceDelegate

//----------------------------------------------------------------------------------------------------
- (void)reloadTableView {
    [self enableScrolling];
    [self.loadingView hide];
    [self.errorView hide];
    
    [self.tableView reloadData];

    [self.refreshHeaderView scrollViewDataSourceDidFinishedLoading:self.tableView];
    self.isPullToRefreshActive = NO;
}

//----------------------------------------------------------------------------------------------------
- (void)displayError:(NSString *)message 
       withRefreshUI:(BOOL)showRefreshUI {
    
    [self.errorView setErrorMessage:message];
    [self.errorView showWithRefreshUI:showRefreshUI];
    
    [self scrollToTop];
    
    [self.loadingView hide];
    
    [self disableScrolling];
    
    
    [self.tableView reloadData];
    
    self.isPullToRefreshActive = NO;
    [self.refreshHeaderView scrollViewDataSourceDidFinishedLoading:self.tableView];
}
 
//----------------------------------------------------------------------------------------------------
- (void)insertRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex
           withAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index
                                                     inSection:sectionIndex];
    NSArray *indexPaths		= [NSArray arrayWithObjects:indexPath,nil];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)removeRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex
           withAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index
                                                 inSection:sectionIndex];
    
    if(!indexPath)
        return;
    
    
    NSArray *indexPaths		= [NSArray arrayWithObjects:indexPath,nil];
    
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)reloadRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex {
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index
                                                 inSection:sectionIndex];

    if(!indexPath || index >= [self.tableViewDataSource.objects count])
        return;
    
    
    NSArray *indexPaths		= [NSArray arrayWithObjects:indexPath,nil];
    
    [self.tableView reloadRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationNone];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollToRowAtIndex:(NSInteger)index
                forSection:(NSInteger)sectionIndex {
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index
                                                 inSection:sectionIndex];
    
    if(!indexPath || index >= [self.tableViewDataSource.objects count])
        return;
    
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop 
                                  animated:NO];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CRefreshHeaderViewDelegate

//----------------------------------------------------------------------------------------------------
- (void)refreshHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    self.isPullToRefreshActive = YES;
    [self.tableViewDataSource refreshInitiated];
}

//----------------------------------------------------------------------------------------------------
- (BOOL)refreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return self.isPullToRefreshActive;
}

//----------------------------------------------------------------------------------------------------
- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return nil;
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CErrorViewDelegate

//----------------------------------------------------------------------------------------------------
- (void)errorViewTouched {
    [self.loadingView show];
    [self.errorView hide];
    [self.tableViewDataSource refreshInitiated];
}

@end
