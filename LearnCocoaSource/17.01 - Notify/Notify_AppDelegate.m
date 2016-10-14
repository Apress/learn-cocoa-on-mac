//
//  Notify_AppDelegate.m
//  Notify
//
//  Created by JN on 12/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Notify_AppDelegate.h"

#import "Notifications.h"

@implementation Notify_AppDelegate

- (id)init {
  if ((self = [super init])) {
    [[NSNotificationCenter defaultCenter] addObserver:self 
     selector:@selector(receiveNetworkData:) 
     name:DATA_RECEIVED 
     object:nil];
  }
  return self;
}

- (void)receiveNetworkData:(NSNotification *)notification {
  NSLog(@"received notification: %@", notification);
  NSLog(@"received data", [[notification userInfo] objectForKey:@"data"]);
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super dealloc];
}

- (void)foo {
  [[NSNotificationCenter defaultCenter] postNotificationName:DATA_RECEIVED object:self];
  NSDictionary *info = [NSDictionary dictionaryWithObject:@"some_data" forKey:@"data"];
  [[NSNotificationCenter defaultCenter] postNotificationName:DATA_RECEIVED object:self userInfo:info];
}

- (void)enumerate {
  NSArray *array = [NSArray arrayWithObjects:@"one", "two", @"three"];
  
  // C-style enumeration
  int i;
  for (i = 0; i < [array count]; i++) {
    NSLog(@"C enumeration accessing object: %@", [array objectAtIndex:i]);
  }
  
  // NSEnumerator, the "classic" Cocoa way to enumerate
  NSEnumerator *aEnum = [array objectEnumerator];
  id obj1;
  while ((obj1 = [aEnum nextObject])) {
    NSLog(@"NSEnumerator accessing object: %@", obj1);
  }
  
  // "Fast enumeration", released as part of Leopard
  id obj2;
  for (obj2 in array) {
    NSLog(@"Fast enumeration accessing object: %@", obj2);    
  }
  
  // "Block enumeration", new in Snow Leopard
  [array enumerateObjectsUsingBlock:^(id obj3, NSUInteger i, BOOL *stop) {
    NSLog(@"Block enumeration accessing object: %@", obj3);
  }];
  
  NSArray *people;
  [people indexesOfObjectsPassingTest:
    (BOOL (^)(id obj, NSUInteger idx, BOOL *stop)){
    return [obj.firstName isEqual:@"Bob"];
  }];
}
  
@end
