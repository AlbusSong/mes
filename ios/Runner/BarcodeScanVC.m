//
//  BarcodeScanVC.m
//  Runner
//
//  Created by Albus on 4/3/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "BarcodeScanVC.h"
#import "QiCodePreviewView.h"
#import "QiCodeManager.h"
#import "Macro.h"

@interface BarcodeScanVC ()

@property (nonatomic, strong) QiCodePreviewView *previewView;
@property (nonatomic, strong) QiCodeManager *codeManager;

@end

@implementation BarcodeScanVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"扫描二维码";
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    }
    return self;;
}

- (void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _previewView = [[QiCodePreviewView alloc] initWithFrame:self.view.bounds];
    _previewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_previewView];
    
    WS(weakSelf)
    _codeManager = [[QiCodeManager alloc] initWithPreviewView:_previewView completion:^{
        [weakSelf startScanning];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_codeManager stopScanning];
}

- (void)startScanning {
    WS(weakSelf)
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
        [weakSelf onGetBarcode:code];
    } autoStop:YES];
}

- (void)onGetBarcode:(NSString *)barcode {
    NSLog(@"onGetBarcode: %@", barcode);
    
    if (self.barcodeScsanedHandler) {
        self.barcodeScsanedHandler(barcode);
    }
    
    [self close];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark status bar

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
