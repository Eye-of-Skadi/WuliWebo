//
//  NSDictionary+Verified.m
//
//  Created by alexruperez on 08/05/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "NSDictionary+Verified.h"

@implementation NSDictionary (Verified)

- (id)verifiedObjectForKey:(id)aKey
{
    
    if ([self objectForKey:aKey] && ![[self objectForKey:aKey] isKindOfClass:[NSNull class]]) {
        
        id object = [self objectForKey:aKey];
        if ( [object isKindOfClass:[NSNumber class]]){
            object = [object stringValue];
        }
        
        return object;
        
    }else if ([self objectForKey:[aKey capitalizedString]] && ![[self objectForKey:[aKey capitalizedString]] isKindOfClass:[NSNull class]]){
        
        id object = [self objectForKey:[aKey capitalizedString]];
        if ( [object isKindOfClass:[NSNumber class]]){
            object = [object stringValue];
        }
        
        return object;
        
    }else if ([self objectForKey:[aKey lowercaseString]] && ![[self objectForKey:[aKey lowercaseString]] isKindOfClass:[NSNull class]]){
        
        id object = [self objectForKey:[aKey lowercaseString]];
        if ( [object isKindOfClass:[NSNumber class]]){
            object = [object stringValue];
        }
        
        return object;
    }
    
    return @"";
}

@end
