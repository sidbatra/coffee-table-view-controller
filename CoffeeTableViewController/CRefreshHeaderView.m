//
//  CRefreshHeaderView.m
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

#import "CRefreshHeaderView.h"

@interface CRefreshHeaderView() {
    EGORefreshTableHeaderView   *_egoRefreshView;
}

@property (nonatomic,strong) EGORefreshTableHeaderView *egoRefreshView;

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CRefreshHeaderView

@synthesize egoRefreshView  = _egoRefreshView;
@synthesize delegate        = _delegate;


//----------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.egoRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f,frame.size.width,frame.size.height)];
        self.egoRefreshView.delegate = self;
        
        [self addSubview:self.egoRefreshView];
    }
    
    return self;
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CRefreshHeaderViewProtocol

//----------------------------------------------------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[self.egoRefreshView egoRefreshScrollViewDidScroll:scrollView];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView {
	[self.egoRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

//----------------------------------------------------------------------------------------------------
- (void)scrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [self.egoRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:scrollView];
}



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate

//----------------------------------------------------------------------------------------------------
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self.delegate refreshHeaderDidTriggerRefresh:self];
}

//----------------------------------------------------------------------------------------------------
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return [self.delegate refreshTableHeaderDataSourceIsLoading:self];
}

//----------------------------------------------------------------------------------------------------
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return [self.delegate refreshTableHeaderDataSourceLastUpdated:self];
}


@end
