//
//  ListWindowDelegate.h
//  MenuLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ListWindowDelegate : NSObject {
  NSInteger selectedTag;
}

@property (assign) NSInteger selectedTag;

@end
