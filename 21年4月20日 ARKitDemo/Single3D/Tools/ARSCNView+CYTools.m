//
//  ARSCNView+CYTools.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import <SceneKit/SceneKit.h>

#import "ARSCNView+CYTools.h"

@implementation ARSCNView (CYTools)

+ (ARSCNView *)cyDefaultView {
    ARSCNView *tmpView = [[ARSCNView alloc] init];
    tmpView.scene = [[SCNScene alloc] init];
    tmpView.showsStatistics = YES;
    tmpView.debugOptions = ARSCNDebugOptionShowWorldOrigin | ARSCNDebugOptionShowFeaturePoints;
    return tmpView;
}

- (void)cyAddSubnode:(SCNNode *)subnode {
    [self.scene.rootNode addChildNode:subnode];
}

@end
