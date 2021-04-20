//
//  ARWorldTrackingConfiguration+CYTools.h
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import <ARKit/ARKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARWorldTrackingConfiguration (CYTools)

/**
 * 参考的默认配置：
 * 检测水平平面 / 检测垂直平面
 */
+ (ARWorldTrackingConfiguration *)cyDefaultConfiguration;


@end

NS_ASSUME_NONNULL_END
