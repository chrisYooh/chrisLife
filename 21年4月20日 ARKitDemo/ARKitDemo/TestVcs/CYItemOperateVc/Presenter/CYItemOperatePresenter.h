//
//  CYItemOperatePresenter.h
//  GmesTest
//
//  Created by Chris on 2021/04/11 11:41:08.
//  Copyright © 2019 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYItemOperateViewInterface <NSObject>

//- (void)presenter...;

@end

@interface CYItemOperatePresenter : NSObject

/* View Interface */
@property (nonatomic, weak) UIViewController<CYItemOperateViewInterface> *viewInterface;

/* Properties */
//@property ...

/* Operations */
//- (void)doSomething...

/* Routers */
//- (void)pushxxxVc...
//- (void)showActionSheet...

@end

