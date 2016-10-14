//
//  ColorView.h
//  ColorMix
//
//  Created by JN on 9/4/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ColorBlendView : NSView {
  NSColor * color1;
  NSColor * color2;
  CGBlendMode blendMode;
}
@property (retain) NSColor * color1;
@property (retain) NSColor * color2;
@property (assign) CGBlendMode blendMode;

@end
