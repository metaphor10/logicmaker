//
//  BNRItemStore.h
//  
//
//  Created by Ariel Borochov on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class AB1ComponentCircuit;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
    NSMutableArray *allAssetTypes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
    NSManagedObject *currentAssetType;
    Boolean isOutOfScrollView;
}

+ (BNRItemStore *)sharedStore;

- (void)removeItem:(AB1ComponentCircuit *)p;

- (NSArray *)allItems;

- (AB1ComponentCircuit *)createItem;

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

- (NSArray *)allAssetTypes;

- (void)loadAllItems;
-(void)SetcurrentAssetType:(NSManagedObject *)assetTypeCurrent;
-(NSManagedObject *)getCurrentAssetType;
-(Boolean)getIsOutOfScrollView;

@end
