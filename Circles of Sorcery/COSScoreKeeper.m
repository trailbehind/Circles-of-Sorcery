//
//  COSScoreKeeper.m
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSScoreKeeper.h"
#import "COSConstants.h"
#import "ScoreTable.h"
#import "COSPlayer.h"
#import "COSPlayerArea.h"
#import "COSScoreView.h"
#import "COSHighScoreView.h"

@implementation COSScoreKeeper
@synthesize scores, player, turnIndex;  

- (void) dealloc {
  [player release];
  [scores release];
  [scoreViewPopover release];
  [super dealloc];
}


- (void) addScore:(int)score forThing:(NSString*)thingName {
  
  NSMutableDictionary *scoreDict = [scores objectForKey:thingName];
  int newTotal = score + [[scoreDict objectForKey:@"total"]intValue];
  [scoreDict setValue:[NSNumber numberWithInt:newTotal] forKey:@"total"];


  NSMutableArray *turns = [scoreDict objectForKey:@"turns"];
  NSNumber *turnTotalNum = [turns objectAtIndex:turnIndex];
  int turnTotal = score + [turnTotalNum intValue];
  [turns replaceObjectAtIndex:turnIndex withObject:[NSNumber numberWithInt:turnTotal]];
  
}


- (NSMutableArray*) zeroedArray {
  NSMutableArray *arr = [NSMutableArray arrayWithCapacity:NUMBER_OF_TURNS];
  for (int x=0;x<NUMBER_OF_TURNS;x++) {
    [arr addObject:[NSNumber numberWithInt:0]];
  }
  return arr;
}


- (void) addThingToTrack:(NSString*)thingName {
  NSDictionary *dict = [NSMutableDictionary dictionary];
  [dict setValue:[NSNumber numberWithInt:0] forKey:@"total"];
  [dict setValue:[self zeroedArray] forKey:@"turns"];
  [scores setValue:dict forKey:thingName];
}


- (void) endTurn {
  turnIndex++;
  if (turnIndex == NUMBER_OF_TURNS) {
    COSScoreView *scoreView = [[[COSScoreView alloc]initWithScoreKeeper:self]autorelease];
    scoreViewPopover = [[UIPopoverController alloc]initWithContentViewController:scoreView];
    [scoreViewPopover presentPopoverFromRect:CGRectMake(player.playerArea.frame.size.width/2, 0, 1, 1) inView:player.playerArea permittedArrowDirections:0 animated:YES]; 
  }
}


- (void) scoreEntered {
  [scoreViewPopover dismissPopoverAnimated:NO];
  [scoreViewPopover release];
  
  COSHighScoreView *hsv = [[[COSHighScoreView alloc]init]autorelease];
  UIPopoverController *pop = [[UIPopoverController alloc]initWithContentViewController:hsv];
  [pop presentPopoverFromRect:CGRectMake(player.playerArea.frame.size.width/2, 0, 1, 1) inView:player.playerArea permittedArrowDirections:0 animated:YES];
  
}


- (id) initWithPlayer:(COSPlayer*)p {
  self = [super init];
  scores = [[NSMutableDictionary alloc]init];
  player = [p retain];
  turnIndex = 0;
  return self;
}


@end
