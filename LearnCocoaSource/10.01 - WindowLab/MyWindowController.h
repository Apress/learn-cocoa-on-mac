//
//  MyWindowController.h
//  WindowLab
//
//  Created by JN on 8/20/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MyWindowController : NSObject {
  NSWindow *window;
}

IBOutlet @property (retain) NSWindow *window;

@end
