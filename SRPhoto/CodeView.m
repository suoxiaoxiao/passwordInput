//
//  CodeView.m
//  SRPhoto
//
//  Created by 索晓晓 on 2018/8/8.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

#import "CodeView.h"
#import "NSString+TextPath.h"

@interface CodeView ()

@property (nonatomic , strong) CAShapeLayer *shapeLayer;

@end

@implementation CodeView

 - (void)drawRect:(CGRect)rect {
     
//     CGContextRef context = UIGraphicsGetCurrentContext();
//     //清空上次绘制的
//     CGContextSaveGState(context);
//
//     CGContextMoveToPoint(context, 10, 10);

//     UIBezierPath *path = [self.title bezierPathWithFont:[UIFont systemFontOfSize:14]];
//     path.lineJoinStyle = kCGLineJoinRound;
//     path.lineCapStyle = kCGLineCapRound;

//     CGContextAddPath(context, path.CGPath);
////
//     CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
////
//     CGContextSetLineWidth(context, 2.0);//线的宽度
////
//     CGContextDrawPath(context, kCGPathStroke);
//
//     CGContextRestoreGState(context);
 }


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer addSublayer:self.shapeLayer];
        self.title = @"";
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (title == nil) {
        return;
    }
    
    if ([title isEqualToString:_title]) {
        return ;
    }
    
    _title = title;
    
    if (title.length == 0) {
        _title = @"__";
    }
    
    [self.shapeLayer removeAllAnimations];
    //self.shapeLayer 动画
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    UIBezierPath *path = [self.title bezierPathWithFont:[UIFont systemFontOfSize:20]];
    [path moveToPoint:CGPointMake(path.currentPoint.x, path.currentPoint.y)];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    self.shapeLayer.lineWidth = 2;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinRound;
    CGRect rect = CGPathGetBoundingBox(path.CGPath);
    rect.origin.x = (50  - rect.size.width)* 0.5;
    rect.origin.y = (50  - rect.size.height)* 0.5;
    self.shapeLayer.frame = rect;
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
    base.fromValue = @0;
    base.toValue = @1;
    base.duration = 0.5;
    base.autoreverses = NO;
    base.repeatCount = 1;
    base.removedOnCompletion = YES;
    base.fillMode = kCAFillModeBackwards;
    
    [self.shapeLayer addAnimation:base forKey:@"animation"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.bounds = CGRectMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5, 1, 1);
    }
    return _shapeLayer;
}

@end
