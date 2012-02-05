//
//  COSScoreKeeper.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSPlayer;

@interface COSScoreKeeper : NSObject {

  NSMutableDictionary *scores;
  int turnIndex;
  COSPlayer *player;
  UIPopoverController *scoreViewPopover;

}

@property(nonatomic, retain) NSMutableDictionary *scores;
@property(nonatomic, retain) COSPlayer *player;
@property(nonatomic, assign) int turnIndex;

- (id) initWithPlayer:(COSPlayer*)p;
- (void) addThingToTrack:(NSString*)thingName;
- (void) addScore:(int)score forThing:(NSString*)thingName;
- (void) endTurn;
- (void) scoreEntered;


@end
