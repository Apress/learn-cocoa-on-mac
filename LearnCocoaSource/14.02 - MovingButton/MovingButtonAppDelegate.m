//
//  MovingButtonAppDelegate.m
//  MovingButton
//
//  Created by JN on 10/18/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "MovingButtonAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation MovingButtonAppDelegate

- (IBAction)move:(id)sender
{
  NSRect senderFrame = [sender frame];
  NSRect superBounds = [[sender superview] bounds];
  CABasicAnimation *a = [CABasicAnimation  
                         animationWithKeyPath:@"position"];
  a.fromValue = [NSValue valueWithPoint:senderFrame.origin];
  senderFrame.origin.x = (superBounds.size.width -
    senderFrame.size.width)*drand48();
  senderFrame.origin.y = (superBounds.size.height -
    senderFrame.size.height)*drand48();
  a.toValue = [NSValue valueWithPoint:senderFrame.origin];
/*  CAMediaTimingFunction *t1 = [CAMediaTimingFunction 
                               functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  float t1p0[2];
  float t1p1[2];
  float t1p2[2];
  float t1p3[2];
  [t1 getControlPointAtIndex:0 values:t1p0];
  [t1 getControlPointAtIndex:1 values:t1p1];
  [t1 getControlPointAtIndex:2 values:t1p2];
  [t1 getControlPointAtIndex:3 values:t1p3];
  CAMediaTimingFunction *t2 = [CAMediaTimingFunction 
                               functionWithControlPoints:curveView.cp1X :curveView.cp1Y :curveView.cp2X :curveView.cp2Y];
  float t2p0[2];
  float t2p1[2];
  float t2p2[2];
  float t2p3[2];
  [t2 getControlPointAtIndex:0 values:t2p0];
  [t2 getControlPointAtIndex:1 values:t2p1];
  [t2 getControlPointAtIndex:2 values:t2p2];
  [t2 getControlPointAtIndex:3 values:t2p3];*/

  a.duration      = 1.0;
  a.timingFunction = [CAMediaTimingFunction 
                       functionWithControlPoints:curveView.cp1X 
                       :curveView.cp1Y 
                       :curveView.cp2X 
                       :curveView.cp2Y];
  //a.timingFunction = [CAMediaTimingFunction
  //                            functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  //a.fillMode  = kCAFillModeForwards;
  //a.delegate      = self;
  
  // Add animation to layer; also triggers the animation
  [[sender layer] addAnimation:a forKey:@"position"];
  [sender setFrame:senderFrame];
}

@end
