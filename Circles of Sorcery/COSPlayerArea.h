//
//  COSPlayerArea.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class COSPlusMinusCounter, COSDeckView, COSPlayer, COSCard, COSTurnCounter;

@interface COSPlayerArea : UIView {
  
  COSPlusMinusCounter *goldCounter, *rewardCounter;
  COSDeckView *deckView;
  COSPlayer *player;
  NSMutableArray *cards, *widgets;
  COSTurnCounter *turnCounter;
  
}


@property(nonatomic,retain) COSPlayer *player;
@property(nonatomic,retain) COSPlusMinusCounter *goldCounter, *rewardCounter;
@property(nonatomic,retain) NSMutableArray *cards;
@property(nonatomic,retain) COSDeckView *deckView;
@property(nonatomic,retain) COSTurnCounter *turnCounter;


- (id)initWithFrame:(CGRect)frame forPlayer:(COSPlayer*)p;
- (void) removeWidget:(UIView*)widget;
- (void) addWidget:(UIView*)widget;
- (void) addCard:(COSCard*)card;
- (void) removeCard:(COSCard*)card;


@end
