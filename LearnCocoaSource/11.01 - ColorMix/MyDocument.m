//
//  MyDocument.m
//  ColorMix
//
//  Created by JN on 9/4/09.
//  Copyright Rebisoft Inc 2009 . All rights reserved.
//

#import "ColorBlendView.h"
#import "MyDocument.h"

@implementation MyDocument

- (id)init 
{
  self = [super init];
  if (self != nil) {
    isNew = NO;
  }
  return self;
}

- (id)initWithType:(NSString *)typeName error:(NSError **)outError
{
  if (self = [super initWithType:typeName error:outError]) {
    isNew = YES;
  }
  return self;
}


- (NSString *)windowNibName 
{
  return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
  [super windowControllerDidLoadNib:windowController];
  if (isNew) {
    id newObj = [objectController newObject];
    [newObj setValue:[NSColor redColor] forKey:@"color1"];
    [newObj setValue:[NSColor yellowColor] forKey:@"color2"];
    [objectController addObject:newObj];
  }
  
  // user interface preparation code
  [multiplyBlendView setBlendMode:kCGBlendModeMultiply];
  [screenBlendView setBlendMode:kCGBlendModeScreen];
  [overlayBlendView setBlendMode:kCGBlendModeOverlay];
  [darkenBlendView setBlendMode:kCGBlendModeDarken];
  [lightenBlendView setBlendMode:kCGBlendModeLighten];
  [colorDodgeBlendView setBlendMode:kCGBlendModeColorDodge];
  [colorBurnBlendView setBlendMode:kCGBlendModeColorBurn];
  [softLightBlendView setBlendMode:kCGBlendModeSoftLight];
  [hardLightBlendView setBlendMode:kCGBlendModeHardLight];
  [differenceBlendView setBlendMode:kCGBlendModeDifference];
  [exclusionBlendView setBlendMode:kCGBlendModeExclusion];
  [hueBlendView setBlendMode:kCGBlendModeHue];
  [saturationBlendView setBlendMode:kCGBlendModeSaturation];
  [colorBlendView setBlendMode:kCGBlendModeColor];
  [luminosityBlendView setBlendMode:kCGBlendModeLuminosity];
  for (ColorBlendView *cbv in [NSArray arrayWithObjects:multiplyBlendView, screenBlendView, overlayBlendView, darkenBlendView, lightenBlendView, colorDodgeBlendView, colorBurnBlendView, softLightBlendView, hardLightBlendView, differenceBlendView, exclusionBlendView, hueBlendView, saturationBlendView, colorBlendView, luminosityBlendView, nil]) {
    [cbv bind:@"color1" toObject:objectController withKeyPath:@"selection.color1" options:nil];
    [cbv bind:@"color2" toObject:objectController withKeyPath:@"selection.color2" options:nil];
  }
}

@end
