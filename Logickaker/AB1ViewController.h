//
//  AB1ViewController.h
//  FirstTry
//
//  Created by Ariel Borochov on 2/2/13.
//  Copyright (c) 2013 American University. All rights reserved.
//
#import "AB1DrawView.h"
#import <UIKit/UIKit.h>

@interface AB1ViewController : UIViewController
<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    int margin;
    AB1DrawView *abcTry;
}
@end
