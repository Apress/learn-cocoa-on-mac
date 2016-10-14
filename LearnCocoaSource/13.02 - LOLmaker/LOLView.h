//
//  LOLView.h
//  LOLmaker
//
//  Created by JN on 10/1/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LOLView : NSView {
  NSImage *image;
  NSString *text;
}

@property (retain) NSImage *image;
@property (copy) NSString *text;

@end
