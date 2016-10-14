//
//  ListWindowDelegate.m
//  MenuLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ListWindowDelegate.h"


@implementation ListWindowDelegate

@synthesize selectedTag;

- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem
{
  SEL theAction = [anItem action];
  
  if (theAction == @selector(specialAction:))
  {
    if (self.selectedTag == 13013) {
      return YES;
    } else {
      return NO;
    }
  }
  // default, in case it's not the action we care about
  return YES;
}

- (void)specialAction:(id)sender {
  NSRunAlertPanel(@"Boy Howdy!", @"That's some mighty special action you got there!", @"Ayup.", nil, nil);
}

@end
