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
#import "COSPlayer.h"
#import "COSGame.h"
#import "COSAppDelegate.h"

@implementation COSGameLayout


- (void) dealloc {
  [playerOneArea release];
  [playerTwoArea release];
  [opponentTray release];
  [endTurnButton release];
  [super dealloc];
}


/*- (void) switchPlayers {
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

}*/


- (void) showRules {
  NSString *message = @"Play Farmers and then Farms to get Gold.\n\nUse Gold to buy cards.\n\nUse cards to get the highest score!";
  UIAlertView *av = [[[UIAlertView alloc]initWithTitle:@"How to Play" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
  [av show];
}


- (void) setupWithPlayers:(NSArray*)players {
  for (UIView *v in [self subviews]) {
    [v removeFromSuperview];
  }
  COSPlayer *playerOne = [players objectAtIndex:0];
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
 
  playerOneArea = [[COSPlayerArea alloc]initWithFrame:self.bounds forPlayer:playerOne];
  //playerTwoArea = [[COSPlayerArea alloc]initWithFrame:opponentTray.bounds forPlayer:[players objectAtIndex:1]];
  
  
  [self addSubview:playerOneArea];
  currentPlayerArea = playerOneArea;
  
  //CGRect fr = playerOneArea.frame;
  //fr.origin.y -= 20;
  //playerOneArea.frame = fr;
  
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
  int buttonHeight = 50;
  newGameButton.frame = CGRectMake(playerOneArea.frame.size.width-buttonWidth-PADDING, PADDING, buttonWidth, buttonHeight);
  [newGameButton addTarget:[(COSAppDelegate*)[[UIApplication sharedApplication]delegate]game] action:@selector(makeNewGame) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:newGameButton];

  UIButton *deckEditorButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  deckEditorButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
  [deckEditorButton setTitle:@"Edit Deck" forState:UIControlStateNormal];
  deckEditorButton.frame = CGRectMake(playerOneArea.frame.size.width-buttonWidth-PADDING, buttonHeight +PADDING*2, buttonWidth, buttonHeight);
  [deckEditorButton addTarget:[(COSAppDelegate*)[[UIApplication sharedApplication]delegate]game] action:@selector(showDeckBuilder) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:deckEditorButton];

  UIButton *howtoButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  howtoButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
  [howtoButton setTitle:@"How to Play" forState:UIControlStateNormal];
  howtoButton.frame = CGRectMake(playerOneArea.frame.size.width-buttonWidth-PADDING, buttonHeight*2 +PADDING*3, buttonWidth, buttonHeight);
  [howtoButton addTarget:self action:@selector(showRules) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:howtoButton];

  
  
  endTurnButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  endTurnButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  [endTurnButton setTitle:@"End Turn" forState:UIControlStateNormal];
  endTurnButton.frame = CGRectMake(PADDING, PADDING, buttonWidth, buttonHeight);
  [endTurnButton addTarget:playerOneArea.player action:@selector(doEndOfTurnEffects:) forControlEvents:UIControlEventTouchUpInside];
  [playerOneArea addSubview:endTurnButton];


}



@end
