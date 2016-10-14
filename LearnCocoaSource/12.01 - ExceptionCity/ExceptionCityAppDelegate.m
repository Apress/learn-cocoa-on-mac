//
//  ExceptionCityAppDelegate.m
//  ExceptionCity
//
//  Created by JN on 9/11/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "ExceptionCityAppDelegate.h"


@implementation ExceptionCityAppDelegate

- (void)invalidArgumentException_unrecognizedSelector {
  // The downside of dynamism is the occasional type mismatch.
  // For instance, it's sometimes hard to be sure what's coming
  // out of an array.  Imagine this array is created somewhere...
  NSArray *nameComponents = [NSArray arrayWithObjects:
                             @"Thurston", 
                             @"Howell", 
                             [NSNumber numberWithInt:3], 
                             nil];
  // ... and accessed later on, by code that just assumes all the
  // array's items are strings:
  NSInteger nameComponentLength = 0;
  for (NSString *component in nameComponents) {
    nameComponentLength += [component length];
  }
  NSLog(@"Total length of all name components: %d", nameComponentLength);
}

- (void)invalidArgumentException_insertNil {
  // assuming we have an array to put things into...
  NSMutableArray *array = [NSMutableArray array];
  // ... we can add an object to it.
  id object1 = @"hello";
  [array addObject:object1];
  // but suppose we take a method parameter or instance variable
  // whose value we haven't checked to make sure it wasn't nil...
  id object2 = nil;
  // ... and try to add it to the array?
  [array addObject:object2];
  NSLog(@"inserted all the objects I could!");
}

- (void)rangeException {
  // assuming we have an array of things...
  NSArray *array = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];
  // ... we can ask for the index of an item...
  NSUInteger indexOfTwo = [array indexOfObject:@"two"];
  // ... and we can later retrieve that value using the same index.
  NSLog(@"found indexed item %@", [array objectAtIndex:indexOfTwo]);
  
  // But, what if we try to find the index for something that's not there?
  NSUInteger indexOfFive = [array indexOfObject:@"five"];
  // And we forget to check the return value to make sure it's not NSNotFound?
  NSLog(@"found indexed item %@", [array objectAtIndex:indexOfFive]);
}

- (void)uninitializedObject {
  NSMutableString *string = nil;
  [string appendFormat:@"foo"];
}

- (void)freedObject {
  id obj = [[NSObject alloc] init];
  NSLog(@"the object is %@", obj);
  [obj release];
  obj = nil;
  NSLog(@"the object is %@", obj);
}

- (void)fileError {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *fileError = nil;
  NSDictionary *attributes = [fileManager attributesOfItemAtPath:@"/tmpfoo" error:&fileError];
  if (fileError == nil) {
    NSRunAlertPanel(@"Found file attributes", [attributes description], nil, nil, nil);
  } else {
    // report the error
    [NSApp presentError:fileError];
  }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [self invalidArgumentException_unrecognizedSelector];
  [self invalidArgumentException_insertNil];
  [self rangeException];
  [self uninitializedObject];
  [self freedObject];
  [self fileError];
  NSRunAlertPanel(@"Success", @"Hooray, you fixed everything!", nil, nil, nil);
}

@end
