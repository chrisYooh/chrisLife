//
//  ViewController.m
//  ARKitDemo
//
//  Created by Chris Yang on 2021/4/2.
//

#import "CYItemOperateViewController.h"
#import "CYShootingViewController.h"
#import "CYImageDetectViewController.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)OperateItem:(id)sender {
    CYItemOperateViewController *tmpVc = [[CYItemOperateViewController alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

- (IBAction)targetCatch:(id)sender {
    CYShootingViewController *tmpVc = [[CYShootingViewController alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

- (IBAction)imageDetect:(id)sender {
    CYImageDetectViewController *tmpVc = [[CYImageDetectViewController alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

@end
