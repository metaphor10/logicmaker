//
//  AB1DrawView.m
//  FirstTry
//
//  Created by Ariel Borochov on 2/2/13.
//  Copyright (c) 2013 American University. All rights reserved.
//

#import "AB1DrawView.h"
#import "AB1ComponentCircuit.h"
#import "BNRItemStore.h"

@implementation AB1DrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
       // UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
       // [self addGestureRecognizer:tapRecognizer];
        point = CGPointMake(0, 0);
        boxesOnScreen = [[NSMutableArray alloc]init];
        
        
                
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
    for (AB1ComponentCircuit *t in [[BNRItemStore sharedStore]allItems]) {
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        //CGContextMoveToPoint(context, t.xcoor, t.ycoor);
        //CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor);
       // CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor+20);
       // CGContextAddLineToPoint(context, t.xcoor, t.ycoor+20);
       // CGContextClosePath(context);
        
        //CGContextStrokePath(context);
        
        //CGContextMoveToPoint(context, t.xcoor, t.ycoor);
        //CGContextAddArcToPoint(context, t.xcoor+10, t.ycoor+10, t.xcoor+70, t.ycoor+70, 60);
        
               
        if ([[t assetType]valueForKey:@"label"]==@"And")
        {
            NSLog(@"And");
            CGContextAddArc(context, t.xcoor+20, t.ycoor, 20.0, 0.0, M_PI/1.0, false);
            CGContextAddLineToPoint(context, t.xcoor+40, t.ycoor);
            CGContextStrokePath(context);

        }else if ([[t assetType]valueForKey:@"label"]==@"Not"){
            NSLog(@"Not");
            
            CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+10, t.ycoor+30);
            CGContextClosePath(context);
            
            CGContextAddEllipseInRect(context, CGRectMake(t.xcoor+8, t.ycoor+30,5, 5));
            CGContextStrokePath(context);
            
        }else if ([[t assetType]valueForKey:@"label"]==@"Or"){
            CGContextAddArc(context, t.xcoor+20, t.ycoor, 20.0, 0.0, M_PI/1.0, false);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddArc(context, t.xcoor+20, t.ycoor, 10, 0.0, M_PI/1.0, false);
            CGContextStrokePath(context);
            
        }else if([[t assetType]valueForKey:@"label"]==@"Multiplexor"){
            CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+30, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor+10);
            CGContextAddLineToPoint(context,t.xcoor+10 , t.ycoor+10);
            CGContextClosePath(context);
            CGContextStrokePath(context);
        }else if([[t assetType]valueForKey:@"label"]==@"Register"){
            
            // Drawing with a blue fill color
            CGContextSetRGBFillColor(context, 0.0, 0.0, 10.0, 1.0);
            // Draw them with a 2.0 stroke width so they are a bit more visible.
            CGContextSetLineWidth(context, 2.0);
            
            CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor+20, t.ycoor+10);
            CGContextAddLineToPoint(context, t.xcoor, t.ycoor+10);
            CGContextClosePath(context);
            CGContextFillPath(context);
            
        }else{
            
        }
        
        
       
                
        
        
        
        
            
                
        
        
       
            
            
       
        
    }
    NSLog(@"inside draw rect");
  [self setNeedsDisplay];
    
}
 

-(void)tap:(UITapGestureRecognizer *)gr
{
    NSLog(@"tap");
    if ([[BNRItemStore sharedStore]getCurrentAssetType]!=nil)
    {
        NSLog(@"Not choosen");
        AB1ComponentCircuit *component = [[BNRItemStore sharedStore]createItem];
        
        struct CGPoint g=[gr locationInView:self];
        component.xcoor=g.x;
        component.ycoor=g.y;
        component.assetType=[[BNRItemStore sharedStore]getCurrentAssetType];
    }
    
    
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetLineWidth(context, 1.0);
    
    
    /*
    CALayer *boxLayer = [[CALayer alloc]init];
   
    // Drawing code
    //create a new layer
    boxLayer = [[CALayer alloc]init];
    //give it a size
    [boxLayer setBounds:CGRectMake(0.0, 0.0, 85.0, 85.0)];
    //give it a location
     point=[gr locationInView:self];
    [boxLayer setPosition:point];
    //make half transperent red the background
    UIColor *reddish=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    //get CGColor object with the same color
    CGColorRef cgReddish=[reddish CGColor];
    //Set background of the rect
    [boxLayer setBackgroundColor:cgReddish];
    //create an image file
    
    UIImage *layerImage=[UIImage imageNamed:@"and.png"];
    //get the underlaying CGImage
    CGImageRef image=[layerImage CGImage];
    //put the image on the layer
    [boxLayer setContents:(__bridge id)image];
    //inset the image a bit from each side
    [boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];
    //let the image resize (without changing the aspect ration)
    [boxLayer setContentsGravity:kCAGravityResizeAspect];
    //add the box layer to the array of items on the screen
    [boxesOnScreen addObject:boxLayer];
    */
    [self setNeedsDisplay];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches began");
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches ended");
}




@end
