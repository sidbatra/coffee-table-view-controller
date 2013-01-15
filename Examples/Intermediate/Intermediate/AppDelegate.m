//
//  AppDelegate.m
//  Intermediate
//
//  Created by Siddharth Batra on 1/14/13.
//
//

#import "AppDelegate.h"


#import "UsersViewController.h"



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation AppDelegate

//----------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    UsersViewController *usersViewController = [[UsersViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:usersViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
