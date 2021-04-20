//
//  SCNNode+CYTools.h
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import <SceneKit/SceneKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 此处的封装可能仅仅是函数的简单调用
 * 旨在枚举出我们关心的一些关键操作，以及借此说明一些关键信息
 */

@interface SCNNode (CYTools)

/**
 * 通过资源名获取资源Node
 * * SceneKit提供的基本功能是获取SCNScene
 */
+ (SCNNode *)cyNodeWithName:(NSString *)sourceName;

/**
 * 设置一个Node的位置，SCNVector3 可通过 SCNVector3Make 构造 x,y,z
 * x方向：左右方向，右为正
 * y方向：上下方向，上为正
 * z方向：远近方向，近为正
 */
- (void)cySetPosition:(SCNVector3)pos3d;

/**
 * 设置一个Node的大小比例，SCNVector3 可通过 SCNVector3Make 构造 x,y,z
 * 这边设置整体的scale
 * x方向：左右方向
 * y方向：上下方向
 * z方向：远近方向
 */
- (void)cySetSizeScale:(float)scale;

@end

NS_ASSUME_NONNULL_END
