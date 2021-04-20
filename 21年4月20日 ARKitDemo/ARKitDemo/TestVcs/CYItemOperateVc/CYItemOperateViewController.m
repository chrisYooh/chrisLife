//
//  CYItemOperateViewController.m
//  GmesTest
//
//  Created by Chris on 2021/04/11 11:41:08.
//  Copyright © 2019 Chris. All rights reserved.
//

#import "CYTools.h"
#import "CYItemOperateView.h"
#import "CYItemOperatePresenter.h"

#import "CYItemOperateViewController.h"

@interface CYItemOperateViewController ()
<CYItemOperateViewDelegate,
CYItemOperateViewInterface>

@property (nonatomic, strong) CYItemOperateView *contentView;
@property (nonatomic, strong) CYItemOperatePresenter *presenter;

@end

@implementation CYItemOperateViewController

- (id)init {
    self = [super init];
    if (self) {
        _presenter = [[CYItemOperatePresenter alloc] init];
        _presenter.viewInterface = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSelf];
    [self configSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.contentView.sceneView.session runWithConfiguration:[ARWorldTrackingConfiguration cyDefaultConfiguration]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.contentView.sceneView.session pause];
}

- (void)configSelf {
    self.view.backgroundColor = [UIColor colorWithRGB:0xffffff];
}

- (void)configSubviews {
    
    _contentView = [[CYItemOperateView alloc] init];
    [_contentView setDelegate:self];
    [self.view addSubview:_contentView];
    
    cyWeakSelf(mainVc);
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainVc.view);
    }];
}

#pragma mark - CYItemOperateViewDelegate

- (void)contentView:(CYItemOperateView *)view needHandleOpWithTag:(CYItemOperateViewOpTag)opTag {
    NSLog(@"Op Tag: %d", (int)opTag);
}

- (void)contentView:(CYItemOperateView *)view sliderViewUpdateValue:(float)value withTag:(CYItemOperateViewSliderType)sliderTag {
    
    if (CYItemOperateViewSliderTypeX == sliderTag) {
        
    } else if (CYItemOperateViewSliderTypeY == sliderTag) {
        
    } else if (CYItemOperateViewSliderTypeZ == sliderTag) {
        
    } else if (CYItemOperateViewSliderTypeScale == sliderTag) {
        
    }
}

#pragma mark - CYItemOperateViewInterface

@end
