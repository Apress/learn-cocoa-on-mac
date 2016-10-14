//
//  CurveView.m
//  CurveEdit
//
//  Created by JN on 10/3/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "CurveView.h"

#define CP_RADIUS 0.1
#define CP_DIAMETER (CP_RADIUS*2)
#define BACKGROUND_COLOR [NSColor whiteColor]
#define GRID_STROKE_COLOR [NSColor lightGrayColor]
#define GRID_FILL_COLOR [NSColor colorWithCalibratedWhite:0.9 alpha:1.0]
#define CURVE_COLOR [NSColor blackColor]
#define LINE_TO_CP_COLOR [NSColor darkGrayColor]
#define CP_GRADIENT_COLOR1 [NSColor lightGrayColor]
#define CP_GRADIENT_COLOR2 [NSColor darkGrayColor]
#define CP_GRADIENT_HIGHLIGHT_COLOR1 [NSColor whiteColor]
#define CP_GRADIENT_HIGHLIGHT_COLOR2 [NSColor redColor]

static BOOL pointsWithinDistance(NSPoint p1, NSPoint p2, CGFloat d) {
  return pow((p1.x-p2.x), 2) + pow((p1.y - p2.y), 2) <= pow(d, 2); 
}
@implementation CurveView

@synthesize cp1X, cp1Y, cp2X, cp2Y;

- (void)setCp1X:(CGFloat)f {
  cp1X = MAX(MIN(f, 1.0), 0.0);
  [self setNeedsDisplay:YES];
}

- (void)setCp1Y:(CGFloat)f {
  cp1Y = MAX(MIN(f, 1.0), 0.0);
  [self setNeedsDisplay:YES];
}

- (void)setCp2X:(CGFloat)f {
  cp2X = MAX(MIN(f, 1.0), 0.0);
  [self setNeedsDisplay:YES];
}

- (void)setCp2Y:(CGFloat)f {
  cp2Y = MAX(MIN(f, 1.0), 0.0);
  [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code here.
    myBounds = NSMakeRect(-0.1, -0.1, 1.2, 1.2);
    [self setBounds:myBounds];
  }
  return self;
}

- (void)awakeFromNib {
  [self setNeedsDisplay:YES];

}
- (void)setFrameSize:(NSSize)newSize
{
  [super setFrameSize:newSize];
  [self setBounds:myBounds];
}

- (void)drawCp1 {
  NSBezierPath *cp1 = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(cp1X - CP_RADIUS, cp1Y - CP_RADIUS, CP_DIAMETER, CP_DIAMETER)];
  NSGradient *g1;
  if (draggingCp1) {
    g1 = [[NSGradient alloc] initWithStartingColor:CP_GRADIENT_HIGHLIGHT_COLOR1 endingColor:CP_GRADIENT_HIGHLIGHT_COLOR2];
  } else {
    g1 = [[NSGradient alloc] initWithStartingColor:CP_GRADIENT_COLOR1 endingColor:CP_GRADIENT_COLOR2];
  }
  [g1 drawInBezierPath:cp1 relativeCenterPosition:NSMakePoint(0.0, 0.0)];
}

- (void)drawCp2 {
  NSBezierPath *cp2 = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(cp2X - CP_RADIUS, cp2Y - CP_RADIUS, CP_DIAMETER, CP_DIAMETER)];
  NSGradient *g2;
  if (draggingCp2) {
    g2 = [[NSGradient alloc] initWithStartingColor:CP_GRADIENT_HIGHLIGHT_COLOR1 endingColor:CP_GRADIENT_HIGHLIGHT_COLOR2];
  } else {
    g2 = [[NSGradient alloc] initWithStartingColor:CP_GRADIENT_COLOR1 endingColor:CP_GRADIENT_COLOR2];
  }
  [g2 drawInBezierPath:cp2 relativeCenterPosition:NSMakePoint(0.0, 0.0)];
  
}
- (void)drawRect:(NSRect)rect {
  // Drawing code here.
  [NSGraphicsContext saveGraphicsState];
  
  // draw the background
  NSBezierPath *bg = [NSBezierPath bezierPathWithRoundedRect:myBounds xRadius:0.1 yRadius:0.1];
  [BACKGROUND_COLOR set];
  [bg fill];
  
  // draw the grid
  NSBezierPath *grid1 = [NSBezierPath bezierPath];
  [grid1 moveToPoint:NSMakePoint(0.0, 0.0)];
  [grid1 lineToPoint:NSMakePoint(1.0, 0.0)];
  [grid1 lineToPoint:NSMakePoint(1.0, 1.0)];
  [grid1 lineToPoint:NSMakePoint(0.0, 1.0)];
  [grid1 lineToPoint:NSMakePoint(0.0, 0.0)];
  
  [grid1 moveToPoint:NSMakePoint(0.5, 0.0)];
  [grid1 lineToPoint:NSMakePoint(0.5, 1.0)];
  [grid1 moveToPoint:NSMakePoint(0.0, 0.5)];
  [grid1 lineToPoint:NSMakePoint(1.0, 0.5)];
  [GRID_FILL_COLOR set];
  [grid1 fill];
  [GRID_STROKE_COLOR set];
  [grid1 setLineWidth:0.01];
  [grid1 stroke];
  
  // draw the lines leading to the control points
  NSBezierPath *cpLines = [NSBezierPath bezierPath];
  [cpLines moveToPoint:NSMakePoint(0.0, 0.0)];
  [cpLines lineToPoint:NSMakePoint(cp1X, cp1Y)];
  [cpLines moveToPoint:NSMakePoint(1.0, 1.0)];
  [cpLines lineToPoint:NSMakePoint(cp2X, cp2Y)];
  [LINE_TO_CP_COLOR set];
  [cpLines setLineWidth:0.01];
  [cpLines stroke];
  
  // draw the curve itself
  NSBezierPath *bp = [NSBezierPath bezierPath];
  [bp moveToPoint:NSMakePoint(0.0, 0.0)];
  [bp curveToPoint:NSMakePoint(1.0, 1.0) controlPoint1:NSMakePoint(cp1X, cp1Y) controlPoint2:NSMakePoint(cp2X, cp2Y)];
  [CURVE_COLOR set];
  [bp setLineWidth:0.01];
  [bp stroke];
  
  // draw the control points
  if (draggingCp1) {
    [self drawCp2];
    [self drawCp1]; 
  } else {
    [self drawCp1]; 
    [self drawCp2];
  }
  
  [NSGraphicsContext restoreGraphicsState];
}

- (void)mouseDown:(NSEvent *)theEvent
{
  // get current mouse location, convert to our coordinate space
  // (the one expresed by our bounds
  NSPoint mouseLocation = [[self window] mouseLocationOutsideOfEventStream];
  NSPoint convertedLocation = [self convertPoint:mouseLocation fromView:nil];
  // see if the click was on one of our control knobs
  NSPoint cp1 = NSMakePoint(cp1X, cp1Y);
  NSPoint cp2 = NSMakePoint(cp2X, cp2Y);
  if (pointsWithinDistance(cp1, convertedLocation, CP_RADIUS)) {
    draggingCp1 = YES;
  } else if (pointsWithinDistance(cp2, convertedLocation, CP_RADIUS)) {
    draggingCp2 = YES;
  }
  [self setNeedsDisplay:YES];
}
- (void)mouseDragged:(NSEvent *)theEvent
{
  NSPoint mouseLocation = [[self window] mouseLocationOutsideOfEventStream];
  NSPoint convertedLocation = [self convertPoint:mouseLocation fromView:nil];
  if (draggingCp1) {
    self.cp1X = convertedLocation.x;
    self.cp1Y = convertedLocation.y;
  } else if (draggingCp2) {
    self.cp2X = convertedLocation.x;
    self.cp2Y = convertedLocation.y;
  }
  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent
{
  draggingCp1 = NO;
  draggingCp2 = NO;
  [self setNeedsDisplay:YES];
}


@end
