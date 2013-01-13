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
    
    [cell setUserName:user.name];
    /*
    if (style == kDefaultModelPresenter)
        [cell setUserName:user.fullName];
    else
        [cell setUserName:user.fullName
               andMessage:user.message];
     */
     
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
                  withObjectClass:(Class)objectClass
                     withObjectID:(NSInteger)objectID
                     andObjectKey:(NSString*)objectKey {
    
    
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
