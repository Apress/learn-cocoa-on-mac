//
//  MenuLabAppDelegate.m
//  MenuLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "MenuLabAppDelegate.h"


@implementation MenuLabAppDelegate

@synthesize turbo;

- (IBAction)toggleTurbo:(id)sender
{
  self.turbo = !self.turbo;
}

@end
