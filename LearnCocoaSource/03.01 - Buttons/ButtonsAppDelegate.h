//
//  ButtonsAppDelegate.h
//  Buttons
//
//  Created by Jeff LaMarche on 3/15/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ButtonsAppDelegate : NSObject 
{
	NSTextField		*label;
}
@property IBOutlet NSTextField *label;
- (IBAction)buttonPressed:(id)sender;
@end
