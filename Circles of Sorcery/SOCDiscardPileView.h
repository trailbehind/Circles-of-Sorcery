//
//  SOCDiscardPileView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class SOCCard;

@interface SOCDiscardPileView : UIView {
  
  NSMutableArray *cards;
  NSDate *firstTouchTime;
}

- (void) addCard:(SOCCard*)card;


@end
