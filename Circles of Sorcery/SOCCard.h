//
//  SOCCard.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class SOCHandContainer, SOCDiscardPileView;

@interface SOCCard : UIView {
  
  CGPoint startPoint;
  SOCHandContainer *handContainer;
  SOCDiscardPileView *discardPile;
  NSDate *firstTouchTime;

  UILabel *nameLabel, *costLabel, *textLabel, *typeLabel, *powerLabel, *keywordsLabel;
  UIImageView *artwork;
  
}

@property(nonatomic,retain) SOCHandContainer *handContainer;
@property(nonatomic,retain) SOCDiscardPileView *discardPile;

- (id)initWithCardInfo:(NSDictionary*)cardInfo;

@end
