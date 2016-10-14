//
//  SlowWorker_AppDelegate.m
//  SlowWorker
//
//  Created by JN on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SlowWorker_AppDelegate.h"

@implementation SlowWorker_AppDelegate

- (NSString *)fetchSomethingFromServer {
  sleep(1);
  return @"Hi there";
}

- (NSString *)processData:(NSString *)data {
  sleep(2);
  return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data {
  sleep(3);
  return [NSString stringWithFormat:@"Number of chars: %d",
    [data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data {
  sleep(4);
  return [data stringByReplacingOccurrencesOfString:@"E"
                                         withString:@"e"];
}

- (IBAction)doWork:(id)sender {
	NSDate *startTime = [NSDate date];
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *fetchedData = [self fetchSomethingFromServer];
		NSString *processedData = [self processData:fetchedData];
		__block NSString *firstResult;
    __block NSString *secondResult;
    dispatch_group_t group = dispatch_group_create();
		dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
			firstResult = [self calculateFirstResult:processedData];
		});
		dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
			secondResult = [self calculateSecondResult:processedData];
		});
		dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
			NSString *resultsSummary = [NSString stringWithFormat:
				@"First: [%@]\nSecond: [%@]", firstResult, secondResult];
			dispatch_async(dispatch_get_main_queue(), ^{
				[resultsTextView setString:resultsSummary];
				NSDate *endTime = [NSDate date];
				NSLog(@"Completed in %f seconds", 
							[endTime timeIntervalSinceDate:startTime]);
			});
		});
	});
}

@end
