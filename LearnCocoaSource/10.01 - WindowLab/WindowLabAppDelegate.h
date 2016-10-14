//
//  WindowLabAppDelegate.h
//  WindowLab
//
//  Created by JN on 8/20/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WindowLabAppDelegate : NSObject {
  IBOutlet NSTextField *title;
  NSColor *textColor;
}
@property (retain) NSColor *textColor;
- (IBAction)showColorPanel:(id)sender;
- (IBAction)showFontPanel:(id)sender;
- (IBAction)showMyWindow:(id)sender;
- (IBAction)runModalAlert:(id)sender;
- (IBAction)copyFile:(id)sender;

- (IBAction)loadEasyWindow:(id)sender;
- (IBAction)loadNotSoEasyWindow:(id)sender;

@end
