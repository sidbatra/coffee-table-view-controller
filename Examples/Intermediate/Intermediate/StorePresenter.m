//
//  StorePresenter.m
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

#import "StorePresenter.h"

#import "Store.h"
#import "StoreCell.h"


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation StorePresenter

//----------------------------------------------------------------------------------------------------
+ (UITableViewCell*)cellForObject:(id)object
                     withBaseCell:(id)base
               withCellIdentifier:(NSString*)identifier
                     withDelegate:(id)delegate
             andPresentationStyle:(NSInteger)style {
    
    Store *store        = object;
    StoreCell *cell    = base;
    
    if(!cell)
        cell = [[StoreCell alloc] initWithStyle:UITableViewStylePlain
                            reuseIdentifier:identifier];
    
    
    [cell resetUI];
    
    [store downloadImage];
    [cell setStoreImage:store.image];
    
    
    return cell;
}

//----------------------------------------------------------------------------------------------------
+ (CGFloat)heightForObject:(id)object
     withPresentationStyle:(NSInteger)style {
    
    return [StoreCell heightForCell];
}

//----------------------------------------------------------------------------------------------------
+ (void)updatePresentationForCell:(id)base
                         ofObject:(id)object
            withPresentationStyle:(NSInteger)style
                withUpdatedObject:(id)updatedObject
                    andUpdatedKey:(NSString*)updatedKey; {
    
    
    Store *store       = object;
    StoreCell *cell   = base;
    
    if(store == updatedObject) {
        if([updatedKey isEqualToString:@"image"])
            [cell setStoreImage:store.image];
    }
}

//----------------------------------------------------------------------------------------------------
+ (void)cellClickedForObject:(id)object
                withBaseCell:(id)base
       withPresentationStyle:(NSInteger)style
                withDelegate:(id)delegate {
    
}

@end
