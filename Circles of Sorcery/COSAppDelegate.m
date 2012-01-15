//
//  COSAppDelegate.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSAppDelegate.h"
#import "COSGameLayout.h"
#import "COSGame.h"
#import "COSPlayer.h"

@implementation COSAppDelegate

@synthesize window = _window;

- (void) dealloc {
  [game release];
  [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];

  game = [[COSGame alloc]initWithCardRegistryFile:@"card_data.json"];

  COSPlayer *playerOne = [[[COSPlayer alloc]initWithDeck:@"farmer deck.txt" game:game]autorelease];
  COSPlayer *playerTwo = [[[COSPlayer alloc]initWithDeck:@"farmer deck.txt" game:game]autorelease];
  NSMutableArray *players = [NSMutableArray arrayWithObjects:playerOne, playerTwo, nil];  
  [game createDisplayForPlayers:players];
  [game beginGame];  
  [self.window addSubview:game.view];
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

@end
