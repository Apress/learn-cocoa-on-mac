//
//  VillainTrackerAppDelegate.m
//  VillainTracker
//
//  Created by JN on 5/16/09.
//  Copyright 2009 Rebisoft, Inc. All rights reserved.
//

#import "VillainTrackerAppDelegate.h"

#define kName @"name"
#define kLastKnownLocation @"lastKnownLocation"
#define kLastSeenDate @"lastSeenDate"
#define kSwornEnemy @"swornEnemy"
#define kPrimaryMotivation @"primaryMotivation"
#define kPowers @"powers"
#define kPowerSource @"powerSource"
#define kEvilness @"evilness"
#define kMugshot @"mugshot"
#define kNotes @"notes"

@interface VillainTrackerAppDelegate (privateMethods)
+ (NSArray *)motivations;
+ (NSArray *)powers;
- (void)updateDetailViews;
@end
@implementation VillainTrackerAppDelegate (privateMethods)
- (void)updateDetailViews {
  [nameView setStringValue:[villain objectForKey:kName]];
  [lastKnownLocationView setStringValue:[villain objectForKey:kLastKnownLocation]];
  [lastSeenDateView setDateValue:[villain objectForKey:kLastSeenDate]];
  if ([swornEnemyView indexOfItemWithObjectValue:[villain objectForKey:kSwornEnemy]]==NSNotFound) {
    [swornEnemyView addItemWithObjectValue:[villain objectForKey:kSwornEnemy]];
  }
  [swornEnemyView selectItemWithObjectValue:[villain objectForKey:kSwornEnemy]];
  [primaryMotivationView selectCellWithTag:[[[self class] motivations] indexOfObject:[villain objectForKey:kPrimaryMotivation]]];
  [powersView deselectAllCells];
  for (NSString *power in [[self class] powers]) {
    if ([[villain objectForKey:kPowers] containsObject:power]) {
      [powersView selectCellWithTag:[[[self class] powers] indexOfObject:power]];
    }
  }
  [evilnessView setIntegerValue:[[villain objectForKey:kEvilness] integerValue]];
  [powerSourceView setTitle:[villain objectForKey:kPowerSource]];
  [mugshotView setImage:[villain objectForKey:kMugshot]];
  [notesView setString:[villain objectForKey:kNotes]];
}
+ (NSArray *)motivations {
  static NSArray *motivations = nil;
  if (!motivations) {
    motivations = [[NSArray alloc] initWithObjects:@"Greed", @"Revenge", @"Bloodlust", @"Nihilism", @"Insanity", nil];
  }
  return motivations;
}
+ (NSArray *)powers {
  static NSArray *powers = nil;
  if (!powers) {
    powers = [[NSArray alloc] initWithObjects:@"Strength", @"Intellect", @"Psionics", @"Imperviousness", @"Speed", @"Stealth", @"Fighting ability", @"Time control", @"Cosmic consciousness", @"Size", @"Special weapon attack", @"Leadership", nil];
  }
  return powers;
}
@end

@implementation VillainTrackerAppDelegate

@synthesize villain;
@synthesize villains;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.villain = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  @"Lex Luthor", kName,
                  @"Smallville", kLastKnownLocation,
                  [NSDate date], kLastSeenDate,
                  @"Superman", kSwornEnemy,
                  @"Revenge", kPrimaryMotivation,
                  [NSArray arrayWithObjects:@"Intellect", @"Leadership", nil], kPowers,
                  @"Superhero action", kPowerSource,
                  [NSNumber numberWithInt:9], kEvilness,
                  [NSImage imageNamed:@"NSUser"], kMugshot,
                  @"", kNotes,
                  nil];
  self.villains = [NSMutableArray arrayWithObject:self.villain];
  [villainsTableView reloadData];
  [villainsTableView selectRow:0 byExtendingSelection:NO];
  [self updateDetailViews];
}

- (IBAction)takeName:(id)sender {
  [villain setObject:[sender stringValue] forKey:kName];
  [villainsTableView reloadData];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takeLastKnownLocation:(id)sender {
  [villain setObject:[sender stringValue] forKey:kLastKnownLocation];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takeLastSeenDate:(id)sender {
  [villain setObject:[sender dateValue] forKey:kLastSeenDate];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takeSwornEnemy:(id)sender {
  [villain setObject:[sender stringValue] forKey:kSwornEnemy];
  [villainsTableView reloadData];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takePrimaryMotivation:(id)sender {
  [villain setObject:[[sender selectedCell] title] forKey:kPrimaryMotivation];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takePowerSource:(id)sender {
  [villain setObject:[sender title] forKey:kPowerSource];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takePowers:(id)sender {
  NSMutableArray *powers = [NSMutableArray array];
  for (NSCell *cell in [sender cells]) {
    if ([cell state]==NSOnState) {
      [powers addObject:[cell title]];
    }
  }
  [villain setObject:powers forKey:kPowers];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takeEvilness:(id)sender {
  [villain setObject:[NSNumber numberWithInteger:[sender integerValue]] forKey:kEvilness];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)takeMugshot:(id)sender {
  [villain setObject:[sender image] forKey:kMugshot];
  NSLog(@"current villain properties: %@", villain);
}
- (IBAction)newVillain:(id)sender {
  [window endEditingFor:nil];
  [villains addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                       @"", kName,
                       @"", kLastKnownLocation,
                       [NSDate date], kLastSeenDate,
                       @"", kSwornEnemy,
                       @"Greed", kPrimaryMotivation,
                       [NSArray array], kPowers,
                       @"", kPowerSource,
                       [NSNumber numberWithInt:0], kEvilness,
                       [NSImage imageNamed:@"NSUser"], kMugshot,
                       @"" , kNotes,
                       nil]];
  [villainsTableView reloadData];
  [villainsTableView selectRow:[villains count]-1 byExtendingSelection:NO];
}
- (IBAction)deleteVillain:(id)sender {
  [window endEditingFor:nil];
  int selectedRow = [villainsTableView selectedRow];
  [villains removeObjectIdenticalTo:villain];
  [villainsTableView reloadData];
  if (selectedRow>=[villains count]) {
    selectedRow = [villains count]-1;
  }
  if (selectedRow > -1) {
    // deselect all rows to ensure that the tableview sees the selection as "changed", even though it
    // might be the same row index.
    [villainsTableView deselectAll:nil];
    [villainsTableView selectRow:selectedRow byExtendingSelection:NO];
    [self updateDetailViews];
  }
}

#pragma mark NSText delegate methods
- (void)textDidChange:(NSNotification *)aNotification {
  [self.villain setObject:[[notesView string] copy] forKey:kNotes];
  NSLog(@"current villain properties: %@", villain);
}

#pragma mark NSTableView dataSource methods
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [villains count];
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
  return [[villains objectAtIndex:rowIndex] objectForKey:[aTableColumn identifier]];
}
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
  [[villains objectAtIndex:rowIndex] setObject:anObject forKey:[aTableColumn identifier]];
  [self updateDetailViews];
}

#pragma mark NSTableview delegate methods
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
  if ([villainsTableView selectedRow]>-1) {
    self.villain = [self.villains objectAtIndex:[villainsTableView selectedRow]];
    [self updateDetailViews];
    NSLog(@"current villain properties: %@", villain);
  }
}

@end
