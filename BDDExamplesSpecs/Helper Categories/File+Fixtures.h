/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import "File.h"

@interface File (Fixtures)

+ (instancetype)fixtureFileWithName:(NSString *)name managedObjectContext:(NSManagedObjectContext *)context;

@end
