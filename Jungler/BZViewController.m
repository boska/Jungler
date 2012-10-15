//
//  BZViewController.m
//  Jungler
//  Let'go TPA
//  Created by Boska on 12/10/15.
//  Copyright (c) 2012年 Boska. All rights reserved.
//

#import "BZViewController.h"

@interface BZViewController ()

@end

@implementation BZViewController
@synthesize display;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}
- (void)start:(id)sender
{
    NSLog(@"Start");
}
- (void)targetMethod:(NSTimer*)theTimer {
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
}

- (void)invocationMethod:(NSDate *)date {
    NSLog(@"Invocation for timer started on %@", date);
    display.text = [[NSDate date] description];
}
- (IBAction)startOneOffTimer:sender {
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:[self userInfo]
                                    repeats:NO];
}

- (IBAction)createUnregisteredTimer:sender {
    
    NSMethodSignature *methodSignature = [self methodSignatureForSelector:@selector(invocationMethod:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(invocationMethod:)];
    NSDate *startDate = [NSDate date];
    [invocation setArgument:&startDate atIndex:2];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 invocation:invocation repeats:YES];
    self.unregisteredTimer = timer;
}

- (IBAction)startUnregisteredTimer:sender {
    
    if (self.unregisteredTimer != nil) {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.unregisteredTimer forMode:NSDefaultRunLoopMode];
    }
}
- (IBAction)stopUnregisteredTimer:sender {
    [self.unregisteredTimer invalidate];
    self.unregisteredTimer = nil;
}
- (IBAction)startFireDateTimer:sender {
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                              interval:1
                                                target:self
                                              selector:@selector(countedTimerFireMethod:)
                                              userInfo:[self userInfo]
                                               repeats:YES];
    
    self.timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}
- (void)countedTimerFireMethod:(NSTimer*)theTimer {
    
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@; fire count %d", startDate, self.timerCount);
    
    self.timerCount++;
    if (self.timerCount > 3) {
        [theTimer invalidate];
    }
}
@end
