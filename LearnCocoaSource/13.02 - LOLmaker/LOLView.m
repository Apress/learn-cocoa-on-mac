//
//  LOLView.m
//  LOLmaker
//
//  Created by JN on 10/1/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "LOLView.h"


@implementation LOLView

@synthesize image;
@synthesize text;

- (void)setText:(NSString *)t {
  if (![t isEqual:text]) {
    [text release];
    text = [t retain];
    [self setNeedsDisplay:YES];
  }
}

- (void)setImage:(NSImage *)i {
  if (![i isEqual:image]) {
    [image release];
    image = [i retain];
    if (image) {
      NSRect newImageFrame = NSMakeRect(0, 0, [image size].width, [image size].height);
      [self setFrame:newImageFrame];
    }
    [self setNeedsDisplay:YES];
  }
}

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code here.
  }
  return self;
}

- (void)drawRect:(NSRect)rect {
  // Drawing code here.
  NSLog(@"LOLView <0x%x> drawing image <0x%x> and text <0x%x> in frame %@, bounds %@", self, self.image, self.text, NSStringFromRect([self frame]), NSStringFromRect([self bounds]));
  NSRect srcImageRect = NSMakeRect(0, 0, [self.image size].width, [self.image size].height);
  [self.image drawAtPoint:[self bounds].origin fromRect:srcImageRect operation:NSCompositeCopy fraction:1.0];
  
  NSPoint textLocation = NSMakePoint(0,0);
  NSShadow *textShadow = [[NSShadow alloc] init];
  [textShadow setShadowOffset:NSMakeSize(0,0)];
  [textShadow setShadowColor:[NSColor blackColor]];
  [textShadow setShadowBlurRadius:10];
  NSMutableDictionary *textAttributes =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
      [NSFont fontWithName:@"Impact" size:40], NSFontAttributeName, 
      [NSColor whiteColor], NSForegroundColorAttributeName,
      textShadow, NSShadowAttributeName,
      nil];
  if (text!=nil && [text length]>0) {      
    // find the optimal size
    CGFloat testFontSize;
    NSSize testSize = NSMakeSize(0, 0);
    for(testFontSize=1; testSize.width < [image size].width; testFontSize*=2) {
      [textAttributes setObject:[NSFont fontWithName:@"Impact" size:testFontSize]
                         forKey:NSFontAttributeName];
      testSize = [self.text sizeWithAttributes:textAttributes];
    }
    [textAttributes setObject:[NSFont fontWithName:@"Impact" size:testFontSize/4]
                       forKey:NSFontAttributeName];
    [self.text drawAtPoint:textLocation withAttributes:textAttributes];
  }
}

@end
