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
} CardResult;

@interface COSCard : NSObject {
  
  COSPlayer *player;
  COSCardView *cardView;
  NSString *name, *type;
  int cost, reward;
  NSMutableArray *actions;
  
  NSString *resourceToProduce;
  
}

@property(nonatomic,retain) NSString *name, *type;
@property(nonatomic,assign) int cost, reward;
@property(nonatomic,retain) NSMutableArray *actions;
@property(nonatomic,retain) COSPlayer *player;
@property(nonatomic,retain) NSString *resourceToProduce;
@property(nonatomic,retain) COSCardView *cardView;

- (id)initWithName:(NSString*)n player:(COSPlayer*)p game:(COSGame*)g;
- (NSString*) displayText;


@end
