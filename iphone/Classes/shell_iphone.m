/*****************************************************************************
 * Free42 -- an HP-42S calculator simulator
 * Copyright (C) 2004-2009  Thomas Okken
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License, version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/licenses/.
 *****************************************************************************/

#import <AudioToolbox/AudioServices.h>
#import "shell_iphone.h"

static SystemSoundID soundIDs[12];

@implementation shell_iphone

@synthesize window;
@synthesize view;


- (void) applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after application launch

	const char *sound_names[] = { "tone0", "tone1", "tone2", "tone3", "tone4", "tone5", "tone6", "tone7", "tone8", "tone9", "squeak", "click" };
	for (int i = 0; i < 12; i++) {
		NSString *name = [NSString stringWithCString:sound_names[i]];
		NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
		OSStatus status = AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundIDs[i]);
		if (status)
			NSLog(@"error loading sound:  %d", name);
	}

    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[MainView quit];
}

- (void) dealloc {
    [window release];
    [view release];
    [super dealloc];
}

+ (void) playSound: (int) which {
	AudioServicesPlaySystemSound(soundIDs[which]);
}

@end
