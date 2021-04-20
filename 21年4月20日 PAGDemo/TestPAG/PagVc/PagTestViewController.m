//
//  PagTestViewController.m
//  TestPAG
//
//  Created by Chris Yang on 2021/3/30.
//

#import <CYToolkit/CYToolkit.h>
#import <Masonry/Masonry.h>
#import <libpag/PAGView.h>

#import "PagTestViewController.h"

@interface PagTestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemViewArray;

@end

@implementation PagTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.scrollView];
    
    cyWeakSelf(mainVc);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainVc.view);
    }];

    [self pagViewWithName:@"摇摆" tag:0];
    [self pagViewWithName:@"旋转" tag:1];
    [self pagViewWithName:@"无限放大" tag:2];
    [self pagViewWithName:@"汇聚" tag:3];
    [self pagViewWithName:@"抖动" tag:4];
    [self pagViewWithName:@"弹球" tag:5];
}

- (void)scrollViewClicked {
    for (PAGView *tmpView in self.itemViewArray) {
        [tmpView play];
    }
}

- (PAGView *)pagViewWithName:(NSString *)name tag:(NSInteger)tag {
    
    NSString *pagPath = [[NSBundle mainBundle] pathForResource:name ofType:@"pag"];
    PAGFile *tmpFile = [PAGFile Load:pagPath];

    PAGView *tmpView = [[PAGView alloc] init];
    [tmpView setComposition:tmpFile];
    [tmpView setRepeatCount:-1];
    [tmpView setBackgroundColor:[UIColor cyRandomColorWithAlpha:0.3]];
    tmpView.tag = tag;

    [self.scrollView addSubview:tmpView];

    cyWeakSelf(mainVc);
    [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainVc.scrollView).offset(110 * tag + 100);
        make.centerX.equalTo(mainVc.view);
        make.width.height.mas_equalTo(100);
        make.bottom.lessThanOrEqualTo(mainVc.scrollView).offset(-20);
    }];
    [tmpView layoutIfNeeded];
    
    [self.itemViewArray addObject:tmpView];
    
    return tmpView;
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked)];
        [_scrollView addGestureRecognizer:tapGesture];
    }

    return _scrollView;
}

- (NSMutableArray *)itemViewArray {
    if (!_itemViewArray) {
        _itemViewArray = [[NSMutableArray alloc] init];
    }
    return _itemViewArray;;
}

@end
