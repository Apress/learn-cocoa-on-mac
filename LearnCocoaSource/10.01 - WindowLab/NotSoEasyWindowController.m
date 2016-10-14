//
//  NotSoEasyWindow.m
//  WindowLab
//
//  Created by JN on 8/31/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "NotSoEasyWindowController.h"


@implementation NotSoEasyWindowController

- init
{
  if ((self = [super initWithWindowNibName:@"NotSoEasyWindow"])) {
    [self window];
  }
  return self;
}

- (IBAction)beep:(id)sender
{
  NSBeep();
}

@end
