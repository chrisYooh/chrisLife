//
//  CYItemOperateView.h
//  GmesTest
//
//  Created by Chris on 2021/04/11 11:41:08.
//  Copyright © 2019 Chris. All rights reserved.
//

#import <ARKit/ARKit.h>
#import <UIKit/UIKit.h>
#import "CYItemOpSliderView.h"

@class CYItemOperateView;

typedef NS_ENUM(NSInteger, CYItemOperateViewOpTag) {
    CYItemOperateViewOpTagUnknown = -1,
    CYItemOperateViewOpTagChangeSceneItem,     /* 改变AR展示项目 */
};

typedef NS_ENUM(NSInteger, CYItemOperateViewSliderType) {
    CYItemOperateViewSliderTypeUnknown = -1,
    CYItemOperateViewSliderTypeX,
    CYItemOperateViewSliderTypeY,
    CYItemOperateViewSliderTypeZ,
    CYItemOperateViewSliderTypeScale,
};

@protocol CYItemOperateViewDelegate <NSObject>

- (void)contentView:(CYItemOperateView *)view needHandleOpWithTag:(CYItemOperateViewOpTag)opTag;
- (void)contentView:(CYItemOperateView *)view sliderViewUpdateValue:(float)value withTag:(CYItemOperateViewSliderType)sliderTag;

@end

@interface CYItemOperateView : UIView

@property (nonatomic, weak) id<CYItemOperateViewDelegate> delegate;

@property (nonatomic, strong) NSArray<SCNNode *> *testNodes;

/* SubViews */
@property (nonatomic, strong) ARSCNView *sceneView;

@property (nonatomic, strong) CYItemOpSliderView *xOpView;
@property (nonatomic, strong) CYItemOpSliderView *yOpView;
@property (nonatomic, strong) CYItemOpSliderView *zOpView;
@property (nonatomic, strong) CYItemOpSliderView *scaleOpView;
@property (nonatomic, strong) UIButton *changeItemButton;

@end

