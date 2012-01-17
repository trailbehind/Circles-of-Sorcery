//
//  COSCardView.h
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSCard, COSHandContainer, COSDiscardPileView, COSDeckView;

@interface COSCardView : UIView {
  COSCard *card;
  UILabel *nameLabel, *costLabel, *textLabel, *typeLabel, *rewardLabel;
  UIImageView *artwork;
  
  CGPoint startPoint;
  COSHandContainer *handContainer;
  COSDeckView *deck;
  COSDiscardPileView *discardPile;
  NSDate *firstTouchTime;
}

@property(nonatomic,retain) COSHandContainer *handContainer;
@property(nonatomic,retain) COSDiscardPileView *discardPile;
@property(nonatomic,retain) COSDeckView *deck;
@property(nonatomic,retain) NSDate *firstTouchTime;


- (id)initWithCard:(COSCard*)c;
- (void) unhighlight;
- (void) highlightForEffect;

@end
