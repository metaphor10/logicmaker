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
            
           /* CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor2, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor2, t.ycoor2);
            CGContextAddLineToPoint(context, t.xcoor, t.ycoor2);
            
            CGContextClosePath(context);
            
            CGContextFillPath(context);
            
            CGContextMoveToPoint(context, t.xcoor, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor2, t.ycoor);
            CGContextAddLineToPoint(context, t.xcoor2, t.ycoor2);
            CGContextAddLineToPoint(context, t.xcoor, t.ycoor2);
            CGContextClosePath(context);
            CGContextStrokePath(context);*/
            CGRect register1=CGRectMake(t.xcoor, t.ycoor, XSIZE, YSIZE);
            CGContextStrokeRect(context, register1);
            CGContextFillRect(context, register1);
        }else if([[t assetType]valueForKey:@"label"]==@"Lookup table"){
            //according to plan
            UIColor *background=[UIColor whiteColor];
            CGColorRef color=[background CGColor];
            CGContextSetFillColorWithColor(context, color);
            CGRect register1=CGRectMake(t.xcoor, t.ycoor, XSIZE, YSIZE);
            
            CGContextStrokeRect(context, register1);
            
            CGContextFillRect(context, register1);
            CGContextMoveToPoint(context, t.xcoor+5, t.ycoor+(t.ycoor2-t.ycoor)/4);
            CGContextAddLineToPoint(context, t.xcoor+(t.xcoor2-t.xcoor)-5, t.ycoor+(t.ycoor2-t.ycoor)/4);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, t.xcoor+(t.xcoor2-t.xcoor)/2, t.ycoor+(t.ycoor2-t.ycoor)/4);
            CGContextAddLineToPoint(context, t.xcoor+(t.xcoor2-t.xcoor)/2, t.ycoor+(t.ycoor2-t.ycoor)-(t.ycoor2-t.ycoor)/4);
            CGContextStrokePath(context);
        }else if([[t assetType]valueForKey:@"label"]==@"ALU"||[[t assetType]valueForKey:@"label"]==@"Adder"||[[t assetType]valueForKey:@"label"]==@"Combinational-adder"||[[t assetType]valueForKey:@"label"]==@"Equal-to"||[[t assetType]valueForKey:@"label"]==@"Less-then"||[[t assetType]valueForKey:@"label"]==@"Shift-left"||[[t assetType]valueForKey:@"label"]==@"Shift-right"){
            int x=t.xcoor+(t.xcoor2-t.xcoor)/2,y=t.ycoor+(t.ycoor2-t.ycoor)/2;
            CGContextMoveToPoint(context, x-(t.xcoor2-t.xcoor)/2, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x-(t.xcoor2-t.xcoor)/2+(t.xcoor2-t.xcoor)/5, y+(t.ycoor2-t.ycoor)/2);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x+(t.xcoor2-t.xcoor)/2, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x+(t.xcoor2-t.xcoor)/2-(t.xcoor2-t.xcoor)/5, y+(t.ycoor2-t.ycoor)/2);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x-(t.xcoor2-t.xcoor)/2+(t.xcoor2-t.xcoor)/5, y+(t.ycoor2-t.ycoor)/2);
            
            CGContextAddLineToPoint(context, x+(t.xcoor2-t.xcoor)/2-(t.xcoor2-t.xcoor)/5, y+(t.ycoor2-t.ycoor)/2);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x-(t.xcoor2-t.xcoor)/8, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x, y-(t.ycoor2-t.ycoor)/3);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x+(t.xcoor2-t.xcoor)/8, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x, y-(t.ycoor2-t.ycoor)/3);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x-(t.xcoor2-t.xcoor)/2, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x-(t.xcoor2-t.xcoor)/8, y-(t.ycoor2-t.ycoor)/2);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, x+(t.xcoor2-t.xcoor)/2, y-(t.ycoor2-t.ycoor)/2);
            CGContextAddLineToPoint(context, x+(t.xcoor2-t.xcoor)/8, y-(t.ycoor2-t.ycoor)/2);
            CGContextStrokePath(context);
            
            
        }else if ([[t assetType]valueForKey:@"label"]==@"Memory" || [[t assetType]valueForKey:@"label"]==@"Ports" || [[t assetType]valueForKey:@"label"]==@"Register file")
        {
            CGRect register1=CGRectMake(t.xcoor, t.ycoor,t.xcoor2-t.xcoor , t.ycoor2-t.ycoor );
            CGContextStrokeRect(context, register1);
            if ([[t assetType]valueForKey:@"label"]==@"Register file") {
                CGContextSetRGBFillColor(context, .90,.90,1,1);
                CGContextFillRect(context, register1);
            }else if ([[t assetType]valueForKey:@"label"]==@"Memory")
            {
                CGContextSetRGBFillColor(context, 1,.90,1,1);
                CGContextFillRect(context, register1);
            }else if ([[t assetType]valueForKey:@"label"]==@"Ports")
            {
                CGContextSetRGBFillColor(context, .90,1,.95,1);
                CGContextFillRect(context, register1);
                CGContextMoveToPoint(context, t.xcoor, t.ycoor+(t.ycoor2-t.ycoor)/3);
                CGContextAddLineToPoint(context, t.xcoor+(t.xcoor2-t.xcoor), t.ycoor+(t.ycoor2-t.ycoor)/3);
                CGContextMoveToPoint(context, t.xcoor, t.ycoor+2*(t.ycoor2-t.ycoor)/3);
                CGContextAddLineToPoint(context, t.xcoor+(t.xcoor2-t.xcoor), t.ycoor+2*(t.ycoor2-t.ycoor)/3);
                CGContextStrokePath(context);
                
                
            }
        }else if ([[t assetType]valueForKey:@"label"]==@"Extender" || [[t assetType]valueForKey:@"label"]==@"Inhibitor")
        {
            CGContextAddEllipseInRect(context, CGRectMake(t.xcoor, t.ycoor,t.xcoor2-t.xcoor, t.ycoor2-t.ycoor));
            CGContextStrokePath(context);

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
        
        AB1ComponentCircuit *component = [[BNRItemStore sharedStore]createItem];
        
        struct CGPoint g=[gr locationInView:self];
        component.xcoor=g.x;
        component.ycoor=g.y;
        component.assetType=[[BNRItemStore sharedStore]getCurrentAssetType];
        int x=XSIZE;
        int y=YSIZE;
        NSString *type=[[component assetType]valueForKey:@"label"];
        if (type==@"Register"||type==@"Lookup table"|| type==@"Adder" || type ==@"Register file" || type==@"Memory" || type == @"Ports")
        {
            component.xcoor2=g.x+x;
            component.ycoor2=g.y+y;
        }else if (type==@"Decoder")
        {
            component.xcoor2=g.x+x;
            component.ycoor2=g.y+y/2;
            if (pow(2, component.bits)*3>x) {
                component.xcoor2=g.x+(int)(pow(2, component.bits)*3);
                
            }
        }else if (type==@"Flag"||type==@"Constant")
        {
            component.xcoor2=g.x+x/2;
            component.ycoor2=g.y+y/2;
        }else if (type==@"Splitter"||type==@"Joiner")
        {
            component.xcoor2=g.x+x;
            component.ycoor2=g.y+y/3;
        }else if (type==@"Input pin"||type==@"Output pin")
        {
            component.xcoor2=g.x+x/3;
            component.ycoor2=g.y+y/3;
        }else if (type==@"Not"||type==@"Negate")
        {
            component.xcoor2=g.x+x/2;
            component.ycoor2=g.y+y/2;
        }else{
            component.xcoor2=g.x+x;
            component.ycoor2=g.y+y/2;        }
        
        
        
        
        
    }
    
    
    
    
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
