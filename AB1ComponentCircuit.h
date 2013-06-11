//
//  AB1ComponentCircuit.h
//  Logickaker
//
//  Created by Michael Black on 6/7/13.
//  Copyright (c) 2013 American University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AB1ComponentType;

@interface AB1ComponentCircuit : NSManagedObject

@property (nonatomic) int64_t bits;
@property (nonatomic, retain) NSString * description1;
@property (nonatomic) BOOL highlighted;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) double orderingvalue;
@property (nonatomic) BOOL selected;
@property (nonatomic, retain) NSString * type;
@property (nonatomic) int64_t value;
@property (nonatomic) int16_t xcoor;
@property (nonatomic) int16_t ycoor;
@property (nonatomic) int32_t xcoor2;
@property (nonatomic) int32_t ycoor2;
@property (nonatomic, retain) NSManagedObject *assetType;

@end
