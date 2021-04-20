//
//  ViewController.m
//  Single3D
//
//  Created by Chris Yang on 2021/4/8.
//

#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

#import "SCNNode+CYTools.h"
#import "ARSCNView+CYTools.h"
#import "ARWorldTrackingConfiguration+CYTools.h"

#import "ViewController.h"

@interface ViewController ()
<ARSCNViewDelegate>

@property (nonatomic, strong) ARSCNView *sceneView;
@property (nonatomic, strong) ARWorldTrackingConfiguration *configuraion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCNNode *tmpNode = [SCNNode cyNodeWithName:@"art.scnassets/ship.scn"];
    [self.view addSubview:self.sceneView];
    
    [self.sceneView cyAddSubnode:tmpNode];
    
    self.sceneView.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.sceneView.session runWithConfiguration:[ARWorldTrackingConfiguration cyDefaultConfiguration]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];    
    [self.sceneView.session pause];
}

#pragma mark - ARSCNViewDelegate

//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//    return nil;
//}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

#pragma mark - Getter

- (ARSCNView *)sceneView {
    
    if (nil == _sceneView) {
        _sceneView = [ARSCNView cyDefaultView];
    }
    
    return _sceneView;
}


@end
