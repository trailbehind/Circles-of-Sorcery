//
//  COSGame.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSGameLayout, COSCardRegistry, COSDeckBuilderTableView;

@interface COSGame : UIViewController {
  
  COSGameLayout *gameLayout;
  COSCardRegistry *cardRegistry;
  NSMutableArray *players;  
  COSDeckBuilderTableView *deckBuilder;
}

@property(nonatomic,retain) COSCardRegistry *cardRegistry;
@property(nonatomic,retain) NSMutableArray *players;  
@property(nonatomic,retain) COSGameLayout *gameLayout;

- (id) initWithCardRegistryFile:(NSString*)filename;
- (void) showDeckBuilder;
- (NSString*) lastDefaultDeck;
- (NSString*) defaultDeckPath;
- (void) reloadRegistry:(NSString*)filename;
- (void) makeNewGame;

@end
