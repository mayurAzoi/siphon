/**
 *  AKChain.m
 *  Siphon
 *  Copyright (C) 2011 Samuel <samuelv0304@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#import "AKKeychain.h"


#define KEY_CHAIN 1
#if !KEY_CHAIN
#import "SettingsController.h"
#endif

@implementation AKKeychain

+ (NSString *)passwordForServiceName:(NSString *)serviceName
                         accountName:(NSString *)accountName 
{
#if KEY_CHAIN	
	NSData *passwordData = NULL;
	OSStatus findStatus;
	NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
												 (id)kSecClass, kSecClassGenericPassword,
												 kSecAttrType, 'voip',
												 kSecAttrService, serviceName,
												 kSecAttrAccount, accountName,
												 // Use the proper search constants, 
												 // return only the attributes of the first match.
												 kSecMatchLimit, (id)kSecMatchLimitOne,
												 kSecReturnData, (id)kCFBooleanTrue,
												 nil];
	
	// Acquire the password data from the attributes.
	findStatus = SecItemCopyMatching ((CFDictionaryRef)query,
																		(CFTypeRef *)&passwordData);
	if (findStatus != errSecSuccess)
		return nil;
	
	// Convert password from NSData to NSString.
	NSString *password = [[[NSString alloc] initWithBytes:[passwordData bytes] 
																								 length:[passwordData length] 
																							 encoding:NSUTF8StringEncoding] autorelease];
	
	[passwordData release];
	
	return password;
	
#else
	NSArray *savedAccounts = [[NSUserDefaults standardUserDefaults] arrayForKey:kAccounts];
	for (NSDictionary *accountDict in savedAccounts)
	{
		NSString *localUsername = [accountDict objectForKey:kUsername];
		NSString *localServiceName;
		NSString *registrar = [accountDict objectForKey:kRegistrar];
		if ([registrar length])
      localServiceName = [NSString stringWithFormat:@"SIP: %@", registrar];
    else
      localServiceName = [NSString stringWithFormat:@"SIP: %@", [accountDict objectForKey:kDomain]];
		
		if (([localServiceName compare:serviceName options:NSLiteralSearch] == NSOrderedSame) &&
					([localUsername compare:accountName options:NSLiteralSearch] == NSOrderedSame))
			return [accountDict objectForKey:kPassword];
	}
	return nil;
#endif
}

+ (BOOL)addItemWithServiceName:(NSString *)serviceName
                   accountName:(NSString *)accountName
                      password:(NSString *)password 
{
#if KEY_CHAIN
	NSDictionary *attributes, *query, *attributesToUpdate;
	OSStatus addStatus, modifyStatus;
  BOOL success = NO;
	
	attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								(id)kSecClass, kSecClassGenericPassword,
								kSecAttrType, 'voip',
								kSecAttrService, serviceName,
								kSecAttrAccount, accountName,
								kSecValueData, [password dataUsingEncoding:NSUTF8StringEncoding],
								nil];
	
	// Add item to keychain.
	addStatus = SecItemAdd ((CFDictionaryRef)attributes, NULL /*CFTypeRef *result*/);
	if (addStatus == errSecSuccess) 
    success = YES;
  else if (addStatus == errSecDuplicateItem) 
	{
		query = [NSDictionary dictionaryWithObjectsAndKeys:
						 (id)kSecClass, kSecClassGenericPassword,
						 kSecAttrType, 'voip',
						 kSecAttrService, serviceName,
						 kSecAttrAccount, accountName,
						 // Use the proper search constants, 
						 // return only the attributes of the first match.
						 kSecMatchLimit, (id)kSecMatchLimitOne,
						 kSecReturnAttributes, (id)kCFBooleanTrue,
						 nil];
		
		attributesToUpdate = [NSDictionary dictionaryWithObject:[password dataUsingEncoding:NSUTF8StringEncoding]
																										 forKey:(id)kSecValueData];
		// Modify password in the duplicate item.
		modifyStatus =	SecItemUpdate ((CFDictionaryRef)query,
																	 (CFDictionaryRef)attributesToUpdate);
		if (modifyStatus == errSecSuccess)
			success = YES;
	}
	
	return success;
#else
	return NO;
#endif
}

@end
