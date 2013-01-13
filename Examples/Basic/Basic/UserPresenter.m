//
//  UserPresenter.m
//  Mine
//
//  Created by Siddharth Batra on 8/2/12.
//  Copyright (c) 2012 Denwen, Inc. All rights reserved.
//

#import "UserPresenter.h"

#import "UserCell.h"
#import "User.h"


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation UserPresenter

//----------------------------------------------------------------------------------------------------
+ (UITableViewCell*)cellForObject:(id)object
                     withBaseCell:(id)base
               withCellIdentifier:(NSString*)identifier
                     withDelegate:(id)delegate
             andPresentationStyle:(NSInteger)style {
    
    User *user        = object;
    UserCell *cell    = base;
    
    if(!cell)
        cell = [[UserCell alloc] initWithStyle:UITableViewStylePlain 
                                 reuseIdentifier:identifier];
    
    //cell.userID = user.databaseID;
    
    [cell resetUI];
    
    //[user downloadSquareImage];
    
    //[cell setUserImage:user.squareImage];
    

    if(style == kUserPresenterStyleWithByline)
        [cell setUserName:user.name
               andMessage:user.byline];
    else
        [cell setUserName:user.name];
    
    return cell;
}

//----------------------------------------------------------------------------------------------------
+ (CGFloat)heightForObject:(id)object 
     withPresentationStyle:(NSInteger)style {
    
    return [UserCell heightForCell];
}

//----------------------------------------------------------------------------------------------------
+ (void)updatePresentationForCell:(id)base
                         ofObject:(id)object
            withPresentationStyle:(NSInteger)style
                withUpdatedObject:(id)updatedObject
                    andUpdatedKey:(NSString*)updatedKey; {
    
    
    //User *user            = object;
    //UserCell *cell        = base;
    
    //if([user class] == objectClass && user.databaseID == objectID) {
    //    if(objectKey == kKeySquareImageURL)
    //        [cell setUserImage:user.squareImage];
    //}
}

//----------------------------------------------------------------------------------------------------
+ (void)cellClickedForObject:(id)object
                withBaseCell:(id)base
       withPresentationStyle:(NSInteger)style
                withDelegate:(id)delegate {
    
    
    SEL sel = @selector(userPresenterUserSelected:);
    
    if(![delegate respondsToSelector:sel])
        return;
    
    
    User *user = object;
    
    [delegate performSelector:sel
                   withObject:user];
    
}

@end
