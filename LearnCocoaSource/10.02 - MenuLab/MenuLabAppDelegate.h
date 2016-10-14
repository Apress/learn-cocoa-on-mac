//
//  MenuLabAppDelegate.h
//  MenuLab
//
//  Created by JN on 8/21/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MenuLabAppDelegate : NSObject {
  BOOL turbo;
}

@property (assign) BOOL turbo;

- (IBAction)toggleTurbo:(id)sender;

@end
