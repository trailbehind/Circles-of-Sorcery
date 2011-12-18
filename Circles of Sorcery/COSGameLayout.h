//
//  COSGameLayout.h
//  Circles of Sorcery
//
//  Created by EFB on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class  COSPlayerArea, COSOpponentTray;

@interface COSGameLayout : UIViewController {
  COSPlayerArea *playerOneArea, *playerTwoArea, *currentPlayerArea;
  COSOpponentTray *opponentTray;
  UIButton *endTurnButton;
}


@end
