//
//  Copyright (c) 2014 Pawel Dudek. All rights reserved.
//

#import "PhotoUploadViewController.h"
#import "PhotoUploader.h"


@implementation PhotoUploadViewController

- (instancetype)initWithPhotoUploader:(PhotoUploader *)photoUploader {
    self = [super init];
    if (self) {
        _photoUploader = photoUploader;

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Upload", nil)
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(didTapUploadButton:)];
    }

    return self;
}

#pragma mark -

- (void)didTapUploadButton:(UIBarButtonItem *)uploadButton {
    void (^completion)(NSError *) = ^(NSError* error){};
    [self.photoUploader uploadPhoto:[UIImage new] completion:completion];
}

@end
