//
//  CurveEditAppDelegate.m
//  CurveEdit
//
//  Created by JN on 10/3/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "CurveView.h"
#import "CurveEditAppDelegate.h"


@implementation CurveEditAppDelegate

@synthesize cp1X, cp1Y, cp2X, cp2Y;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [curveView bind:@"cp1X" toObject:self withKeyPath:@"cp1X" options:nil];
  [curveView bind:@"cp1Y" toObject:self withKeyPath:@"cp1Y" options:nil];
  [curveView bind:@"cp2X" toObject:self withKeyPath:@"cp2X" options:nil];
  [curveView bind:@"cp2Y" toObject:self withKeyPath:@"cp2Y" options:nil];
  
  [self bind:@"cp1X" toObject:curveView withKeyPath:@"cp1X" options:nil];
  [self bind:@"cp1Y" toObject:curveView withKeyPath:@"cp1Y" options:nil];
  [self bind:@"cp2X" toObject:curveView withKeyPath:@"cp2X" options:nil];
  [self bind:@"cp2Y" toObject:curveView withKeyPath:@"cp2Y" options:nil];
  
  self.cp1X = 0.5;
  self.cp1Y = 0.0;
  self.cp2X = 0.5;
  self.cp2Y = 1.0;
}


@end
