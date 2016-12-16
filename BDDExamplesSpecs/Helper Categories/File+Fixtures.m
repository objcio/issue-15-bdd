/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import "File+Fixtures.h"


@implementation File (Fixtures)

+ (instancetype)fixtureFileWithName:(NSString *)name managedObjectContext:(NSManagedObjectContext *)context {
    File *file = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self)
                                         inManagedObjectContext:context];
    file.name = name;
    return file;
}

@end
