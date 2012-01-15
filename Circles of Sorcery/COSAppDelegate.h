//
//  COSAppDelegate.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSGame;

@interface COSAppDelegate : UIResponder <UIApplicationDelegate> {
  
  COSGame *game;
}

@property (strong, nonatomic) UIWindow *window;

@end
