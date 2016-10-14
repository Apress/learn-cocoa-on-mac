//
//  VillainTrackerAppDelegate.h
//  VillainTracker
//
//  Created by JN on 5/16/09.
//  Copyright 2009 Rebisoft, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VillainTrackerAppDelegate : NSObject {
  IBOutlet NSTextField *nameView;
  IBOutlet NSTextField *lastKnownLocationView;
  IBOutlet NSDatePicker *lastSeenDateView;
  IBOutlet NSComboBox *swornEnemyView;
  IBOutlet NSMatrix *primaryMotivationView; // a matrix of radiobuttons
  IBOutlet NSMatrix *powersView; // a matrix of checkboxes
  IBOutlet NSPopUpButton *powerSourceView;
  IBOutlet NSLevelIndicator *evilnessView;
  IBOutlet NSImageView *mugshotView;
  IBOutlet NSTextView *notesView;
  IBOutlet NSTableView *villainsTableView;
  IBOutlet NSWindow *window;
  
  NSMutableDictionary *villain;
  NSMutableArray *villains;
}

@property (retain) NSMutableDictionary *villain;
@property (retain) NSMutableArray *villains;

- (IBAction)takeName:(id)sender;
- (IBAction)takeLastKnownLocation:(id)sender;
- (IBAction)takeLastSeenDate:(id)sender;
- (IBAction)takeSwornEnemy:(id)sender;
- (IBAction)takePrimaryMotivation:(id)sender;
- (IBAction)takePowerSource:(id)sender;
- (IBAction)takePowers:(id)sender;
- (IBAction)takeEvilness:(id)sender;
- (IBAction)takeMugshot:(id)sender;
- (IBAction)newVillain:(id)sender;
- (IBAction)deleteVillain:(id)sender;

@end
