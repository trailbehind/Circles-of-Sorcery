//
//  COSDiscardContainer.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSDiscardPileView;

#import "COSHandContainer.h"


@interface COSDiscardContainer : COSHandContainer {
  COSDiscardPileView *discardPile;
  UIButton *hideButton;
}

- (id)initWithFrame:(CGRect)frame discardPile:(COSDiscardPileView*)dp;


@end
