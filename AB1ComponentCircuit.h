//
//  AB1ComponentCircuit.h
//  Logickaker
//
//  Created by Ariel Borochov on 5/31/13.
//  Copyright (c) 2013 American University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AB1ComponentCircuit : NSManagedObject

@property (nonatomic) int16_t xcoor;
@property (nonatomic) int16_t ycoor;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * description1;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL highlighted;
@property (nonatomic, retain) NSString * type;
@property (nonatomic) int64_t bits;
@property (nonatomic) int64_t value;
@property (nonatomic) double orderingvalue;
@property (nonatomic, retain) NSManagedObject *assetType;

@end
