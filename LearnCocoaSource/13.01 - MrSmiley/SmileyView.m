//
//  SmileyView.m
//  MrSmiley
//
//  Created by JN on 9/28/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "SmileyView.h"


@implementation SmileyView

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code here.
    originalBounds = [self bounds];
  }
  return self;
}

- (void)setFrameSize:(NSSize)newSize
{
  [super setFrameSize:newSize];
  NSLog(@"SmileView setFrameSize:");
  [self setBounds:originalBounds];
}


- (void)drawRect:(NSRect)rect {
  [NSGraphicsContext saveGraphicsState];
  
  NSRect iRect = CGRectInset([self bounds], 5, 5);
  NSBezierPath *border = [NSBezierPath bezierPathWithRoundedRect:iRect
                                                         xRadius:5 yRadius:5];
  [[NSColor whiteColor] set]; 
  [border fill];
  
  [border setLineWidth:3];
  [[NSColor blackColor] set];
  [border stroke];

  NSBezierPath *head = [NSBezierPath bezierPathWithOvalInRect:CGRectInset([self bounds],20,20)];
  NSGradient *faceGradient = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:[NSColor lightGrayColor]];
  [faceGradient drawInBezierPath:head angle:45];
  [head setLineWidth:3];
  [head stroke];

  NSBezierPath *features = [NSBezierPath bezierPath];
  [features moveToPoint:NSMakePoint(35, 30)];
  [features lineToPoint:NSMakePoint(65, 30)];
  [features moveToPoint:NSMakePoint(40, 40)];
  [features lineToPoint:NSMakePoint(40, 40)];
  [features moveToPoint:NSMakePoint(60, 40)];
  [features lineToPoint:NSMakePoint(60, 40)];
  [features setLineCapStyle:NSRoundLineCapStyle];
  [features setLineWidth:3];
  [features stroke];
  
  [NSGraphicsContext restoreGraphicsState];
}

@end
