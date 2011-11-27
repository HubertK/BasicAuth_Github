//
//  Base64.h
//  Basic_Auth
//
//  Created by Helene Brooks on 11/26/11.
//  Copyright (c) 2011 vaughn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject
+(NSString *)encode:(NSData *)plainText;
@end
