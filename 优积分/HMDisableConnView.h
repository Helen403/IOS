//
//  HMDisableConnView.h
//  爱回家
//
//  Created by Helen on 16/7/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMDisableConnViewDelegate <NSObject>

- (void)checkNet;

@end

@interface HMDisableConnView : UIView

@property (nonatomic, assign) id <HMDisableConnViewDelegate> delegate;

@end
