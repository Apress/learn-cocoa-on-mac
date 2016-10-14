//
//  QuoteMonger_AppDelegate.h
//  QuoteMonger
//
//  Created by JN on 8/15/09.
//  Copyright Rebisoft Inc 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QuoteMonger_AppDelegate : NSObject 
{
  IBOutlet NSWindow *window;
  
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
  NSPredicate *searchPredicate;
}

@property (retain) NSPredicate *searchPredicate;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
