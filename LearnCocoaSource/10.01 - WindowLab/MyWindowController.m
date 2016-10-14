//
//  MyWindowController.m
//  WindowLab
//
//  Created by JN on 8/20/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "MyWindowController.h"


@implementation MyWindowController

@synthesize window;

- init
{
  if ((self = [super init])) {
    [NSBundle loadNibNamed:@"MyWindow" owner:self];
  }
  return self;
}
@end
