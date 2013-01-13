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

static NSInteger const kDefaultTotalSections = 1;



@interface CTableViewDataSource()

/**
 * Template method called to load the next page of objects. Override in your implmentation.
 * Launch this method via a notification to the default center.... TODO
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
    return [self initWithNumberOfSections:kDefaultTotalSections];
}

//----------------------------------------------------------------------------------------------------
- (id)initWithNumberOfSections:(NSInteger)numberOfSections {
    self = [super init];
    
    if(self) {
        self.objects = [NSMutableArray arrayWithCapacity:numberOfSections];
        
        for(NSInteger i=0 ; i<numberOfSections ; i++)
            [self.objects addObject:[NSMutableArray array]];
        
        
        /*[[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(paginationCellReached:)
         name:kNPaginationCellReached
         object:nil];*/
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Retrieval

//----------------------------------------------------------------------------------------------------
- (NSInteger)totalSections {
    return self.objects.count;
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)totalObjects {
    NSInteger count = 0;
    
    for(NSInteger i=0 ; i<self.totalSections ; i++)
        count += [self sectionAtIndex:i].count;
    
    return count;
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)totalObjectsForSection:(NSInteger)sectionIndex {
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    return section ? section.count : 0;
}

//----------------------------------------------------------------------------------------------------
- (NSMutableArray*)sectionAtIndex:(NSInteger)sectionIndex {
    return sectionIndex < self.totalSections ? [self.objects objectAtIndex:sectionIndex] : nil;
}

//----------------------------------------------------------------------------------------------------
- (id)objectAtIndex:(NSInteger)index {
    return [self objectAtIndex:index
                    forSection:kDefaultTotalSections-1];
}

//----------------------------------------------------------------------------------------------------
- (id)objectAtIndex:(NSInteger)index 
         forSection:(NSInteger)sectionIndex {
    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return nil;
        
    return index < section.count ? [section objectAtIndex:index] : nil;
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)indexForObject:(id)object
                  inSection:(NSInteger)sectionIndex {
    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return 0;
    
    return [section indexOfObject:object];
}

//----------------------------------------------------------------------------------------------------
- (NSInteger)indexForObject:(id)object {
    return [self indexForObject:object
                      inSection:kDefaultTotalSections-1];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Modification

//----------------------------------------------------------------------------------------------------
- (void)addObjects:(NSMutableArray*)newObjects
         toSection:(NSInteger)sectionIndex {
    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return;
    
    [section addObjectsFromArray:newObjects];
}

//----------------------------------------------------------------------------------------------------
- (void)addObjects:(NSMutableArray*)newObjects {
    [self addObjects:newObjects
           toSection:kDefaultTotalSections-1];
}

//----------------------------------------------------------------------------------------------------
- (void)addObject:(id)newObject
        toSection:(NSInteger)sectionIndex {
    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return;
    
    [section addObject:newObject];
}

//----------------------------------------------------------------------------------------------------
- (void)addObject:(id)newObject {
    [self addObject:newObject toSection:kDefaultTotalSections-1];
}




//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Modification with Animation

//----------------------------------------------------------------------------------------------------
- (void)addObject:(id)object
          atIndex:(NSInteger)index
    withAnimation:(UITableViewRowAnimation)animation {
    
    [self addObject:object
            atIndex:index
         forSection:kDefaultTotalSections-1
      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)addObject:(id)object 
          atIndex:(NSInteger)index
       forSection:(NSInteger)sectionIndex
    withAnimation:(UITableViewRowAnimation)animation {
    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return;
    
    [section insertObject:object
                  atIndex:index];
    
    [self.delegate insertRowAtIndex:index
                         forSection:sectionIndex
                      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)addObjectAtEnd:(id)object
            forSection:(NSInteger)sectionIndex
         withAnimation:(UITableViewRowAnimation)animation {
    
    [self addObject:object
            atIndex:[self.objects count]
         forSection:sectionIndex
      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)addObjectAtEnd:(id)object
         withAnimation:(UITableViewRowAnimation)animation {
    
    [self addObjectAtEnd:object
              forSection:kDefaultTotalSections-1
           withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)removeObject:(id)object
          forSection:(NSInteger)sectionIndex
       withAnimation:(UITableViewRowAnimation)animation {

    NSInteger index = [self indexForObject:object
                                 inSection:sectionIndex];
    
    if(index == NSNotFound)
        return;

    
    NSMutableArray *section = [self sectionAtIndex:sectionIndex];
    
    if(!section)
        return;
    
    [section removeObjectAtIndex:index];
    
    
    [self.delegate removeRowAtIndex:index
                         forSection:sectionIndex
                      withAnimation:animation];
}

//----------------------------------------------------------------------------------------------------
- (void)removeObject:(id)object
       withAnimation:(UITableViewRowAnimation)animation {
    
    [self removeObject:object
            forSection:kDefaultTotalSections-1
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
