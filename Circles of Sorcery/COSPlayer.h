//
//  COSPlayer.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class  COSDeck, COSHandContainer, COSDiscardPileView, COSGame;

@interface COSPlayer : NSObject {
  int gold, rewardPoints;
  NSString *deckName;
  COSDeck *deck;
  COSHandContainer *handContainer;
  COSDiscardPileView *discardPile;
  NSMutableArray *cardsInPlay;
  COSGame *game;
}

@property(nonatomic, assign) int gold, rewardPoints;
@property(nonatomic, retain) COSHandContainer *handContainer;
@property(nonatomic, retain) NSMutableArray *cardsInPlay;
@property(nonatomic, retain) COSDeck *deck;
@property(nonatomic, retain) COSDiscardPileView *discardPile;
@property(nonatomic, retain) COSGame *game;

- (void) drawCards:(int)numberOfCards;
- (int) selectGoldAmountWithIncrement:(int)increment;
- (void) gainResourceNamed:(NSString*)resourceName amount:(int)amount;
- (id) initWithDeck:(NSString*)d game:(COSGame*)g;
- (void) drawHand;


@end
