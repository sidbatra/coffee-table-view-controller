//
//  Store.m
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

#import "Store.h"

#import "ASIHTTPRequest.h"

NSString* const kNStoreImageLoaded = @"NStoreImageLoaded";



@interface Store() {
    BOOL _isDownloading;
}

@end



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation Store

@synthesize identifier  = _identifier;
@synthesize name        = _name;
@synthesize imageURL    = _imageURL;
@synthesize image       = _image;

//----------------------------------------------------------------------------------------------------
- (void)downloadImage {
    if(_isDownloading || self.image)
        return;
    
    _isDownloading = YES;
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[[NSURL alloc] initWithString:self.imageURL]];
    [request setDelegate:self];
	[request setRequestMethod:@"GET"];
	[request startAsynchronous];
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ASIHTTPRequestDelegate

//----------------------------------------------------------------------------------------------------
- (void)requestFinished:(ASIHTTPRequest*)request {
    self.image = [UIImage imageWithData:[request responseData]];
    
	[[NSNotificationCenter defaultCenter] postNotificationName:kNStoreImageLoaded
														object:self
													  userInfo:nil];
    
    _isDownloading = NO;
}

//----------------------------------------------------------------------------------------------------
- (void)requestFailed:(ASIHTTPRequest*)request {
}

@end
