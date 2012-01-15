//
//  COSGame.m
//  Circles of Sorcery
//
//  Created by EFB on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSGame.h"
#import "COSGameLayout.h"
#import "COSCardRegistry.h"
#import "COSPlayer.h"

@implementation COSGame 
@synthesize cardRegistry, players;

- (void) dealloc {
  [cardRegistry release];
  [gameLayout release];
  [players release];
  [super dealloc];
}


- (void) beginGame {
  [(COSPlayer*)[players objectAtIndex:0]drawHand];
  [(COSPlayer*)[players objectAtIndex:1]drawHand];
}


- (void) loadView {
  [super loadView];
  gameLayout.frame = self.view.frame;
  [self.view addSubview:gameLayout];
}


- (id) initWithCardRegistryFile:(NSString*)filename {
  self = [super init];
  cardRegistry = [[COSCardRegistry alloc]initWithFilename:filename];
  return self;
}


- (void) createDisplayForPlayers:(NSArray*)p {
  self.players = p;
  gameLayout = [[COSGameLayout alloc]initWithPlayers:p];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
	return YES;
}  




@end
