//
//  FlipItAppDelegate.h
//  FlipIt
//
//  Created by JN on 10/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FlipItAppDelegate : NSObject {
  IBOutlet NSBox *box;
  IBOutlet NSTabView *tabView;
  NSView *leftView;
  NSView *rightView;
  NSView *middleView;
  NSArray *items;
  NSInteger currentTabIndex;
}

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;

@end
