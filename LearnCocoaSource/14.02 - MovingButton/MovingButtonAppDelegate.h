//
//  MovingButtonAppDelegate.h
//  MovingButton
//
//  Created by JN on 10/18/09.
//  Copyright 2009 Rebisoft Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CurveView.h"

@interface MovingButtonAppDelegate : NSObject {
  IBOutlet CurveView *curveView;
}

- (IBAction)move:(id)sender;

@end
