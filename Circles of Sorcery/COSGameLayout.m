//
//  COSGameLayout.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "COSGameLayout.h"
#import "COSPlayerArea.h"
#import "COSOpponentTray.h"
#import "COSConstants.h"

@implementation COSGameLayout


- (void) dealloc {
  [playerOneArea release];
  [playerTwoArea release];
  [opponentTray release];
  [endTurnButton release];
  [super dealloc];
}


- (void) switchPlayers {
  COSPlayerArea *otherPlayerArea;
  if ([currentPlayerArea isEqual: playerOneArea]) {
    currentPlayerArea = playerTwoArea;
    otherPlayerArea = playerOneArea;
  } else {
    currentPlayerArea = playerOneArea;
    otherPlayerArea = playerTwoArea;    
  }
  [self addSubview:currentPlayerArea];
  [opponentTray addSubview:otherPlayerArea];

  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  currentPlayerArea.transform = CGAffineTransformIdentity;
  currentPlayerArea.frame = self.bounds;
  otherPlayerArea.transform = CGAffineTransformMakeRotation(M_PI);
  otherPlayerArea.frame = opponentTray.bounds;
  [otherPlayerArea endTurn];
  [UIView commitAnimations];
  [self sendSubviewToBack:endTurnButton];
  [self sendSubviewToBack:currentPlayerArea];
  [opponentTray sendSubviewToBack:otherPlayerArea];

}


- (void) newGame {
  
  COSPlayer *p = playerOneArea.player;
  for (UIView *v in [[[[UIApplication sharedApplication]delegate]window]subviews]) {
    [v removeFromSuperview];    
  }
  [[[UIApplication sharedApplication]delegate]launchGame];
  //[playerOneArea.widgets removeALlObjects];
  //[playerOneArea setWidgetFrames];
  //p.gold = 0;
  
}


- (id) initWithPlayers:(NSArray*)players {
  self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
  playerOneArea = [[COSPlayerArea alloc]initWithFrame:self.bounds forPlayer:[players objectAtIndex:0]];
  //playerTwoArea = [[COSPlayerArea alloc]initWithFrame:opponentTray.bounds forPlayer:[players objectAtIndex:1]];
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
  
  [self addSubview:playerOneArea];
  currentPlayerArea = playerOneArea;
  
  CGRect fr = playerOneArea.frame;
  fr.origin.y -= 20;
  playerOneArea.frame = fr;
  
  //CGRect trayFrame = CGRectMake(0, -668, self.frame.size.width, self.frame.size.height);
  //opponentTray = [[COSOpponentTray alloc]initWithFrame:trayFrame];
  //[self addSubview:opponentTray];
  
  //playerTwoArea.transform = CGAffineTransformMakeRotation(M_PI);
  
  //[opponentTray addSubview:playerTwoArea];
  //[opponentTray sendSubviewToBack:playerTwoArea];
  
  
  UIButton *newGameButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  newGameButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
  [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
  int buttonWidth = 150;
  int buttonHeight = 30;
  newGameButton.frame = CGRectMake(playerOneArea.frame.size.width-buttonWidth-PADDING, PADDING, buttonWidth, buttonHeight);
  [newGameButton addTarget:self action:@selector(newGame) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:newGameButton];

  endTurnButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  endTurnButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [endTurnButton setTitle:@"End Turn" forState:UIControlStateNormal];
  endTurnButton.frame = CGRectMake(PADDING, PADDING, buttonWidth, buttonHeight);
  [endTurnButton addTarget:playerOneArea.player action:@selector(doEndOfTurnEffects) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:endTurnButton];
  return self;


}



@end
