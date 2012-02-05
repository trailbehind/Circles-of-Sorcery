//
//  COSDeckBuilderTableView.m
//  Circles of Sorcery
//
//  Created by EFB on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "COSDeckBuilderTableView.h"
#import "COSCardRegistry.h"
#import "COSDeck.h"
#import "COSCard.h"

@implementation COSDeckBuilderTableView
@synthesize spinners, pickerIndex;

- (void) dealloc {
  [registry release];
  [defaultDeckFile release];
  [defaultCounts release];
  [spinners release];
  [pickerIndex release];
  [super dealloc];
}

- (void) loadView {
  [super loadView];
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


- (id) initWithRegistry:(COSCardRegistry*)r defaultDeckFile:(NSString*)ddf {
  self = [super init];
  registry = [r retain];
  defaultDeckFile = [ddf retain];
  return self;
}

- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {	
  // nothing
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return ([[registry cardList]count]+2)/3.0f;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (UILabel *)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 50.0)] autorelease];
	}
  retval.text = [NSString stringWithFormat:@"%d", row];
	//retval.lineBreakMode = UILineBreakModeWordWrap;
	retval.textAlignment = UITextAlignmentCenter;
	retval.font = [UIFont systemFontOfSize:20];
	//retval.backgroundColor = [UIColor clearColor];
	return retval;	
}


- (CGSize)rowSizeForComponent:(NSInteger)component {
	return CGSizeMake(300,50);
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 100;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
// nothing
 }


- (NSString*) defaultDeckPath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  return [documentsDirectory stringByAppendingString:@"/defaultDeck.txt"];
}

- (NSString*) lastDefaultDeck {
  if ([[NSFileManager defaultManager] fileExistsAtPath:[self defaultDeckPath]]) {  
    return [self defaultDeckPath];
  } else {
    return [[NSBundle mainBundle] pathForResource:@"farmer deck.txt" ofType:nil];
  }
}

- (NSMutableDictionary*) defaultCounts {
  if (!defaultCounts) {
    defaultCounts = [[NSMutableDictionary dictionary]retain];    
    COSDeck *deck = [[[COSDeck alloc]initForFilename:[self lastDefaultDeck] player:nil game:nil]autorelease];
    for (COSCard *c in deck.cards) {
      NSNumber *count = [[self defaultCounts] objectForKey:c.name];
      if (!count) {
        [defaultCounts setObject:[NSNumber numberWithInt:1] forKey:c.name];
        NSLog(@"counts dict adding card, %@", c.name);
      } else {
        int newInt = [count intValue] + 1;
        NSNumber *newNum = [NSNumber numberWithInt:newInt];
        [defaultCounts setObject:newNum forKey:c.name];      
      }
    }
  }
  return defaultCounts;
}

- (NSMutableDictionary*) pickerIndex {
  if (pickerIndex) {
    return pickerIndex;
  }
 pickerIndex = [[NSMutableDictionary dictionary]retain];
  [self spinners];
  return pickerIndex;
}


- (NSArray*)spinners {
  if (spinners) {
    return spinners;
  }
  spinners = [[NSMutableArray array]retain];
  for (NSDictionary *dict in registry.cardList) {
    UIPickerView *pv = [[[UIPickerView alloc]init]autorelease];
    [spinners addObject:pv];
    //pv.tag = pickerTag;
    pv.showsSelectionIndicator = YES;
    
    pv.delegate = self;
    NSString *cardName = [dict objectForKey:@"name"];
    [pv selectRow:[[[self defaultCounts]objectForKey:cardName]intValue] inComponent:0 animated:NO];    
    [spinners addObject:pv];
    [pickerIndex setObject:pv forKey:cardName];
  }
  return spinners;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"meh";
  UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
   
  } else {
    for (UIView *v in cell.contentView.subviews) {
      if ([v isKindOfClass:[UIPickerView class]]) {
        [v removeFromSuperview];
      }
    }
  }
  int pickerTag = indexPath.row*3;
  int count = 0;
  for (int x=0;x<3;x++) {
    if (pickerTag + x >= [[registry cardList]count]) {
      break;
    }
    
    NSString *cardName = [[[registry cardList]objectAtIndex:pickerTag + x]objectForKey:@"name"];
    
    UIPickerView *pv = [[self pickerIndex] objectForKey:cardName];      
    [cell.contentView addSubview:pv];
    if (!pv) {
      count++;
      return cell;
    }
    UILabel *l = [[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
    l.backgroundColor = [UIColor clearColor];
    l.text = cardName;
    [cell.contentView addSubview:l];
    CGRect labelFrame = l.frame;
    labelFrame.origin.x = 20+count*(pv.frame.size.width+30);
    labelFrame.origin.y = 20;
    labelFrame.size.width = 200;
    labelFrame.size.height = 20;
    l.frame = labelFrame;
    CGRect fr = pv.frame;
    fr.origin.x = count*(fr.size.width+30);
    pv.frame = fr;
    // pickerTag++;
    count++;
  }
	return cell;
}
  

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 230.0;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
 return YES;
}  



@end
