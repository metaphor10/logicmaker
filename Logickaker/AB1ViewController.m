//
//  AB1ViewController.m
//  FirstTry
//
//  Created by Ariel Borochov on 2/2/13.
//  Copyright (c) 2013 American University. All rights reserved.
//

#import "AB1ViewController.h"
#import "AB1DrawView.h"
#import "AB1ComponentPicker.h"
#import "BNRItemStore.h"

@interface AB1ViewController ()

@end

@implementation AB1ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSLog(@"viewDidLoad");
    margin =30;
	// Do any additional setup after loading the view.
    
    
    
   
  
    CGRect rootViewBounds=[[[self parentViewController]view]bounds];
   // CGFloat rootViewHeight=CGRectGetHeight(rootViewBounds);
    
    CGFloat rootViewWidth=CGRectGetWidth(rootViewBounds);
    
    CGRect rectArea=CGRectMake(0, 64.0, rootViewWidth+150.0, 44.0);
   // [tb setFrame:rectArea];
    //trying to add UIScrollView
   UIScrollView *toolBarScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(rectArea.origin.x, rectArea.origin.y, rectArea.size.width, rectArea.size.height)];
    CGRect bigToolBarScrollRectArea= rectArea;
    bigToolBarScrollRectArea.size.width+=800;
   // [tb setFrame:bigToolBarScrollRectArea];
    //end of addition of UIScrollView
    //making a mutable array of buttons
    NSMutableArray *buttonsArray=[[NSMutableArray alloc]init];
    
    [toolBarScroll setContentSize:CGSizeMake(bigToolBarScrollRectArea.size.width+2, bigToolBarScrollRectArea.size.height+2)];
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Exit" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    CGRect buttonRect=CGRectMake(0, 0, 70, rectArea.size.height);
    buttonTwo.frame = buttonRect;
    [buttonsArray addObject:buttonTwo];
    
    buttonTwo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Save" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x +=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Load" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Unselect" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(unselect:) forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Select" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Duplicate" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Verify" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo]; 
    [buttonTwo setTitle:@"Simulate" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    //buttonRect.origin.x+=buttonRect.size.width +margin;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
   UILabel *label=[[UILabel alloc]init];
    [label setText:@"Place New:"];
    buttonRect.origin.x+=buttonRect.size.width+margin;
    
    buttonRect.size.width+=20.0;
    label.frame=buttonRect;
    [ label setBackgroundColor:[UIColor grayColor]];
    [buttonsArray addObject:label];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"bus" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(pickedBus:) forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    buttonTwo =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonTwo setTitle:@"Choose" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(componentPicker:) forControlEvents:UIControlEventTouchDown];
    buttonRect.origin.x+=buttonRect.size.width;
    buttonTwo.frame=buttonRect;
    [buttonsArray addObject:buttonTwo];
    
    //adding the array to the tool bar scroll view
    for (id button1 in buttonsArray) {
        [toolBarScroll addSubview:button1];
    }
    
    
  [toolBarScroll setBackgroundColor:[UIColor grayColor]];
   
    [self.navigationController.view addSubview:toolBarScroll];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadView
{
    
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    
    CGRect bigRect=fullScreenRect;
    bigRect.size.height*=2;
    bigRect.size.width*=2;
    scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect]; //makes UIScrollView the size of the screen
    
    abcTry=[[AB1DrawView alloc] initWithFrame:bigRect];
    [scrollView addSubview:abcTry];
    [scrollView setContentSize:bigRect.size];
    scrollView.contentInset=UIEdgeInsetsMake(0.0, 0.0,0.0, 0.0);
    scrollView.scrollIndicatorInsets=UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    
    
    [self setView:scrollView];
    
     
}
-(id)init
{
    self=[super init];
    if (self)
    {
        UINavigationItem *n=[self navigationItem];
        [n setTitle:@"Logik maker"];
        
         

    }
return self;
}

-(IBAction)componentPicker:(id)sender
{
    //AB1ComponentCircuit *item=[[BNRItemStore sharedStore]createItem];
     AB1ComponentPicker *componentTypePicker = [[AB1ComponentPicker alloc] init];
    //[componentTypePicker setItem:item];
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:abcTry action:@selector(tap:)];
    [abcTry addGestureRecognizer:tapRecognizer];
    [[self navigationController] pushViewController:componentTypePicker
                                          animated:YES];
    
}
-(IBAction)pickedBus:(id)sender
{
    
    scrollView.scrollEnabled=false;
    
   
    
}
-(IBAction)unselect:(id)sender
{
    scrollView.scrollEnabled=true;
    [[BNRItemStore sharedStore]SetcurrentAssetType:nil];
    
}

@end
