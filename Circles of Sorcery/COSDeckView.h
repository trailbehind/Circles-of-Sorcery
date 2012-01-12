//
//  COSDeckView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSDiscardPileView.h"

@class COSHandContainer, COSCard;

@interface COSDeckView : COSDiscardPileView {
  
  COSHandContainer *handContainer;
  int startX;
  BOOL dragging;
  
}

- (id)initWithFrame:(CGRect)frame handContainer:(COSHandContainer*)hc;
- (void) addCard:(COSCard*)card;
- (void) drawCard;
- (void) drawHand;


@end
