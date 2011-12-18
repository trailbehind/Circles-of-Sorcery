//
//  SOCDeckView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class SOCHandContainer, SOCCard;

@interface SOCDeckView : UIView {
  
  NSMutableArray *cards;
  SOCHandContainer *handContainer;
  NSDate *firstTouchTime;
  
}

- (id)initWithFrame:(CGRect)frame handContainer:(SOCHandContainer*)hc;
- (void) addCard:(SOCCard*)card;
- (void) drawCard;
- (void) drawHand;


@end
