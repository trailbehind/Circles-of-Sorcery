//
//  SOCGameLayout.m
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SOCGameLayout.h"
#import "SOCPlayerArea.h"
#import "SOCOpponentTray.h"
#import "SOCConstants.h"

@implementation SOCGameLayout


- (void) dealloc {
  [playerOneArea release];
  [playerTwoArea release];
  [opponentTray release];
  [endTurnButton release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) switchPlayers {
  SOCPlayerArea *otherPlayerArea;
  if ([currentPlayerArea isEqual: playerOneArea]) {
    currentPlayerArea = playerTwoArea;
    otherPlayerArea = playerOneArea;
  } else {
    currentPlayerArea = playerOneArea;
    otherPlayerArea = playerTwoArea;    
  }
  [self.view addSubview:currentPlayerArea];
  [opponentTray addSubview:otherPlayerArea];

  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  currentPlayerArea.transform = CGAffineTransformIdentity;
  currentPlayerArea.frame = self.view.bounds;
  otherPlayerArea.transform = CGAffineTransformMakeRotation(M_PI);
  otherPlayerArea.frame = opponentTray.bounds;
  [UIView commitAnimations];
  [self.view sendSubviewToBack:endTurnButton];
  [self.view sendSubviewToBack:currentPlayerArea];
  [opponentTray sendSubviewToBack:otherPlayerArea];

}


#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;

  
  playerOneArea = [[SOCPlayerArea alloc]initWithFrame:self.view.bounds deckName:@"elemental_deck.csv"];
  [self.view addSubview:playerOneArea];
  currentPlayerArea = playerOneArea;
  
  CGRect trayFrame = CGRectMake(0, -668, self.view.frame.size.width, self.view.frame.size.height);
  opponentTray = [[SOCOpponentTray alloc]initWithFrame:trayFrame];
  [self.view addSubview:opponentTray];

  playerTwoArea = [[SOCPlayerArea alloc]initWithFrame:opponentTray.bounds deckName:@"nature_deck.csv"];
  playerTwoArea.transform = CGAffineTransformMakeRotation(M_PI);

  [opponentTray addSubview:playerTwoArea];
  [opponentTray sendSubviewToBack:playerTwoArea];
  

  endTurnButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  endTurnButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
  [endTurnButton setTitle:@"End Turn" forState:UIControlStateNormal];
  int buttonWidth = 150;
  int buttonHeight = 30;
  endTurnButton.frame = CGRectMake(PADDING, PADDING+80, buttonWidth, buttonHeight);
  [endTurnButton addTarget:self action:@selector(switchPlayers) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:endTurnButton];
  [self.view sendSubviewToBack:endTurnButton];
  [self.view sendSubviewToBack:playerOneArea];

  

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

@end
