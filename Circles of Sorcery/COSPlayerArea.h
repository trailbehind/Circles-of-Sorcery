//
//  COSPlayerArea.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class COSPlusMinusCounter, COSDeckView, COSPlayer;

@interface COSPlayerArea : UIView {
  
  COSPlusMinusCounter *lifeCounter, *manaCounter;
  COSDeckView *deckView;
  
}

- (id)initWithFrame:(CGRect)frame forPlayer:(COSPlayer*)player;
- (void) endTurn;




@end
