//
//  MyDocument.h
//  ColorMix
//
//  Created by JN on 9/4/09.
//  Copyright Rebisoft Inc 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSPersistentDocument {
  IBOutlet NSObjectController *objectController;
  BOOL isNew;
  IBOutlet ColorBlendView *multiplyBlendView;
  IBOutlet ColorBlendView *screenBlendView;
  IBOutlet ColorBlendView *overlayBlendView;
  IBOutlet ColorBlendView *darkenBlendView;
  IBOutlet ColorBlendView *lightenBlendView;
  IBOutlet ColorBlendView *colorDodgeBlendView;
  IBOutlet ColorBlendView *colorBurnBlendView;
  IBOutlet ColorBlendView *softLightBlendView;
  IBOutlet ColorBlendView *hardLightBlendView;
  IBOutlet ColorBlendView *differenceBlendView;
  IBOutlet ColorBlendView *exclusionBlendView;
  IBOutlet ColorBlendView *hueBlendView;
  IBOutlet ColorBlendView *saturationBlendView;
  IBOutlet ColorBlendView *colorBlendView;
  IBOutlet ColorBlendView *luminosityBlendView;
}

@end
