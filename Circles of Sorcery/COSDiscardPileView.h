//
//  COSDiscardPileView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSCard, COSDiscardContainer;

@interface COSDiscardPileView : UIView {
  
  NSMutableArray *cards;
  NSDate *firstTouchTime;
  COSDiscardContainer *discardContainer;
}

@property(nonatomic,retain) NSMutableArray *cards;
@property(nonatomic,retain) COSDiscardContainer *discardContainer;

- (void) addCard:(COSCard*)card;


@end
