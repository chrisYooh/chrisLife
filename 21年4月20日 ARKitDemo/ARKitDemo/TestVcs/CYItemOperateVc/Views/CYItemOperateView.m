//
//  CYItemOperateView.m
//  GmesTest
//
//  Created by Chris on 2021/04/11 11:41:08.
//  Copyright © 2019 Chris. All rights reserved.
//

#import "CYTools.h"

#import "CYItemOperateView.h"

@interface CYItemOperateView ()

@property (nonatomic, strong) SCNNode *curNode;

@end

@implementation CYItemOperateView

- (id)init {
    self = [super init];
    if (self) {
        [self configSelf];
        [self allocSubviews];
        [self configSubviews];
    }
    return self;
}

- (void)configSelf {
    
    SCNNode *node1 = [SCNNode cyNodeWithName:@"art.scnassets/ship.scn"];
    SCNNode *node2 = [SCNNode cyNodeWithName:@"chair_swan.usdz"];
    
    _testNodes = @[node1, node2];
    _curNode = node1;
}

- (void)allocSubviews {
    _sceneView = [ARSCNView cyDefaultView];
    _xOpView = [[CYItemOpSliderView alloc] init];
    _yOpView = [[CYItemOpSliderView alloc] init];
    _zOpView = [[CYItemOpSliderView alloc] init];
    _scaleOpView = [[CYItemOpSliderView alloc] init];
    _changeItemButton = [[UIButton alloc] init];
}

- (void)configSubviews {
    
    /* Scene View */
    [_sceneView cyAddSubnode:_curNode];
    
    /* X Op View */
    _xOpView.nameLabel.text = @"位置X";
    _xOpView.slider.tag = CYItemOperateViewSliderTypeX;
    [_xOpView.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    /* Y Op View */
    _yOpView.nameLabel.text = @"位置Y";
    _yOpView.slider.tag = CYItemOperateViewSliderTypeY;
    [_yOpView.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    /* Z Op View */
    _zOpView.nameLabel.text = @"位置Z";
    _zOpView.slider.tag = CYItemOperateViewSliderTypeZ;
    [_zOpView.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    /* Scale Op View */
    _scaleOpView.nameLabel.text = @"大小";
    _scaleOpView.slider.minimumValue = 0.001;
    _scaleOpView.slider.maximumValue = 0.1;
    _scaleOpView.slider.value = 0.05;
    _scaleOpView.slider.tag = CYItemOperateViewSliderTypeScale;
    [_scaleOpView.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    /* Change Item Button */
    [_changeItemButton setTitle:@"切换元素" forState:UIControlStateNormal];
    [_changeItemButton setTitleColor:[UIColor colorWithRGB:0x2196f3] forState:UIControlStateNormal];
    [_changeItemButton setTitleColor:[UIColor colorWithRGB:0x2196f3 alpha:0.5] forState:UIControlStateHighlighted];
    [_changeItemButton.titleLabel setFont:CYFont(20)];
    _changeItemButton.layer.borderWidth = 1;
    _changeItemButton.layer.borderColor = [UIColor colorWithRGB:0x2196f3].CGColor;
    _changeItemButton.layer.cornerRadius = 6;
    [_changeItemButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_sceneView];
    [self addSubview:_xOpView];
    [self addSubview:_yOpView];
    [self addSubview:_zOpView];
    [self addSubview:_scaleOpView];
    [self addSubview:_changeItemButton];
    
    [self subviewsAutolayoutSetting];
}

- (void)subviewsAutolayoutSetting {
    
    cyWeakSelf(mainView);
    
    /* Scene View */
    [_sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView).offset(20);
        make.left.right.equalTo(mainView);
    }];
    
    /* X Op View */
    [_xOpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.sceneView.mas_bottom).offset(20);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(48);
    }];
    
    /* Y Op View */
    [_yOpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.xOpView.mas_bottom).offset(4);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(48);
    }];

    /* Z Op View */
    [_zOpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.yOpView.mas_bottom).offset(4);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(48);
    }];

    /* Scale Op View */
    [_scaleOpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.zOpView.mas_bottom).offset(4);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(48);
    }];

    /* Change Item Button */
    [_changeItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.scaleOpView.mas_bottom).offset(4);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(48);
        make.bottom.equalTo(mainView).offset(-20);
    }];
}

#pragma mark - ...Delegate

#pragma mark - Target-Action Pair

- (void)sliderValueChanged:(UISlider *)slider {
    
    NSInteger sliderTag = slider.tag;
        
    if (CYItemOperateViewSliderTypeX == sliderTag) {
        SCNVector3 tmpPos = _curNode.position;
        tmpPos.x = slider.value;
        _curNode.position = tmpPos;
        
    } else if (CYItemOperateViewSliderTypeY == sliderTag) {
        SCNVector3 tmpPos = _curNode.position;
        tmpPos.y = slider.value;
        _curNode.position = tmpPos;
        
    } else if (CYItemOperateViewSliderTypeZ == sliderTag) {
        SCNVector3 tmpPos = _curNode.position;
        tmpPos.z = slider.value;
        _curNode.position = tmpPos;

    } else if (CYItemOperateViewSliderTypeScale == sliderTag) {
        SCNVector3 tmpScale = SCNVector3Make(slider.value, slider.value, slider.value);
        _curNode.scale = tmpScale;
    }
    
    if ([_delegate respondsToSelector:@selector(contentView:sliderViewUpdateValue:withTag:)]) {
        [_delegate contentView:self sliderViewUpdateValue:slider.value withTag:slider.tag];
    }
}

- (void)buttonClicked:(UIButton *)button {
    
    static int nodeIndex = 0;
    if (CYItemOperateViewOpTagChangeSceneItem == button.tag) {
        for (SCNNode *tmpNode in self.testNodes) {
            [tmpNode removeFromParentNode];
        }
        
        nodeIndex++;
        SCNNode *tmpNode = self.testNodes[nodeIndex % self.testNodes.count];
        [self.sceneView cyAddSubnode:tmpNode];
        _curNode = tmpNode;
    }
    
    if ([_delegate respondsToSelector:@selector(contentView:needHandleOpWithTag:)]) {
        [_delegate contentView:self needHandleOpWithTag:button.tag];
    }
}

#pragma mark - MISC

#pragma mark - User Interface

@end
