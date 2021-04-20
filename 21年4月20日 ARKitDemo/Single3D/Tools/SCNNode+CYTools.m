//
//  SCNNode+CYTools.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import "SCNNode+CYTools.h"

@implementation SCNNode (CYTools)

+ (SCNNode *)cyNodeWithName:(NSString *)sourceName {
    SCNScene *tmpScene = [SCNScene sceneNamed:sourceName];
    SCNNode *tmpNode = [[SCNNode alloc] init];
    for (SCNNode *child in tmpScene.rootNode.childNodes) {
        [tmpNode addChildNode:child];
    }
    return tmpNode;
}

- (void)cySetPosition:(SCNVector3)pos3d {
    self.position = pos3d;
}

- (void)cySetSizeScale:(SCNVector3)pos3d {
    self.scale = pos3d;
}

@end
