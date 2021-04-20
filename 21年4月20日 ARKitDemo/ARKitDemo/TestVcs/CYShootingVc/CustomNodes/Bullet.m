//
//  Bullet.m
//  射击类小游戏
//
//  Created by LJP on 7/12/17.
//  Copyright © 2017年 poco. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        SCNSphere * sphere = [SCNSphere sphereWithRadius:0.025];
        self.geometry = sphere;
        
        SCNPhysicsShape * shape = [SCNPhysicsShape shapeWithGeometry:sphere options:nil];
        self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:shape];
        [self.physicsBody setAffectedByGravity:NO];
        self.physicsBody.categoryBitMask = 2;
        self.physicsBody.contactTestBitMask = 1;
        
        SCNMaterial * material = [[SCNMaterial alloc]init];
        material.diffuse.contents = [UIImage imageNamed:@"bullet"];        
        self.geometry.materials = @[material];
        
    }
    return self;
}



@end
