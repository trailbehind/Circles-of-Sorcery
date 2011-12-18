//
//  COSDeckView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSHandContainer, COSCard;

@interface COSDeckView : UIView {
  
  NSMutableArray *cards;
  COSHandContainer *handContainer;
  NSDate *firstTouchTime;
  
}

- (id)initWithFrame:(CGRect)frame handContainer:(COSHandContainer*)hc;
- (void) addCard:(COSCard*)card;
- (void) drawCard;
- (void) drawHand;


@end
