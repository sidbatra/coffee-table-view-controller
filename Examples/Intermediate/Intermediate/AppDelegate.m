//
//  AppDelegate.m
//  Intermediate
//
//  Created by Siddharth Batra on 1/14/13.
//
//

#import "AppDelegate.h"


#import "StoreViewController.h"



//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
@implementation AppDelegate

//----------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:storeViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
