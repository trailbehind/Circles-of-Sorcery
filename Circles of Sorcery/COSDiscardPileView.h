//
//  COSDiscardPileView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSCard;

@interface COSDiscardPileView : UIView {
  
  NSMutableArray *cards;
  NSDate *firstTouchTime;
}

- (void) addCard:(COSCard*)card;


@end
