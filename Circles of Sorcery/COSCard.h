//
//  COSCard.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class COSCardView, COSPlayer, COSGame;

typedef enum {
  END_ACTIONS,
  CONTINUE_ACTIONS,
  NO_AND_CONTINUE,
  YES_AND_CONTINUE,
} CardResult;

@interface COSCard : NSObject {
  
  COSPlayer *player;
  COSCardView *cardView;
  NSString *name, *type, *subtype;
  int cost, reward;
  NSMutableArray *actions;
  
  NSString *resourceToProduce;
  float resourceModifier;
  
}

@property(nonatomic,retain) NSString *name, *type, *subtype;
@property(nonatomic,assign) int cost, reward;
@property(nonatomic,retain) NSMutableArray *actions;
@property(nonatomic,retain) COSPlayer *player;
@property(nonatomic,retain) NSString *resourceToProduce;
@property(nonatomic,retain) COSCardView *cardView;
@property(nonatomic,assign) float resourceModifier;

- (id)initWithName:(NSString*)n player:(COSPlayer*)p game:(COSGame*)g;
- (NSString*) displayText;
- (void) playFromHand;
- (void) highlightIfActivatable;
- (BOOL) isActivatableForParameter:(NSString*)parameter;
- (void) activateForEvent:(NSString*)eventName;

@end
