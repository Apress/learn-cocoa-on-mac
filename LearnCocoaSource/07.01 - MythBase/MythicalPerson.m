//
//  MythicalPerson.m
//  MythBase
//
//  Created by JN on 7/25/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "MythicalPerson.h"

@implementation MythicalPerson

- (int)awesomeness
{
  //[self willAccessValueForKey:@"divinity"];
  //[self willAccessValueForKey:@"power"];
  //[self willAccessValueForKey:@"goodness"];

  int awesomeness = [[self valueForKey:@"divinity"] intValue] * 10 +
    [[self valueForKey:@"power"] intValue] * 5 +
  [[self valueForKey:@"goodness"] intValue];
  
  //[self didAccessValueForKey:@"divinity"];
  //[self didAccessValueForKey:@"power"];
  //[self didAccessValueForKey:@"goodness"];

  return awesomeness;
}

+ (NSSet *)keyPathsForValuesAffectingAwesomeness
{
  return [NSSet setWithObjects:@"divinity", @"power", @"goodness", nil];
}

-(BOOL)validateName:(id *)ioValue error:(NSError **)outError {
  if (*ioValue == nil) {
    return YES;
  }
  if ([*ioValue isEqualToString:@"Bob"]) {
    if (outError != NULL) {
      NSString *errorStr = NSLocalizedString(
        @"You're not allowed to name a mythical person \"Bob\".  \"Bob\" is real, just like you and me.",
        @"validation: invalid name error");
      NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr
        forKey:NSLocalizedDescriptionKey];
      NSError *error = [[[NSError alloc] initWithDomain:@"MythicalPersonErrorDomain"
        code:13013 userInfo:userInfoDict] autorelease];
      *outError = error;
    }
    return NO;
  }
  return YES;
}

- (NSError *)errorFromOriginalError:(NSError *)originalError error:(NSError *)secondError
{
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
  NSMutableArray *errors = [NSMutableArray arrayWithObject:secondError];
  
  if ([originalError code] == NSValidationMultipleErrorsError) {
    
    [userInfo addEntriesFromDictionary:[originalError userInfo]];
    [errors addObjectsFromArray:[userInfo objectForKey:NSDetailedErrorsKey]];
  }
  else {
    [errors addObject:originalError];
  }
  
  [userInfo setObject:errors forKey:NSDetailedErrorsKey];
  
  return [NSError errorWithDomain:NSCocoaErrorDomain
                             code:NSValidationMultipleErrorsError
                         userInfo:userInfo];
}
- (BOOL)validateConsistency:(NSError **)error
{
  int d = [[self valueForKey:@"divinity"] intValue];
  int p = [[self valueForKey:@"power"] intValue];
  if (d < 100 && p > 50) {
    if (error != NULL) {
      NSString *errorStr = NSLocalizedString(
                                             @"Power cannot exceed 50 unless divinity is 100",
                                             @"validation: divinity / power error");
      NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr
                                                               forKey:NSLocalizedDescriptionKey];
      NSError *divinityPowerError = [[[NSError alloc] initWithDomain:@"MythicalPersonErrorDomain"
                                           code:182 userInfo:userInfoDict] autorelease];
      // if there was no previous error, return the new error
      if (*error == nil) {
        *error = divinityPowerError;
      }
      // if there was a previous error, combine it with the existing one
      else {
        *error = [self errorFromOriginalError:*error error:divinityPowerError];
      }
    }
    return NO;
  }
  return YES;
}
- (BOOL)validateForInsert:(NSError **)error
{
  BOOL propertiesValid = [super validateForInsert:error];
  // could stop here if invalid
  BOOL consistencyValid = [self validateConsistency:error];
  return (propertiesValid && consistencyValid);
}

- (BOOL)validateForUpdate:(NSError **)error
{
  BOOL propertiesValid = [super validateForUpdate:error];
  // could stop here if invalid
  BOOL consistencyValid = [self validateConsistency:error];
  return (propertiesValid && consistencyValid);
}

@end
