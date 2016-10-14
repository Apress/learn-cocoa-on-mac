//
//  LOLmakerAppDelegate.h
//  LOLmaker
//
//  Created by JN on 9/30/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class LOLView;

@interface LOLmakerAppDelegate : NSObject
{
  IBOutlet LOLView *lolView;
  NSImage *image;
  NSString *text;
}

@property (retain) NSImage *image;
@property (copy) NSString *text;

@end
