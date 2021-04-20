//
//  CYItemOpSliderView.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import "CYItemOpSliderView.h"

@implementation CYItemOpSliderView

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
    
}

- (void)allocSubviews {
    _nameLabel = [[UILabel alloc] init];
    _slider = [[UISlider alloc] init];
}

- (void)configSubviews {
    
    /* Name Label */
    [_nameLabel setText:@""];
    [_nameLabel setTextColor:[UIColor colorWithRGB:0x333333]];
    [_nameLabel setFont:CYFont(14)];
    [_nameLabel setTextAlignment:NSTextAlignmentRight];
    
    /* Slider */
    [_slider setMaximumValue:1];
    [_slider setMinimumValue:-1];
    [_slider setValue:0];
    
    [self addSubview:_nameLabel];
    [self addSubview:_slider];
    
    [self subviewsAutolayoutSetting];
}

- (void)subviewsAutolayoutSetting {
    
    cyWeakSelf(mainView);
    /* Name Label */
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(mainView);
        make.left.equalTo(mainView);
        make.width.mas_equalTo(80);
    }];
    
    /* Slider */
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.nameLabel.mas_right);
        make.top.bottom.equalTo(mainView);
        make.right.equalTo(mainView);
    }];
}

#pragma mark - Target-Action Pair

- (void)buttonClicked:(UIButton *)button {
    
}

#pragma mark - MISC

#pragma mark - User Interface

@end
