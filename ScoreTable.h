//
//  ScoreTable.h
//  Circles of Sorcery
//
//  Created by EFB on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class COSScoreKeeper;

@interface ScoreTable : UITableView <UITableViewDelegate, UITableViewDataSource> {
  
  COSScoreKeeper *scoreKeeper;
  
}

- (id) initWithScoreKeeper:(COSScoreKeeper*)keeper;

@end
