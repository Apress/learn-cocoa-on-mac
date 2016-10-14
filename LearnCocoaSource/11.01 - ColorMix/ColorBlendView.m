//
//  ColorView.m
//  ColorMix
//
//  Created by JN on 9/4/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "ColorBlendView.h"

CGColorRef CGColorCreateGenericRGBWithNSColor (NSColor *color)
{
  CGColorRef cgColor = NULL;
  
  NSColorSpace *nsColorSpace = [NSColorSpace genericRGBColorSpace];
  NSColor *deviceRGBColor = [color colorUsingColorSpace: nsColorSpace];
  if (nil != deviceRGBColor)
  {
    CGFloat components[4];
    [deviceRGBColor getRed: &components[0] green: &components[1]
                      blue: &components[2] alpha: &components[3]];
    
    cgColor = CGColorCreate ([nsColorSpace CGColorSpace], components);
  }
  
  return cgColor;
}

@implementation ColorBlendView

@synthesize color1;
@synthesize color2;
@synthesize blendMode;

- (void)setBlendMode:(CGBlendMode)bm {
  if (blendMode != bm) {
    blendMode = bm;
    [self setNeedsDisplay:YES];
  }
}
- (void)setColor1:(NSColor *)c {
  if (![c isEqual:color1]) {
    [color1 release];
    color1 = [c retain];
    [self setNeedsDisplay:YES];
  }
}
- (void)setColor2:(NSColor *)c {
  if (![c isEqual:color2]) {
    [color2 release];
    color2 = [c retain];
    [self setNeedsDisplay:YES];
  }
}

- (void)drawRect:(NSRect)rect {
  // don't draw anything if we don't have two valid colors.
  if (!self.color1 || !self.color2) return;
  
  CGColorRef cgColor1 = CGColorCreateGenericRGBWithNSColor(self.color1);
  CGColorRef cgColor2 = CGColorCreateGenericRGBWithNSColor(self.color2);
  
  CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
  CGContextSaveGState(myContext);
  
  CGContextSetFillColorWithColor(myContext, cgColor1);
  CGContextSetBlendMode(myContext, kCGBlendModeNormal);
  CGContextFillRect(myContext, NSRectToCGRect(rect));
  
  CGContextSetFillColorWithColor(myContext, cgColor2);
  CGContextSetBlendMode(myContext, self.blendMode);
  CGContextFillRect(myContext, NSRectToCGRect(rect));
  
  CGContextRestoreGState(myContext);

  CGColorRelease(cgColor1);
  CGColorRelease(cgColor2);
}

@end
