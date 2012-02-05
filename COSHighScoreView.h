//
//  COSHighScoreView.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSScoreView.h"

@class COSHighScoreTable;

@interface COSHighScoreView : COSScoreView {
  
  COSHighScoreTable *personalScoresTable, *overallScoresTable;
  
}

@end
