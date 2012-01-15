//
//  COSGame.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSGameLayout, COSCardRegistry;

@interface COSGame : UIViewController {
  
  COSGameLayout *gameLayout;
  COSCardRegistry *cardRegistry;
  NSMutableArray *players;  
}

@property(nonatomic,retain) COSCardRegistry *cardRegistry;
@property(nonatomic,retain) NSMutableArray *players;  

- (id) initWithCardRegistryFile:(NSString*)filename;
- (void) createDisplayForPlayers:(NSArray*)p;
- (void) beginGame;


@end
