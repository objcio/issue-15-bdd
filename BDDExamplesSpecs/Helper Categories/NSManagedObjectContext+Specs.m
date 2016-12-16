/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import "NSManagedObjectContext+Specs.h"


@implementation NSManagedObjectContext (Specs)

+ (instancetype)specsInMemoryManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[self alloc] init];

    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    managedObjectContext.persistentStoreCoordinator = coordinator;

    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil
                                        URL:nil options:nil
                                      error:nil];

    return managedObjectContext;
}

@end
