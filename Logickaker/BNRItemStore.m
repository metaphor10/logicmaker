//
//  BNRItemStore.m
//  
//
//  Created by jAriel Borochov on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BNRItemStore.h"
#import "AB1ComponentCircuit.h"


@implementation BNRItemStore

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if(!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
        
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init 
{
    self = [super init];
    if(self) {                
        // Read in Homepwner.xcdatamodeld
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        // NSLog(@"model = %@", model);
        
        NSPersistentStoreCoordinator *psc = 
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // Where does the SQLite file go?    
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path]; 
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType 
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        // Create the managed object context
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // The managed object context can manage undo, but we don't need it
        [context setUndoManager:nil];
        isOutOfScrollView=false;
        
        [self loadAllItems];        
    }
    return self;
}


- (void)loadAllItems 
{
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"AB1ComponentCircuit"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor 
                                sortDescriptorWithKey:@"orderingvalue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES);
 
       // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];

    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (void)removeItem:(AB1ComponentCircuit *)p
{
    
    [context deleteObject:p];
    [allItems removeObjectIdenticalTo:p];
}

- (NSArray *)allItems
{
    return allItems;
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    AB1ComponentCircuit *p = [allItems objectAtIndex:from];

    // Remove p from array
    [allItems removeObjectAtIndex:from];

    // Insert p in array at new location
    [allItems insertObject:p atIndex:to];

// Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;

    // Is there an object before it in the array?
    if (to > 0) {
        lowerBound = [[allItems objectAtIndex:to - 1] orderingvalue];
    } else {
        lowerBound = [[allItems objectAtIndex:1] orderingvalue] - 2.0;
    }

    double upperBound = 0.0;

    // Is there an object after it in the array?
    if (to < [allItems count] - 1) {
        upperBound = [[allItems objectAtIndex:to + 1] orderingvalue];
    } else {
        upperBound = [[allItems objectAtIndex:to - 1] orderingvalue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;

    NSLog(@"moving to order %f", newOrderValue);
   [p setOrderingvalue:newOrderValue];
}

- (AB1ComponentCircuit *)createItem
{
    double order;
    if ([allItems count] == 0) {
        order = 1.0;
    } else {
        order = [[allItems lastObject] orderingvalue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f", [allItems count], order);

    AB1ComponentCircuit *p = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentCircuit"
                                                inManagedObjectContext:context];
    
    [p setOrderingvalue:order];
    
    [allItems addObject:p];
   
    return p;
}

- (NSArray *)allAssetTypes
{
    if (!allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] 
                                        objectForKey:@"AB1ComponentType"];
        
        [request setEntity:e];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        allAssetTypes = [result mutableCopy];
    }
    
    // Is this the first time the program is being run?
    if ([allAssetTypes count] == 0) {
        NSManagedObject *type;
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType" 
                                             inManagedObjectContext:context];
        [type setValue:@"" forKey:@"label"];
        [allAssetTypes addObject:type];
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Register" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Flag" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Register file" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Lookup table" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Input pin" forKey:@"label"];
        [allAssetTypes addObject:type];
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Output pin" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Label" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Multiplexor" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Decoder" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Splitter" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Joiner" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Constant" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Extender" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Adder" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Negate" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Increment" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Decrement" forKey:@"label"];
        [allAssetTypes addObject:type];

        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"  
                                             inManagedObjectContext:context];
        [type setValue:@"And" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Or" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Nand" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Nor" forKey:@"label"];
        [allAssetTypes addObject:type];

        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType" 
                                             inManagedObjectContext:context];
        [type setValue:@"Not" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Xor" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Equal-to" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Less-than" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Shift-left" forKey:@"label"];
        [allAssetTypes addObject:type];
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AB1ComponentType"
                                             inManagedObjectContext:context];
        [type setValue:@"Shift-right" forKey:@"label"];
        [allAssetTypes addObject:type];
        
        
        

        

    }
    return allAssetTypes;
}
-(void)SetcurrentAssetType:(NSManagedObject *)assetTypeCurrent
{
    currentAssetType = assetTypeCurrent;
}
-(NSManagedObject *)getCurrentAssetType
{
    return currentAssetType;
}
-(Boolean)getIsOutOfScrollView
{
    return isOutOfScrollView;
}
-(Boolean)setIsOutOfScrollView:(Boolean)state1
{
    isOutOfScrollView=state1;
}

@end
