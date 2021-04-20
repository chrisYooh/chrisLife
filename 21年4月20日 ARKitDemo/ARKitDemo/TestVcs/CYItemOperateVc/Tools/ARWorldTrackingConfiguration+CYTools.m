//
//  ARWorldTrackingConfiguration+CYTools.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import "ARWorldTrackingConfiguration+CYTools.h"

@implementation ARWorldTrackingConfiguration (CYTools)

+ (ARWorldTrackingConfiguration *)cyDefaultConfiguration {
    ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
    configuration.planeDetection = ARPlaneDetectionHorizontal | ARPlaneDetectionVertical;
    return configuration;
}

@end
