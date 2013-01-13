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
 * Data source for the CTableViewController implementation.
 * Its child classes are responsible for storing and procuring
 * data for table view across the application.
 */
@interface CTableViewDataSource : NSObject {
    NSMutableArray  *_objects;
    
    __weak id<CTableViewDataSourceDelegate,NSObject> _delegate;
}

/**
 * Holds objects that correspond to the rows of a table view controller
 */
@property (nonatomic,strong) NSMutableArray *objects;

/**
 * Delegate for communicating with the table view controller
 */
@property (nonatomic,weak) id<CTableViewDataSourceDelegate,NSObject> delegate;



/**
 * Destroy and release all objects
 */
- (void)clean;

/**
 * Get the total number of sections 
 */
- (NSInteger)totalSections;

/**
 * Fetch the total number of objects for the given section
 */
- (NSInteger)totalObjectsForSection:(NSInteger)section;

/**
 * Fetch the object at the given index
 */
- (id)objectAtIndex:(NSInteger)index 
         forSection:(NSInteger)section;

/**
 * Returns the index in the objects array for the given object. NSNotFound if not found.
 */
- (NSInteger)indexForObject:(id)object;

/**
 * Fired when a user generated or automated refresh is initiated
 */
- (void)refreshInitiated;

/**
 * Add the given object into the given index
 * and instruct table view to display it with animation
 */
- (void)addObject:(id)object
          atIndex:(NSInteger)index
    withAnimation:(UITableViewRowAnimation)animation;

/**
 * Add the given object at the end of the array
 */
- (void)addObjectAtEnd:(id)object
         withAnimation:(UITableViewRowAnimation)animation;

/**
 * Remove the given object from the array with specified 
 * animation
 */
- (void)removeObject:(id)object 
       withAnimation:(UITableViewRowAnimation)animation;

@end



/**
 * CTableViewDataSource delegate definition. It's used to communicate
 * with the table view controller for which its a data source
 */
@protocol CTableViewDataSourceDelegate

/**
 * Request a full reload
 */
- (void)reloadTableView;

/**
 * Inserts a new row into the table view
 * with specified animation
 */
- (void)insertRowAtIndex:(NSInteger)index
           withAnimation:(UITableViewRowAnimation)animation;

/**
 * Removes an existing row from the table view
 * with specified animation
 */
- (void)removeRowAtIndex:(NSInteger)index 
           withAnimation:(UITableViewRowAnimation)animation;

/**
 * Reload the cell at the given index
 */
- (void)reloadRowAtIndex:(NSInteger)index;

/**
 * Scroll the table view to a given index
 */
- (void)scrollToRowAtIndex:(NSInteger)index;

/**
 * Display an error message with an option for display a retry 
 * / refresh UI.
 */
- (void)displayError:(NSString *)message 
       withRefreshUI:(BOOL)showRefreshUI;

@end


