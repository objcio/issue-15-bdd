/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import "Folder+Fixtures.h"
#import "File.h"
#import "File+Fixtures.h"


@implementation Folder (Fixtures)

+ (instancetype)fixtureFolderWithName:(NSString *)name managedObjectContext:(NSManagedObjectContext *)objectContext {
    Folder *folder = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self)
                                  inManagedObjectContext:objectContext];
    folder.name = name;
    return folder;
}

#pragma mark -

- (File *)specsAddFileWithName:(NSString *)name {
    File *file = [File fixtureFileWithName:name managedObjectContext:self.managedObjectContext];

    file.name = name;
    file.parent = self;

    return file;
}

@end
