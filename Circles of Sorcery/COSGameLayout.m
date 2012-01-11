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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
  [self.view addSubview:currentPlayerArea];
  [opponentTray addSubview:otherPlayerArea];

  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.25];
  currentPlayerArea.transform = CGAffineTransformIdentity;
  currentPlayerArea.frame = self.view.bounds;
  otherPlayerArea.transform = CGAffineTransformMakeRotation(M_PI);
  otherPlayerArea.frame = opponentTray.bounds;
  [otherPlayerArea endTurn];
  [UIView commitAnimations];
  [self.view sendSubviewToBack:endTurnButton];
  [self.view sendSubviewToBack:currentPlayerArea];
  [opponentTray sendSubviewToBack:otherPlayerArea];

}


#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;

  
  playerOneArea = [[COSPlayerArea alloc]initWithFrame:self.view.bounds deckName:@"farmer deck.csv"];
  [self.view addSubview:playerOneArea];
  currentPlayerArea = playerOneArea;
  
  CGRect trayFrame = CGRectMake(0, -668, self.view.frame.size.width, self.view.frame.size.height);
  opponentTray = [[COSOpponentTray alloc]initWithFrame:trayFrame];
  [self.view addSubview:opponentTray];

  playerTwoArea = [[COSPlayerArea alloc]initWithFrame:opponentTray.bounds deckName:@"farmer deck.csv"];
  playerTwoArea.transform = CGAffineTransformMakeRotation(M_PI);

  [opponentTray addSubview:playerTwoArea];
  [opponentTray sendSubviewToBack:playerTwoArea];
  

  endTurnButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
  endTurnButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
  [endTurnButton setTitle:@"End Turn" forState:UIControlStateNormal];
  int buttonWidth = 150;
  int buttonHeight = 30;
  endTurnButton.frame = CGRectMake(PADDING, opponentTray.frame.size.height-buttonHeight-PADDING, buttonWidth, buttonHeight);
  [endTurnButton addTarget:self action:@selector(switchPlayers) forControlEvents:UIControlEventTouchUpInside];
  [opponentTray addSubview:endTurnButton];
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
