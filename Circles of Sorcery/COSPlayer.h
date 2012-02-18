//
//  COSPlayer.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class  COSDeck, COSHandContainer, COSDiscardPileView, COSGame, COSPlayerArea, COSScoreKeeper, COSCard;

@interface COSPlayer : NSObject {
  int gold, rewardPoints;
  NSString *deckName;
  COSDeck *deck;
  COSHandContainer *handContainer;
  COSDiscardPileView *discardPile;
  NSMutableArray *cardsInPlay, *activeEffects, *effectWidgets;
  COSGame *game;
  COSPlayerArea *playerArea;
  COSScoreKeeper *scoreKeeper;
  COSCard *activeWorker; 
}

@property(nonatomic, assign) int gold, rewardPoints;
@property(nonatomic, retain) COSHandContainer *handContainer;
@property(nonatomic, retain) NSMutableArray *cardsInPlay, *activeEffects, *effectWidgets;
@property(nonatomic, retain) COSDeck *deck;
@property(nonatomic, retain) COSDiscardPileView *discardPile;
@property(nonatomic, retain) COSGame *game;
@property(nonatomic, retain) COSPlayerArea *playerArea;
@property(nonatomic, retain) NSString *deckName;
@property(nonatomic, retain) COSScoreKeeper *scoreKeeper;
@property(nonatomic, retain) COSCard *activeWorker; 

- (void) drawCards:(int)numberOfCards keepScore:(BOOL)keepScore;
- (int) selectGoldAmountWithIncrement:(int)increment;
- (void) gainResourceNamed:(NSString*)resourceName amount:(int)amount;
- (id) initWithDeck:(NSString*)d game:(COSGame*)g;
- (void) drawHand;
- (BOOL) gainGold:(int)amount;
- (void) gainReward:(int)amount;
- (void) addCounterForResourcesToGain:(NSString*)resourceName 
                        payGoldAmount:(int)goldAmount
                    forResourceAmount:(int)resourceAmount;
- (void) setDeckForPath:(NSString*)path;


@end
