//
//  BlackView.m
//  ColorMix
//
//  Created by JN on 9/4/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "BlackView.h"


@implementation BlackView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
  [[NSColor blackColor] set];
  NSRectFill(rect);
}

@end
