#import "Specs.h"

#import "PhotoUploadViewController.h"
#import "PhotoUploader.h"
#import "UIBarButtonItem+Specs.h"


@interface PhotoUploadViewController (Specs)
- (void)didTapUploadButton:(UIBarButtonItem *)uploadButton;
@end

SpecBegin(PhotoUploadViewController)

describe(@"PhotoUploadViewController", ^{
    __block PhotoUploadViewController *photoUploadViewController;
    __block id mockPhotoUploader;

    beforeEach(^{
        mockPhotoUploader = mock([PhotoUploader class]);
        photoUploadViewController = [[PhotoUploadViewController alloc] initWithPhotoUploader:mockPhotoUploader];
    });

    afterEach(^{
        photoUploadViewController = nil;
    });

    // Non-behavior style

    describe(@"right bar button item", ^{

        __block UIBarButtonItem *barButtonItem;

        beforeEach(^{
            barButtonItem = [[photoUploadViewController navigationItem] rightBarButtonItem];
        });

        it(@"should have a title", ^{
            expect(barButtonItem.title).to.equal(@"Upload");
        });

        it(@"should have a target", ^{
            expect(barButtonItem.target).to.equal(photoUploadViewController);
        });

        it(@"should have an action", ^{
            expect(barButtonItem.action).to.equal(@selector(didTapUploadButton:));
        });
    });

    describe(@"tapping right bar button item", ^{
        beforeEach(^{
            [photoUploadViewController didTapUploadButton:nil];
        });

        it(@"should tell the mock photo uploader to upload the photo", ^{
            [verify(mockPhotoUploader) uploadPhoto:instanceOf([UIImage class])
                                        completion:anything()];
        });
    });

    // BDD Style

    describe(@"right bar button item", ^{

        __block UIBarButtonItem *barButtonItem;

        beforeEach(^{
            barButtonItem = [[photoUploadViewController navigationItem] rightBarButtonItem];
        });

        it(@"should have a title", ^{
            expect(barButtonItem.title).to.equal(@"Upload");
        });

        describe(@"when it is tapped", ^{
            beforeEach(^{
                [barButtonItem specsSimulateTap];
            });

            it(@"should tell the mock photo uploader to upload the photo", ^{
                [verify(mockPhotoUploader) uploadPhoto:instanceOf([UIImage class])
                                            completion:anything()];
            });
        });
    });
});

SpecEnd
