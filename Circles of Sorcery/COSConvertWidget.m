//
//  COSConvertWidget.m
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSConvertWidget.h"
#import "COSEffect.h"
#import "COSPlayer.h"

@implementation COSConvertWidget


- (void) dealloc {
  [player release];
  [effect release];
  [super dealloc];
}


- (id) initForResourcesToGive:(NSString*)resourceToGive
                resourceToGet:(NSString*)resourceToGet
                    payAmount:(int)payAmount
            forResourceAmount:(int)getAmount 
                       player:(COSPlayer*)p {
  NSDictionary *resourceMap = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Gold", @"GET_GOLD", 
                               @"Point", @"GET_REWARD", 
                               @"Card", @"DRAW_CARD", nil];
  self = [super initWithFrame:CGRectMake(0, 0, 150, 75) title:[NSString stringWithFormat:@"%d %@ for %d %@", payAmount,  [resourceMap objectForKey:resourceToGive], getAmount,[resourceMap objectForKey:resourceToGet]] icon:nil startCount:0 showPlus:YES showMinus:NO];
  if (self) {
    COSEffect *e = [[[COSEffect alloc]initForResourcesToGive:resourceToGive
                                                        payAmount:payAmount
                                                    resourceToGet:resourceToGet
                                                forResourceAmount:getAmount]autorelease];
    
    effect = [e retain];
    player = [p retain];
  }
  
  return self;
}


- (void) incrementCounter {
  [effect activateTradeEffect:player];
}


@end
