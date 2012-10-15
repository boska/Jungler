//
//  BZViewController.h
//  Jungler
//
//  Created by Boska on 12/10/15.
//  Copyright (c) 2012年 Boska. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZViewController : UIViewController
{
}
@property (strong) NSTimer *unregisteredTimer;
@property NSUInteger timerCount;
@property   IBOutlet UITextField *display;
@property   IBOutlet UITextField *fireDateDisplay;

- (NSDictionary *)userInfo;
- (IBAction)start:(id)sender;
- (IBAction)startOneOffTimer:sender;

- (IBAction)startRepeatingTimer:sender;
- (IBAction)stopRepeatingTimer:sender;

- (IBAction)createUnregisteredTimer:sender;
- (IBAction)startUnregisteredTimer:sender;
- (IBAction)stopUnregisteredTimer:sender;

- (IBAction)startFireDateTimer:sender;

- (void)targetMethod:(NSTimer*)theTimer;
- (void)invocationMethod:(NSDate *)date;
- (void)countedTimerFireMethod:(NSTimer*)theTimer;
@end
