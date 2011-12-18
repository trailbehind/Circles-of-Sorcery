//
//  SOCDiscardContainer.h
//  Circles of Sorcery
//
//  Created by EFB on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class SOCDiscardPileView;

#import "SOCHandContainer.h"


@interface SOCDiscardContainer : SOCHandContainer {
  SOCDiscardPileView *discardPile;
  UIButton *hideButton;
}

- (id)initWithFrame:(CGRect)frame discardPile:(SOCDiscardPileView*)dp;


@end
