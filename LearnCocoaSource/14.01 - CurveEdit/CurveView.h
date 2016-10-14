//
//  CurveView.h
//  CurveEdit
//
//  Created by JN on 10/3/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CurveView : NSView {
  NSRect myBounds;
  CGFloat cp1X;
  CGFloat cp1Y;
  CGFloat cp2X;
  CGFloat cp2Y;
  BOOL draggingCp1;
  BOOL draggingCp2;
}

@property (assign) CGFloat cp1X;
@property (assign) CGFloat cp1Y;
@property (assign) CGFloat cp2X;
@property (assign) CGFloat cp2Y;

@end
