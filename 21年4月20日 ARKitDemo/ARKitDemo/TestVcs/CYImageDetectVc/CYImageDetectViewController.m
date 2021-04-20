//
//  CYImageDetectViewController.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/11.
//

#import "CYTools.h"
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

#import "CYImageDetectViewController.h"

@interface CYImageDetectViewController ()
<ARSCNViewDelegate>

@property (nonatomic, strong) ARSCNView *sceneView;
@property (nonatomic, strong) ARWorldTrackingConfiguration *config;

@end

@implementation CYImageDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sceneView];
    self.sceneView.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    ARSessionRunOptions tmpSessionOption = ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors;
    [self.sceneView.session runWithConfiguration:self.config options:tmpSessionOption];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sceneView.session pause];
}

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    NSLog(@"发现目标！！！");
    SCNNode *tmpNode = [SCNNode cyNodeWithName:@"art.scnassets/ship.scn"];
    [self.sceneView cyAddSubnode:tmpNode];
}

#pragma mark -

- (ARSCNView *)sceneView {
    if (nil == _sceneView) {
        _sceneView = [[ARSCNView alloc] init];
        _sceneView.scene = [[SCNScene alloc] init];
        _sceneView.delegate = self;
    }
    
    return _sceneView;
}

- (ARWorldTrackingConfiguration *)config {
    if (nil == _config) {
        _config = [[ARWorldTrackingConfiguration alloc] init];
        _config.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:@"AR_Resources" bundle:nil];
    }
    return _config;
}

@end
