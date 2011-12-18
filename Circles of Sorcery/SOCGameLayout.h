//
//  SOCGameLayout.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class  SOCPlayerArea, SOCOpponentTray;

@interface SOCGameLayout : UIViewController {
  SOCPlayerArea *playerOneArea, *playerTwoArea, *currentPlayerArea;
  SOCOpponentTray *opponentTray;
  UIButton *endTurnButton;
}


@end
