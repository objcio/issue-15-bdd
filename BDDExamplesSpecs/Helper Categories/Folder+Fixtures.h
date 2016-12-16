/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import "Folder.h"

@class File;

@interface Folder (Fixtures)

+ (instancetype)fixtureFolderWithName:(NSString *)name managedObjectContext:(NSManagedObjectContext *)context;

#pragma mark -

- (File *)specsAddFileWithName:(NSString *)name;

@end
