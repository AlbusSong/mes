//
//  FlutterNativeTool.m
//  Runner
//
//  Created by Albus on 2020-01-04.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "FlutterNativeTool.h"
#import <Flutter/Flutter.h>
#import "BarcodeScanVC.h"
#import "Macro.h"

static FlutterNativeTool *instance = nil;

@interface FlutterNativeTool ()

@property (nonatomic, strong) FlutterViewController *flutterVC;

@property (nonatomic, strong) FlutterMethodChannel *platformChannel;

@property (nonatomic, strong) FlutterResult fResult;

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
    self.flutterVC = (FlutterViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    self.platformChannel = [FlutterMethodChannel methodChannelWithName:@"flutterNativeChannel" binaryMessenger:(NSObject<FlutterBinaryMessenger> * )self.flutterVC];
    
    NSLog(@"self.channel: %@", self.platformChannel);
    
    // Method
    WS(weakSelf);
    [self.platformChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        weakSelf.fResult = result;
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
        } else if ([call.method isEqualToString:@"tryToScanBarcode"]) {
            [weakSelf tryToScanBarcode];
        }
    }];
}

- (void)tryToScanBarcode {
    BarcodeScanVC *vc = [[BarcodeScanVC alloc] init];
    WS(weakSelf)
    vc.barcodeScsanedHandler = ^(NSString * _Nonnull barcode) {
        weakSelf.fResult(barcode);
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.flutterVC presentViewController:nav animated:YES completion:nil];
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
