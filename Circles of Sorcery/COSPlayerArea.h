//
//  COSPlayerArea.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class COSPlusMinusCounter, COSDeckView;

@interface COSPlayerArea : UIView {
  
  COSPlusMinusCounter *lifeCounter, *manaCounter;
  COSDeckView *deck;
  
}

- (id)initWithFrame:(CGRect)frame deckName:(NSString*)deckName;
- (void) endTurn;



@end
