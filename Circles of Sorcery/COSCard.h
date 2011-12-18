//
//  COSCard.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSHandContainer, COSDiscardPileView;

@interface COSCard : UIView {
  
  CGPoint startPoint;
  COSHandContainer *handContainer;
  COSDiscardPileView *discardPile;
  NSDate *firstTouchTime;

  UILabel *nameLabel, *costLabel, *textLabel, *typeLabel, *powerLabel, *keywordsLabel;
  UIImageView *artwork;
  
  int lifeValue, maxLife;
  
  
}

@property(nonatomic,retain) COSHandContainer *handContainer;
@property(nonatomic,retain) COSDiscardPileView *discardPile;

- (id)initWithCardInfo:(NSDictionary*)cardInfo;

@end
