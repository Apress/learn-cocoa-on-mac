//
//  DungeonThingAppDelegate.h
//  DungeonThing
//
//  Created by JN on 7/1/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DungeonThingAppDelegate : NSObject {
  NSMutableArray *characters;
  NSMutableArray *monsters;
  NSMutableArray *dungeons;
  IBOutlet NSArrayController *characterArrayController;
  IBOutlet NSArrayController *monsterArrayController;
  IBOutlet NSArrayController *dungeonArrayController;
}

@property (retain) NSMutableArray *characters;
@property (retain) NSMutableArray *monsters;
@property (retain) NSMutableArray *dungeons;

- (IBAction)createCharacter:(id)sender;
- (IBAction)createMonster:(id)sender;
- (IBAction)createDungeon:(id)sender;

@end
