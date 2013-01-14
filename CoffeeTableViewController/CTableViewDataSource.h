//
//  CTableViewDataSource.h
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

#import <Foundation/Foundation.h>


@protocol CTableViewDataSourceDelegate;



/**
 * Inherit and use your own table view data source to power a table view controller.
 * Methods that don't contain a section index refer to the default section index: 0.
 */
@interface CTableViewDataSource : NSObject {
    NSMutableArray *_objects;
    
    __weak id<CTableViewDataSourceDelegate,NSObject> _delegate;
}


/**
 * Two dimensional array. First dimension contains an NSMutableArray representing
 * each section. Second dimension holds objects for each section.
 */
@property (nonatomic,strong) NSMutableArray *objects;

/**
 * Delegate for communicating with the table view controller
 */
@property (nonatomic,weak) id<CTableViewDataSourceDelegate,NSObject> delegate;


@property (nonatomic,readonly) NSInteger totalSections;

@property (nonatomic,readonly) NSInteger totalObjects;




- (id)initWithNumberOfSections:(NSInteger)numberOfSections;

- (id)init;




- (NSInteger)totalObjectsForSection:(NSInteger)section;

- (NSMutableArray*)sectionAtIndex:(NSInteger)sectionIndex;

- (id)objectAtIndex:(NSInteger)index
         forSection:(NSInteger)sectionIndex;

- (id)objectAtIndex:(NSInteger)index;

- (NSInteger)indexForObject:(id)object;

/**
 * Returns NSNotFound if not found.
 */
- (NSInteger)indexForObject:(id)object
                  inSection:(NSInteger)sectionIndex;





- (void)addObjects:(NSMutableArray*)newObjects
         toSection:(NSInteger)sectionIndex;

- (void)addObjects:(NSMutableArray*)newObjects;

- (void)addObject:(id)newObject
        toSection:(NSInteger)sectionIndex;

- (void)addObject:(id)newObject;



- (void)addObject:(id)object
          atIndex:(NSInteger)index
       forSection:(NSInteger)sectionIndex
    withAnimation:(UITableViewRowAnimation)animation;

- (void)addObject:(id)object
          atIndex:(NSInteger)index
    withAnimation:(UITableViewRowAnimation)animation;

- (void)addObjectAtEnd:(id)object
            forSection:(NSInteger)sectionIndex
         withAnimation:(UITableViewRowAnimation)animation;

- (void)addObjectAtEnd:(id)object
         withAnimation:(UITableViewRowAnimation)animation;

- (void)removeObject:(id)object
          forSection:(NSInteger)sectionIndex
       withAnimation:(UITableViewRowAnimation)animation;

- (void)removeObject:(id)object 
       withAnimation:(UITableViewRowAnimation)animation;


- (void)clean;

/**
 * Clean array for a particular section.
 */
- (void)cleanSection:(NSInteger)sectionIndex;



/**
  * Template method to be overriden. Override and write your full refresh
  * logic here. Example: After a user does pull to refresh or an automated
  * refresh is started.
  */
- (void)refreshInitiated;

@end



/**
 * Enables the datasource to communicate with the table view controller.
 */
@protocol CTableViewDataSourceDelegate


- (void)reloadTableView;

- (void)insertRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex
           withAnimation:(UITableViewRowAnimation)animation;

- (void)removeRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex
           withAnimation:(UITableViewRowAnimation)animation;

- (void)reloadRowAtIndex:(NSInteger)index
              forSection:(NSInteger)sectionIndex;

- (void)scrollToRowAtIndex:(NSInteger)index
                forSection:(NSInteger)sectionIndex;

- (void)displayError:(NSString *)message 
       withRefreshUI:(BOOL)showRefreshUI;

@end


