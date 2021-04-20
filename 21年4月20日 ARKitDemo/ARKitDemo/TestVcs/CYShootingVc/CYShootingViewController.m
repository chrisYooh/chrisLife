//
//  CYShootingViewController.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import "Ship.h"
#import "Bullet.h"

#import "CYShootingViewController.h"

@interface CYShootingViewController ()
<ARSCNViewDelegate,
SCNPhysicsContactDelegate>

@property (nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) ARSCNView * sceneView;
@property(nonatomic, strong) ARWorldTrackingConfiguration *worldConfig;

@end

@implementation CYShootingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sceneView];
    [self.view addSubview:self.countLabel];
    
    self.sceneView.frame = [UIScreen mainScreen].bounds;
    self.countLabel.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 90, 100, 60);
    
    [self addNewShip];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.sceneView.session runWithConfiguration:self.worldConfig];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sceneView.session pause];
}

#pragma mark - ARSCNViewDelegate

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
}

- (void)sessionWasInterrupted:(ARSession *)session {
}

- (void)sessionInterruptionEnded:(ARSession *)session {
}

#pragma mark - SCNPhysicsContactDelegate

- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact {
    
    if (contact.nodeA.physicsBody.categoryBitMask == 2
        || contact.nodeB.physicsBody.categoryBitMask == 2) {
        
        [contact.nodeB removeFromParentNode];
        
        dispatch_sync(dispatch_get_main_queue(), ^(){
            self.countLabel.text = [NSString stringWithFormat:@"%ld", ([self.countLabel.text integerValue] + 1)];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [contact.nodeA removeFromParentNode];
            [self addNewShip];
        });
    }
}

- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(SCNPhysicsContact *)contact {
    
}

- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(SCNPhysicsContact *)contact {
    
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self shootBullet];
}

#pragma mark - AR Items Op

- (void)addNewShip {
    Ship *cubeNode = [[Ship alloc] init];
    float x = [self randFloat];
    float y = [self randFloat];
    cubeNode.position = SCNVector3Make(x, y, -1);
    
    [self.sceneView.scene.rootNode addChildNode:cubeNode];
}

- (void)shootBullet {
    
    Bullet * bulletsNode = [[Bullet alloc] init];
    bulletsNode.position = [self defaultPos];
    
    SCNVector3 shootDir = [self defaultShootDir];
    [bulletsNode.physicsBody applyForce:shootDir impulse:YES];
    [self.sceneView.scene.rootNode addChildNode:bulletsNode];
}

- (CGFloat )randFloat {
    return (float)(1+arc4random() % 99) / 100 - 0.5;
}

- (SCNVector3)defaultShootDir {
    SCNMatrix4 mat = SCNMatrix4FromMat4(self.sceneView.session.currentFrame.camera.transform);
    SCNVector3 tmpDir = SCNVector3Make(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33);
    return tmpDir;
}

- (SCNVector3)defaultPos {
    SCNMatrix4 mat = SCNMatrix4FromMat4(self.sceneView.session.currentFrame.camera.transform);
    SCNVector3 tmpPos = SCNVector3Make(mat.m41, mat.m42, mat.m43);
    return tmpPos;
}

#pragma mark - Getter

- (UILabel *)countLabel {
    if (nil == _countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"0";
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _countLabel;
}

- (ARSCNView *)sceneView {
    
    if (nil == _sceneView) {
        _sceneView = [[ARSCNView alloc] init];
        _sceneView.delegate = self;
        _sceneView.showsStatistics = YES;
        SCNScene * scene= [[SCNScene alloc]init];
        _sceneView.scene = scene;
        _sceneView.scene.physicsWorld.contactDelegate = self;
    }
    
    return _sceneView;
}

- (ARWorldTrackingConfiguration *)worldConfig {
    
    if (_worldConfig == nil) {
        _worldConfig = [[ARWorldTrackingConfiguration alloc]init];
        _worldConfig.planeDetection = ARPlaneDetectionHorizontal;
    }
    
    return _worldConfig;
}

@end
