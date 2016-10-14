//
//  FlipItAppDelegate.m
//  FlipIt
//
//  Created by JN on 10/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "FlipItAppDelegate.h"

#define ANIM_DURATION 1.0

@implementation FlipItAppDelegate

- (void)prepareRightSide {
  NSInteger nextTabIndex = currentTabIndex+1;
  if (nextTabIndex >= [items count])
    nextTabIndex = 0;
  
  rightView = [[items objectAtIndex:nextTabIndex] view];
  
  NSRect viewFrame = [box bounds];
  viewFrame.origin.x += viewFrame.size.width;
  
  [rightView setFrame:viewFrame];
  [rightView setAlphaValue:0.0];
  [box addSubview:rightView];
}
- (void)transitionInFromRight {
  [[rightView animator] setFrame:[box bounds]];
  [[rightView animator] setAlphaValue:1.0];
}
- (void)transitionOutToLeft {
  NSRect newFrame = [middleView frame];
  newFrame.origin.x -= newFrame.size.width;
  [[middleView animator] setFrame:newFrame];
  [[middleView animator] setAlphaValue:0.0];
}

- (void)prepareLeftSide {
  NSInteger previousTabIndex = currentTabIndex-1;
  if (previousTabIndex < 0)
    previousTabIndex = [items count]-1;
  
  leftView = [[items objectAtIndex:previousTabIndex] view];
  
  NSRect viewFrame = [box bounds];
  viewFrame.origin.x -= viewFrame.size.width;

  [leftView setFrame:viewFrame];
  [leftView setAlphaValue:0.0];
  [box addSubview:leftView];
}
- (void)transitionInFromLeft {
  [[leftView animator] setFrame:[box bounds]];
  [[leftView animator] setAlphaValue:1.0];
}
- (void)transitionOutToRight {
  NSRect newFrame = [middleView frame];
  newFrame.origin.x += [box bounds].size.width;
  [[middleView animator] setFrame:newFrame];
  [[middleView animator] setAlphaValue:0.0];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  items = [tabView tabViewItems];
  currentTabIndex = [items count]-1;
  [self prepareRightSide];
  [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
  [self transitionInFromRight];
  currentTabIndex = 0;
  middleView = rightView;
}

- (IBAction)next:(id)sender {
  [self prepareRightSide];
  
  [NSAnimationContext beginGrouping];
  [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
  [self transitionInFromRight];
  [self transitionOutToLeft];
  [NSAnimationContext endGrouping];
  
  currentTabIndex++;
  if (currentTabIndex >= [items count])
    currentTabIndex = 0;
  leftView = middleView;
  middleView = rightView;
}
- (IBAction)previous:(id)sender {
  [self prepareLeftSide];
  
  [NSAnimationContext beginGrouping];
  [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
  [self transitionInFromLeft];
  [self transitionOutToRight];
  [NSAnimationContext endGrouping];
  
  currentTabIndex--;
  if (currentTabIndex < 0)
    currentTabIndex = [items count]-1;
  rightView = middleView;
  middleView = leftView;
}


@end
