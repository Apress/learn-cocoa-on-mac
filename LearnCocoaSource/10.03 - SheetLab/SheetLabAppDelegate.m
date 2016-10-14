//
//  SheetLabAppDelegate.m
//  SheetLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "SheetLabAppDelegate.h"


@implementation SheetLabAppDelegate
- (IBAction)runSaveSheet:(id)sender
{
  NSSavePanel *panel = [NSSavePanel savePanel];
  [panel beginSheetForDirectory:nil file:nil modalForWindow:window modalDelegate:self didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}
- (void)savePanelDidEnd:(NSSavePanel *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
  if (returnCode==NSOKButton) {
    NSRunAlertPanel(@"Saving! (just pretending)", @"You chose to save in the file:\n\n%@", nil, nil, nil, [sheet filename]);
  }
}

- (IBAction)runCustomSheet:(id)sender
{
  [NSApp beginSheet:customSheetWindow modalForWindow:window modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
  if (returnCode==NSOKButton) {
    NSRunAlertPanel(@"Hooray!", @"You clicked the OK button!  Awesome.", nil, nil, nil);
  }
}
- (IBAction)customSheetOk:(id)sender {
  [NSApp endSheet:customSheetWindow returnCode:NSOKButton];
  [customSheetWindow orderOut:nil];
}
- (IBAction)customSheetCancel:(id)sender {
  [NSApp endSheet:customSheetWindow returnCode:NSCancelButton];
  [customSheetWindow orderOut:nil];
}

@end
