//
//  WhatAboutThatFileAppDelegate.h
//  WhatAboutThatFile
//
//  Created by JN on 10/31/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WhatAboutThatFileAppDelegate : NSObject {
  NSFileWrapper *fileWrapper;
  NSString *filePath;
  NSStringEncoding chosenEncoding;
}

@property (retain) NSFileWrapper *fileWrapper;
@property (retain) NSString *filePath;
@property (readonly) NSDictionary *fileAttributes;
@property (readonly) NSString *filename;
@property (readonly) NSImage *fileIcon;
@property (readonly) NSImage *opensAppIcon;
@property (readonly) NSString *opensAppName;
@property (assign) NSString *stringEncodingName;
@property (readonly) NSString *fileStringValue;
@property (readonly) NSDictionary *encodingNames;
@property (assign) NSStringEncoding chosenEncoding;

- (IBAction)chooseFile:(id)sender;

@end
