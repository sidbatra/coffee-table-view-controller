//
//  CTableViewDataSource.m
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

#import "CTableViewDataSource.h"

static NSInteger const kDefaultSections = 1;


/**
 * Select private methods and properties
 */
@interface CTableViewDataSource()

/**
 * Load the next page of objects
 */
- (void)paginate;

@end




//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation CTableViewDataSource

@synthesize objects     = _objects;
@synthesize delegate    = _delegate;

//----------------------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    
    if(self) {
        self.objects = [NSMutableArray array];
        
        
        /*[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(paginationCellReached:) 
													 name:kNPaginationCellReached
												   object:nil];*/
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)clean {
}

//----------------------------------------------------------------------------------------------------
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self clean];
}



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Retrieval

//----------------------------------------------------------------------------------------------------
- (NSInteger)totalSections {
    return kDefaultSections;
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)totalObjectsForSection:(NSInteger)section {
    return [self.objects count];
}

//----------------------------------------------------------------------------------------------------
- (id)objectAtIndex:(NSInteger)index 
         forSection:(NSInteger)section {
    
    return index < [self.objects count] ? [self.objects objectAtIndex:index] : nil;
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)indexForObject:(id)object {
    return [self.objects indexOfObject:object];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Modification

//----------------------------------------------------------------------------------------------------
- (void)addObject:(id)object 
          atIndex:(NSInteger)index
    withAnimation:(UITableViewRowAnimation)animation {
    
    [self.objects insertObject:object
                       atIndex:index];
    
    [self.delegate insertRowAtIndex:index 
                      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)addObjectAtEnd:(id)object
         withAnimation:(UITableViewRowAnimation)animation {
    
    [self addObject:object
            atIndex:[self.objects count]
      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)removeObject:(id)object 
       withAnimation:(UITableViewRowAnimation)animation {

    NSInteger index = [self indexForObject:object];
    
    if(index == NSNotFound)
        return;

    
    [self.objects removeObjectAtIndex:index];
    
    [self.delegate removeRowAtIndex:index 
                      withAnimation:animation];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Templates

//----------------------------------------------------------------------------------------------------
- (void)refreshInitiated {
    
}

//----------------------------------------------------------------------------------------------------
- (void)paginate {
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Notifications

//----------------------------------------------------------------------------------------------------
- (void)paginationCellReached:(NSNotification*)notification {
    if([notification object] == self) {
        [self paginate];
    }
}

@end
