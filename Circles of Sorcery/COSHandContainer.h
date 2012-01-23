//
//  COSHandContainer.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSCard;

@interface COSHandContainer : UIScrollView {
  
  NSMutableArray *cards;
  CGPoint startPoint;
  
}

@property(nonatomic,retain) NSMutableArray *cards;

- (void) layoutCards;
- (void) addCard:(COSCard*)card;
- (NSArray*) chooseCardsToDicard:(int)numberOfCards;
- (void) playCard:(COSCard*)card;
- (void)cardTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event card:(COSCard*)card;


@end
