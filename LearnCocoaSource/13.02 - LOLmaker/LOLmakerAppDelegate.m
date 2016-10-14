//
//  LOLmakerAppDelegate.m
//  LOLmaker
//
//  Created by JN on 9/30/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "LOLmakerAppDelegate.h"
#import "LOLView.h"

@implementation LOLmakerAppDelegate

@synthesize image;
@synthesize text;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [lolView bind:@"image" toObject:self withKeyPath:@"image" options:nil];
  [lolView bind:@"text" toObject:self withKeyPath:@"text" options:nil];
}

@end
