//
//  COSDeckView.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSDiscardPileView.h"


@class COSHandContainer, COSCard, COSDeck;

@interface COSDeckView : COSDiscardPileView {
  
  COSDeck *deck;
  COSHandContainer *handContainer;
  int startX;
  BOOL dragging;
  
}

@property(nonatomic, retain) COSDeck *deck;

- (id)initWithFrame:(CGRect)frame handContainer:(COSHandContainer*)hc;
- (NSArray*) searchForCardsNamed:(NSArray*)cardNames;
- (void) drawCard:(COSCard*)card;


@end
