//
//  SheetLabAppDelegate.h
//  SheetLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SheetLabAppDelegate : NSObject {
  IBOutlet NSWindow *window;
  IBOutlet NSWindow *customSheetWindow;
}

- (IBAction)runSaveSheet:(id)sender;
- (IBAction)runCustomSheet:(id)sender;

- (IBAction)customSheetOk:(id)sender;
- (IBAction)customSheetCancel:(id)sender;

@end
