//
//  AB1DrawView.h
//  FirstTry
//
//  Created by Ariel Borochov on 2/2/13.
//  Copyright (c) 2013 American University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@interface AB1DrawView : UIScrollView
<UIGestureRecognizerDelegate>
{
    NSMutableArray *boxesOnScreen;
    CGPoint point;
    
}
@property (nonatomic,strong) UIGestureRecognizer *moveRecognizer;
@end
