//
//  BarcodeScanVC.h
//  Runner
//
//  Created by Albus on 4/3/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarcodeScanVC : UIViewController

@property (nonatomic, copy) void (^barcodeScsanedHandler) (NSString *barcode);

@end

NS_ASSUME_NONNULL_END
