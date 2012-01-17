//
//  COSPlayerArea.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@class COSPlusMinusCounter, COSDeckView, COSPlayer;

@interface COSPlayerArea : UIView {
  
  COSPlusMinusCounter *goldCounter;
  COSDeckView *deckView;
  COSPlayer *player;
  
}


@property(nonatomic,retain) COSPlayer *player;
@property(nonatomic,retain) COSPlusMinusCounter *goldCounter;


- (id)initWithFrame:(CGRect)frame forPlayer:(COSPlayer*)p;
- (void) endTurn;




@end
