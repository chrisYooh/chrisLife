//
//  Ship.m
//  射击类小游戏
//
//  Created by LJP on 6/12/17.
//  Copyright © 2017年 poco. All rights reserved.
//

#import "Ship.h"

@implementation Ship

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        SCNBox * box = [SCNBox boxWithWidth:0.18 height:0.18 length:0.18 chamferRadius:0];
        self.geometry = box;
        SCNPhysicsShape * shape = [SCNPhysicsShape shapeWithGeometry:box options:nil];
        self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:shape];
        [self.physicsBody setAffectedByGravity:NO];
        
        self.physicsBody.categoryBitMask = 1;
        self.physicsBody.contactTestBitMask = 2;
                
        // add texture
        SCNMaterial * material = [[SCNMaterial alloc]init];
        material.diffuse.contents = [UIImage imageNamed:@"galaxy"];
        self.geometry.materials = @[material,material,material,material,material,material];
    }
    return self;
}


@end
