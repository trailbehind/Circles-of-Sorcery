//
//  COSDeck.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSDeckView, COSPlayer, COSGame;

@interface COSDeck : NSObject {
  
  NSMutableArray *cards;
  COSDeckView *deckView;
  
}

@property(nonatomic,retain) NSMutableArray *cards;
@property(nonatomic,retain) COSDeckView *deckView;


- (id) initForFilename:(NSString*)filename player:(COSPlayer*)player game:(COSGame*)game;
- (void) drawCard;

@end
