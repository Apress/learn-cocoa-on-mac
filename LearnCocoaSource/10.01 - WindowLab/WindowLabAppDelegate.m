//
//  WindowLabAppDelegate.m
//  WindowLab
//
//  Created by JN on 8/20/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "WindowLabAppDelegate.h"

#import "MyWindowController.h"
#import "NotSoEasyWindowController.h"

@implementation WindowLabAppDelegate
@synthesize textColor;
- (IBAction)showColorPanel:(id)sender
{
  NSColorPanel *panel = [NSColorPanel sharedColorPanel];
  [panel orderFront:nil];
}
// NSColorPanel delegate method
- (void)changeColor:(id)sender
{
  [title setTextColor:[sender color]];
}

- (IBAction)showFontPanel:(id)sender
{
  NSFontPanel *panel = [NSFontPanel sharedFontPanel];
  NSFontManager *manager = [NSFontManager sharedFontManager];
  [manager setSelectedFont:[title font] isMultiple:NO];
  [panel orderFront:nil];
}
// NSFontManager triggers this
- (void)changeFont:(id)sender
{
  NSFont *oldFont = [title font];
  NSFont *newFont = [sender convertFont:oldFont];
  [title setFont:newFont];
}


- (IBAction)showMyWindow:(id)sender
{
  [[MyWindowController alloc] init];
}

- (IBAction)runModalAlert:(id)sender
{
  NSRunAlertPanel(@"Basic Usage", @"This is a plain alert panel.", nil, nil, nil);
  NSRunAlertPanel(@"Three Buttons", @"We can set button titles:", @"Really?", @"Oh, how delightful!", @"Whatever.");
  NSRunAlertPanel(@"Formatting Strings", @"We can also use the message as a formatting string, %@ %@", nil, nil, nil, @"putting values for insertion at the end,", @"after the three button values.");
  switch (NSRunAlertPanel(@"Noticing The Selection", @"And of course, we can detect which button is clicked.", @"Default", @"Alternate", @"Other")) {
    case NSAlertDefaultReturn:
      NSRunAlertPanel(@"Result:", @"You pressed the default button", nil, nil, nil);
      break;
    case NSAlertAlternateReturn:
      NSRunAlertPanel(@"Result:", @"You pressed the alternate button", nil, nil, nil);
      break;
    case NSAlertOtherReturn:
      NSRunAlertPanel(@"Result:", @"You pressed the other button", nil, nil, nil);
      break;
    default:
      break;
  }
  
}


- (IBAction)copyFileX:(id)sender
{
  NSOpenPanel *openPanel = [NSOpenPanel openPanel];
  [openPanel setTitle:@"Select file to copy:"];
  if ([openPanel runModalForTypes:nil] == NSOKButton) {
    // get the first (and only) selected filename
    NSString *openPath = [[openPanel filenames] objectAtIndex:0];
    // pull out just the filename, without directory path
    NSString *openFilename = [openPath lastPathComponent];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Enter destination filename:"];
    // run the save panel in its default directory, with the opened filename
    // as a suggestion.
    if ([savePanel runModalForDirectory:nil file:openFilename] == NSOKButton) {
      NSString *savePath = [savePanel filename];
      NSString *message = [NSString stringWithFormat:
        @"You've opened this file:\n\n%@\n\nand saved it here:\n\n%@\n\n",
        openPath, savePath];
      NSRunAlertPanel(@"Copying file (not really)", message, nil, nil, nil);
    }
  }
}

- (IBAction)copyFile:(id)sender
{
  NSOpenPanel *openPanel = [NSOpenPanel openPanel];
  [openPanel setTitle:@"Select file to copy:"];
  if ([openPanel runModalForTypes:nil] == NSOKButton) {
    // get the first (and only) selected filename
    NSString *openPath = [[openPanel filenames] objectAtIndex:0];
    // pull out just the filename, without directory path
    NSString *openFilename = [openPath lastPathComponent];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Enter destination filename:"];
    // run the save panel in its default directory, with the opened filename
    // as a suggestion.
    if ([savePanel runModalForDirectory:nil file:openFilename] == NSOKButton) {
      NSString *savePath = [savePanel filename];
      NSString *message = [NSString stringWithFormat:
                           @"You've opened this file:\n\n%@\n\nand saved it here:\n\n%@\n\n",
                           openPath, savePath];
      NSRunAlertPanel(@"Copying file (not really)", message, nil, nil, nil);
    }
  }
}

- (IBAction)loadEasyWindow:(id)sender
{
  NSWindowController *easyController = [[NSWindowController alloc] initWithWindowNibName:@"EasyWindow"];
  [easyController window];
}

- (IBAction)loadNotSoEasyWindow:(id)sender
{
  [[NotSoEasyWindowController alloc] init];
}



@end
