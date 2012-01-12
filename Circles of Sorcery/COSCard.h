//
//  COSCard.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSHandContainer, COSDiscardPileView, COSDeckView;

@interface COSCard : UIView {
  
  CGPoint startPoint;
  COSHandContainer *handContainer;
  COSDeckView *deck;
  COSDiscardPileView *discardPile;
  NSDate *firstTouchTime;

  UILabel *nameLabel, *costLabel, *textLabel, *typeLabel, *powerLabel, *keywordsLabel;
  UIImageView *artwork;
  
  int lifeValue, maxLife;
  
  
}

@property(nonatomic,retain) COSHandContainer *handContainer;
@property(nonatomic,retain) COSDiscardPileView *discardPile;
@property(nonatomic,retain) COSDeckView *deck;

- (id)initWithCardInfo:(NSDictionary*)cardInfo;

@end
