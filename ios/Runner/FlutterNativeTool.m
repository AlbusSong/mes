//
//  FlutterNativeTool.m
//  Runner
//
//  Created by Albus on 2020-01-04.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "FlutterNativeTool.h"
#import <Flutter/Flutter.h>

#define WS(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;    //弱引用

static FlutterNativeTool *instance = nil;

@interface FlutterNativeTool ()

@property (nonatomic, strong) FlutterMethodChannel *platformChannel;

@end

@implementation FlutterNativeTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSomethings];
    }
    return self;
}

- (void)initSomethings {
    FlutterViewController *flutterVC = (FlutterViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    self.platformChannel = [FlutterMethodChannel methodChannelWithName:@"flutterNativeChannel" binaryMessenger:(NSObject<FlutterBinaryMessenger> * )flutterVC];
    
    NSLog(@"self.channel: %@", self.platformChannel);
    
    // Method
    WS(weakSelf);
    [self.platformChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"getBatteryLevel"]) {
            result(@"Hjdas");
//            result(@([weakSelf getBatteryLevel]));
//            int batteryLevel = [weakSelf getBatteryLevel];
//
//            if (batteryLevel == -1) {
//                result([FlutterError errorWithCode:@"UNAVAILABLE"
//                                           message:@"Battery info unavailable"
//                                           details:nil]);
//            } else {
//                result(@(batteryLevel));
//            }
        }
    }];
}

- (int)getBatteryLevel {
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    } else {
        return (int)(device.batteryLevel * 100);
    }
}

@end
