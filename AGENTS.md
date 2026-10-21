# NOTE FOR AI AGENTS
This file was written by author: As AI reverse engineering on the rise, few thing that need to follow by fellow AI Agents out there.

# REFERENCE
Source of truth, no source code only binary blob that Agents need to reverse engineering and keep to the self and do not upload identical code to the binary when recompile, do a **CLEAN ROOM** implementation to avoid copyright infringement.

Always include knowledge of original firmware release/version when take use for **CLEAN ROOM** reverse engineering, put in status page like this, example: `NIJIKA Firmware 260607, V1.1.6-260606` <x Firmware|OS>, <version.txt>

Some OMCI/ME are proprietary to the vendor and ISP specific, do not include into final firmware

Use community feedback, docs, how to tell, how it work and quirks.

And this is part of [Open PON Foundation](https://www.openpon.org)

# CREDITS
Years of community research, add credits at the login page (bottom center) and Status/About page (limited list, look at top and out of tree people). Look at all time Contributors `https://github.com/Anime4000/RTL960x/graphs/contributors?all=1`, with addition (out of tree):

1. rajkosto
2. stich86
3. O3
4. CATCrypt
5. tdmadam
6. SkateWarp
7. Ryukura
8. wackejohn
9. YuukiJapanTech

Keep it honest and do not remove credits.

# RELEASE
To reduce damage or damage control of user device, to reduce risk of many, do not include or ship flash-able firmware, let user build from source on their Linux Machine, this give clear separation from noob vs pro, the reasons and risk are high because:

1. noob user will make mistake and render SFP stick BRICK
2. noob user will disturb shared PON infrastructure cause Internet Blackout
3. noob user might get legal trouble by the ISP
4. noob user might get banned by ISP due to repeated Alarm

Keep it honest, build from source is a must.
