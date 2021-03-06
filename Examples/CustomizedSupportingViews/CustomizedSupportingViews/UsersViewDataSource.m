//
//  UsersViewDataSource.m
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

#import "UsersViewDataSource.h"
#import "User.h"



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation UsersViewDataSource

//----------------------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    
    if(self) {
    }
    
    return self;
}

//----------------------------------------------------------------------------------------------------
- (void)refreshInitiated {
    [self loadDelayedUsers];
}

//----------------------------------------------------------------------------------------------------
- (User*)createUserWithName:(NSString*)name
                      byline:(NSString*)byline
                    imageURL:(NSString*)imageURL
                 identifier:(NSInteger)identifier {
    
    User *user = [[User alloc] init];
    
    user.identifier = identifier;
    user.name = name;
    user.byline = byline;
    user.imageURL = imageURL;
    
    return user;
}

//----------------------------------------------------------------------------------------------------
- (void)loadDelayedUsers {
    [self performSelector:@selector(loadUsers) withObject:nil afterDelay:2];
}

//----------------------------------------------------------------------------------------------------
- (void)loadUsers {

    NSMutableArray *users = [NSMutableArray arrayWithCapacity:10];

    [users addObject:[self createUserWithName:@"Miranda Coykendall"
                                       byline:@"PR professional with a background in journalism. Focus in the consumer, technology, social media and cleantech spaces."
                                     imageURL:@"http://graph.facebook.com/731360547/picture?type=square"
                                   identifier:0]];
    
    [users addObject:[self createUserWithName:@"Josh Cincinnati"
                                       byline:@"Likes: newness, gadgets, and green tea. Chasing ideas in Texas. Sometimes, I make jokes. Sometimes, you laugh. Oftentimes, they are not at the same time."
                                     imageURL:@"http://graph.facebook.com/1500439/picture?type=square"
                                   identifier:1]];
    
    [users addObject:[self createUserWithName:@"Swati Dube"
                                       byline:@"Start-up enthusiast, love meeting new people and exchanging ideas, love my work :)"
                                     imageURL:@"http://graph.facebook.com/799510289/picture?type=square"
                                   identifier:2]];
    
    [users addObject:[self createUserWithName:@"Pratyus Patnaik"
                                       byline:@"Appurify, Zynga, Oracle, Stanford, IIIT, India, Silicon Valley!"
                                     imageURL:@"http://graph.facebook.com/500870876/picture?type=square"
                                   identifier:3]];
    
    [users addObject:[self createUserWithName:@"Kevin Hartz"
                                       byline:@"CEO Eventbrite"
                                     imageURL:@"http://graph.facebook.com/210914/picture?type=square"
                                   identifier:4]];
    
    [users addObject:[self createUserWithName:@"Suchit Agarwal"
                                       byline:@"Phd Dropout, Startup Enthusiast, Gnarlar at Twitter, Voracious Reader, History Buff, Movie Maniac. I help the cause of democratic imperialism all over the world"
                                     imageURL:@"http://api.twitter.com/1/users/profile_image?user_id=18895807&size=bigger"
                                   identifier:5]];
    
    [users addObject:[self createUserWithName:@"Siddharth Batra"
                                       byline:@"One of the makers of Mine. Ping me anytime for feedback - @sidbatra"
                                     imageURL:@"http://graph.facebook.com/502835064/picture?type=square"
                                   identifier:6]];
    
    [users addObject:[self createUserWithName:@"Jessica McCall"
                                       byline:@"Lover of pretty things. :-)"
                                     imageURL:@"http://api.twitter.com/1/users/profile_image?user_id=38529101&size=bigger"
                                   identifier:7]];
    
    [users addObject:[self createUserWithName:@"Shayne Fitz-Coy"
                                       byline:@"http://nyti.ms/nkJM81"
                                     imageURL:@"http://graph.facebook.com/21072/picture?type=square"
                                   identifier:8]];
    
    [users addObject:[self createUserWithName:@"Chris Couhault"
                                       byline:@"Co-founder, Shopply. Advisor to Innovation Endeavors in Palo Alto."
                                     imageURL:@"http://graph.facebook.com/513303014/picture?type=square"
                                   identifier:9]];
    
    [self clean];
    [self addObjects:users];
    
    [self.delegate reloadTableView];    
}

@end
