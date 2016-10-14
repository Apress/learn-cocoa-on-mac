//
//  ButtonsAppDelegate.m
//  Buttons
//
//  Created by Jeff LaMarche on 3/15/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import "ButtonsAppDelegate.h"

@implementation ButtonsAppDelegate
@synthesize label;
- (IBAction)buttonPressed: (id)sender
{
	NSString *title = [sender title];
	NSString *labelText = [NSString stringWithFormat:@"%@ button pressed.", title];
	[label setStringValue:labelText];
}
- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication;
{
	return YES;
}
@end
