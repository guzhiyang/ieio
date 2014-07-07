//  EMAsyncImageView.m
//  Created by erwin on 11/05/12.

/*
 
	Copyright (c) 2012 eMaza Mobile. All rights reserved.

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/


#import "EMAsyncImageView.h"

@interface EMAsyncImageView()

	@property (nonatomic, strong) NSURLConnection			*connection;
	@property (nonatomic, strong) NSMutableData				*data;
	@property (nonatomic, strong) NSString					*filePath;

@end

@implementation EMAsyncImageView {

}

@synthesize imageId, imageUrl, imageIdKey;
@synthesize connection, data, filePath;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
	}
	return self;
}

- (void)setup {
	self.clipsToBounds = TRUE;
}

- (void)setImageSize:(int)aSize {
	self.filePath = nil;
}

- (void)setImageId:(NSString *)anId {
	imageId = anId;
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:[self filePath]]) {
        self.image = [[UIImage alloc] initWithContentsOfFile:[self filePath]];
        //加载图片结束
        if (delegate && [delegate respondsToSelector:@selector(EMAsyncImageViewFinishedLoadingWith:ImageURL:EMAsyncImageView:)]) {
            [delegate EMAsyncImageViewFinishedLoadingWith:self.image ImageURL:self.imageUrl EMAsyncImageView:self];
        }
        if (!self.image) {
            [self downloadImage];
        }
		[self setNeedsDisplay];
	} else {
		[self downloadImage];
	}
}

- (void)setImageUrl:(NSString *)url {
	if (!url) {
		[connection cancel];
        imageId       = nil;
        imageUrl      = nil;
        self.filePath = nil;
        self.image    = nil;
		return;
	}
	imageUrl = url;
//    NSLog(@"url:%@",imageUrl);
    [self setImageId:[[imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@""] stringByReplacingOccurrencesOfString:@"=" withString:@""]];
//    NSLog(@"url:%@\n%@",imageUrl,imageId);
}

- (void)downloadImage {
	self.data = [NSMutableData data];
	NSURL *url = [NSURL URLWithString:imageUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection	didReceiveData:(NSData *)incrementalData {
    if (!data) self.data = [NSMutableData data];
    [data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	self.connection = nil;
	if ([theConnection.currentRequest.URL.absoluteString isEqualToString:imageUrl]) {
		self.image = [UIImage imageWithData:data];
        if (delegate && [delegate respondsToSelector:@selector(EMAsyncImageViewFinishedLoadingWith:ImageURL:EMAsyncImageView:)]) {
            [delegate EMAsyncImageViewFinishedLoadingWith:self.image ImageURL:self.imageUrl EMAsyncImageView:self];
        }
		[self setNeedsLayout];
		if ([imageId length] > 0) [data writeToFile:[self filePath] atomically:TRUE];
	}
	self.data = nil;
}

- (NSString*)fileName {
	if (imageId) return [NSString stringWithFormat:@"thumb_%@", imageId];;
	return @"";
}

- (NSString*)filePath {
	if (!filePath) {
		NSString *imageCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		self.filePath = [imageCachePath stringByAppendingPathComponent:[self fileName]];
	}
	return filePath;
}

- (void)dealloc {
    [connection cancel];
}

@end
