//
//  ARSCNView+CYTools.h
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import <ARKit/ARKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARSCNView (CYTools)

/**
 * 参考的默认ARScene视图：
 * 1、显示分析
 * 2、显示坐标轴，显示特征点
 */
+ (ARSCNView *)cyDefaultView;

/**
 * 将一个Node添加到ARView中
 * Node方便进行位置、大小操作；而一个arView只有一个Scene，所以要将Scene转为Node添加。
 */
- (void)cyAddSubnode:(SCNNode *)subnode;

@end

NS_ASSUME_NONNULL_END
