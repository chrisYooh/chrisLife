//
//  ViewController.m
//  TestPAG
//
//  Created by Chris Yang on 2021/3/29.
//

#import "PagTestViewController.h"
#import "LottieTestViewController.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (IBAction)testLottie:(id)sender {
    LottieTestViewController *tmpVc = [[LottieTestViewController alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

- (IBAction)testPAG:(id)sender {
    PagTestViewController *tmpVc = [[PagTestViewController alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

@end
