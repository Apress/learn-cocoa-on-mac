//
//  WhatAboutThatFileAppDelegate.m
//  WhatAboutThatFile
//
//  Created by JN on 10/31/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import "WhatAboutThatFileAppDelegate.h"

@implementation WhatAboutThatFileAppDelegate

@synthesize fileWrapper, filePath, chosenEncoding;

- (void)applicationDidFinishLaunching:(NSNotification *)n {
  fileWrapper = nil;
  filePath = nil;
}

- (IBAction)chooseFile:(id)sender {
  NSOpenPanel *openPanel = [NSOpenPanel openPanel];
  [openPanel setCanChooseFiles:YES];
  [openPanel setCanChooseDirectories:NO];
  [openPanel setResolvesAliases:NO];
  [openPanel setAllowsMultipleSelection:NO];
  if ([openPanel runModal]==NSFileHandlingPanelOKButton) {
    self.chosenEncoding = 0;
    self.filePath = [[openPanel filenames] lastObject];
    self.fileWrapper = [[[NSFileWrapper alloc] initWithPath:filePath] autorelease];
  }
}

+ (NSSet *)keyPathsForValuesAffectingFilename {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", nil];
}
- (NSString *)filename {
  return [fileWrapper filename];
}

+ (NSSet *)keyPathsForValuesAffectingFileIcon {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", nil];
}
- (NSImage *)fileIcon {
  return [fileWrapper icon];
}

+ (NSSet *)keyPathsForValuesAffectingOpensAppIcon {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", nil];
}
- (NSImage *)opensAppIcon {
  NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
  NSString *appName = nil;
  [workspace getInfoForFile:self.filePath application:&appName type:NULL];
  return appName ? [workspace iconForFile:appName] : nil;
}

+ (NSSet *)keyPathsForValuesAffectingOpensAppName {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", nil];
}
- (NSString *)opensAppName {
  NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
  NSString *appName = nil;
  [workspace getInfoForFile:self.filePath application:&appName type:NULL];
  return appName;
}

+ (NSSet *)keyPathsForValuesAffectingFileAttributes {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", nil];
}
- (NSDictionary *)fileAttributes {
  return [fileWrapper fileAttributes];
}

- (NSDictionary *)encodingNames {
  static NSDictionary *encodingNames = nil;
  if (!encodingNames) {
    encodingNames = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"NSASCIIStringEncoding", @"1",
                     @"NSNEXTSTEPStringEncoding", @"2",
                     @"NSJapaneseEUCStringEncoding", @"3",
                     @"NSUTF8StringEncoding", @"4",
                     @"NSISOLatin1StringEncoding", @"5",
                     @"NSSymbolStringEncoding", @"6",
                     @"NSNonLossyASCIIStringEncoding", @"7",
                     @"NSShiftJISStringEncoding", @"8",
                     @"NSISOLatin2StringEncoding", @"9",
                     @"NSUnicodeStringEncoding", @"10",
                     @"NSWindowsCP1251StringEncoding", @"11",
                     @"NSWindowsCP1252StringEncoding", @"12",
                     @"NSWindowsCP1253StringEncoding", @"13",
                     @"NSWindowsCP1254StringEncoding", @"14",
                     @"NSWindowsCP1250StringEncoding", @"15",
                     @"NSISO2022JPStringEncoding", @"21",
                     @"NSMacOSRomanStringEncoding", @"30",
                     @"NSUTF16BigEndianStringEncoding", @"2415919360",
                     @"NSUTF16LittleEndianStringEncoding", @"2483028224",
                     @"NSUTF32StringEncoding", @"2348810496",
                     @"NSUTF32BigEndianStringEncoding", @"2550137088",
                     @"NSUTF32LittleEndianStringEncoding", @"2617245952",
                     nil];
  }
  return encodingNames;
}

+ (NSSet *)keyPathsForValuesAffectingStringEncodingName {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", @"chosenEncoding", nil];
}
- (NSString *)stringEncodingName {
  if (!filePath) return nil;
  if (self.chosenEncoding != 0) {
    return [[self encodingNames] objectForKey:
            [NSString stringWithFormat:@"%u", self.chosenEncoding]];
  } else {
    NSStringEncoding encoding = 0;
    NSError *err = nil;
    [NSString stringWithContentsOfFile:filePath usedEncoding:&encoding error:&err];
    if (encoding==0) {
      return @"No encoding detected.  Perhaps a binary file?";
    }
    return [[self encodingNames] objectForKey:
            [NSString stringWithFormat:@"%u", encoding]];
  }
}
- (void)setStringEncodingName:(NSString *)name {
  NSString *key = [[[self encodingNames] allKeysForObject:name] lastObject];
  self.chosenEncoding = [key longLongValue];
  
}

+ (NSSet *)keyPathsForValuesAffectingFileStringValue {
  return [NSSet setWithObjects:@"filePath", @"fileWrapper", @"chosenEncoding", nil];
}
- (NSString *)fileStringValue {
  if (!filePath) return nil;
  NSError *err = nil;
  NSString *value = nil;
  if (self.chosenEncoding != 0) {
    value = [NSString stringWithContentsOfFile:filePath encoding:self.chosenEncoding error:&err];
  } else {
    NSStringEncoding encoding = 0;
    value = [NSString stringWithContentsOfFile:filePath usedEncoding:&encoding error:&err];
  }
  if (err)  {
   if ([err code]==NSFileReadInapplicableStringEncodingError &&
       [[err domain] isEqual:NSCocoaErrorDomain]) {
     NSRunAlertPanel(@"Invalid string encoding", [err localizedDescription], nil, nil, nil);
   }
   NSLog(@"encountered error: %@", err);
  }
  return value;
}

@end