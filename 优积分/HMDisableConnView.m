//
//  HMDisableConnView.m
//  爱回家
//
//  Created by Helen on 16/7/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HMDisableConnView.h"

//定义屏幕的宽和高
#define fDeviceWidth MIN(([UIScreen mainScreen].bounds.size.width),([UIScreen mainScreen].bounds.size.height))
#define fDeviceHeight MAX(([UIScreen mainScreen].bounds.size.height),([UIScreen mainScreen].bounds.size.width))

@implementation HMDisableConnView

-(instancetype)initWithFrame:(CGRect)frame{


    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        
        /**
         * 添加不能联网的提示
         */
        CGFloat titleX = 0;
        CGFloat titleY = fDeviceWidth/5*2;
        CGFloat titleW = fDeviceWidth;
        CGFloat titleH = [self heightForString:@"无法连接网络" fontSize:11 andWidth:titleW];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        title.center = CGPointMake(fDeviceHeight/2.0, titleY);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"无法连接网络";
        title.textColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:0.8];
        title.font = [UIFont systemFontOfSize:11];
        [self addSubview:title];
        
        
        /**
         * 添加重新刷新字体
         */
        CGFloat refrshX = 0;
        CGFloat refrshY = fDeviceWidth/7*4;
        CGFloat refrshW = fDeviceHeight*52/55.0;
        CGFloat refrshH = [self heightForString:@"重新刷新" fontSize:10 andWidth:refrshW];
        UILabel *refrsh = [[UILabel alloc] initWithFrame:CGRectMake(refrshX, refrshY, refrshW, refrshH)];
        refrsh.text = @"重新刷新";
        refrsh.center = CGPointMake(fDeviceHeight/2.0, refrshY);
        refrsh.font = [UIFont systemFontOfSize:10];
        refrsh.textAlignment = NSTextAlignmentCenter;
        refrsh.textColor = [UIColor purpleColor];
        
        /**
         * 添加重新刷新背景
         */
        CGFloat refrshbgX = 0;
        CGFloat refrshbgY = refrshY;
        CGFloat refrshbgW = fDeviceHeight*52/55.0;
        CGFloat refrshbgH = refrshH+18;
        UIImageView *refrshbg=[[UIImageView alloc]initWithFrame:CGRectMake(refrshbgX, refrshbgY, refrshbgW, refrshbgH)];
        
        refrshbg.center = CGPointMake(fDeviceHeight/2.0, refrshbgY);
        
        refrshbg.layer.masksToBounds=YES;
        refrshbg.layer.cornerRadius=3; //设置为图片宽度的一半出来为圆形
        refrshbg.layer.borderWidth=1.0f; //边框宽度
        refrshbg.layer.borderColor=[[UIColor colorWithRed:164.0/255.0 green:107/255.0 blue:199.0/255.0 alpha:0.8] CGColor];//边框颜色
        
        
        /**
         * 添加点击事件
         */
        [refrshbg setUserInteractionEnabled:YES];
        
        [refrshbg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refrsh:)]];
        
        
        [self addSubview:refrsh];
        
        [self addSubview:refrshbg];

        
    }

    return self;

}



/**
 *  点击重新加载事件
 */
-(void)refrsh:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *bg = (UIImageView *)[gestureRecognizer view];
    
    bg.backgroundColor = [UIColor colorWithRed:164.0/255.0 green:107/255.0 blue:199.0/255.0 alpha:0.8];
    /**
     * 添加重新刷新字体
     */
    CGFloat refrshX = bg.frame.size.width/2.0;
    CGFloat refrshY = bg.frame.size.height/2;
    CGFloat refrshW = fDeviceHeight*52/55.0;
    CGFloat refrshH = [self heightForString:@"重新刷新" fontSize:10 andWidth:refrshW];
    UILabel *refrsh = [[UILabel alloc] initWithFrame:CGRectMake(refrshX, refrshY, refrshW, refrshH)];
    refrsh.text = @"重新刷新";
    refrsh.center = CGPointMake(refrshX, refrshY);
    refrsh.font = [UIFont systemFontOfSize:10];
    refrsh.textAlignment = NSTextAlignmentCenter;
    refrsh.textColor = [UIColor whiteColor];
    [bg addSubview:refrsh];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        bg.backgroundColor = [UIColor clearColor];
        
        [[bg.subviews lastObject] removeFromSuperview];
        
        /**
         *  重新检查网络  通过代理
         */
        if ([self.delegate respondsToSelector:@selector(checkNet)]) {
             [self.delegate checkNet];
        }
       
       
    });
    
}


/**
 * 计算文字的高度
 */
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
@end
