//
//  SOCHandContainer.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class SOCCard;

@interface SOCHandContainer : UIScrollView {
  
  NSMutableArray *cards;
  
}

@property(nonatomic,retain) NSMutableArray *cards;

- (void) layoutCards;
- (void) addCard:(SOCCard*)card;

@end
