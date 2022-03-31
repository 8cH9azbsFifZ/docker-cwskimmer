		Patt3Ch.lst For Skimmers

CW Skimmer, CW Skimmer Server, and RTTY Skimmer Server all use a Patt3Ch.lst file to aid in discriminating between valid and busted callsigns using pattern matching with known valid callsigns.  The Patt3Ch.lst file contains those patterns.

Patt3Ch.lst has been updated to include new patterns that appeared on the air in 2016 using the Reverse Beacon Network daily raw data files (http://reversebeacon.net/raw_data/).  Analysis of the 108 million spots in those 366 files produced almost 20,000 unique patterns.  Those 20,000 patterns were ranked by how often they appeared and the 4,000 that appeared the most times were considered credible.  Of those 4,000, 584 were not in the Patt3Ch.lst version created in 2015.  The 584 are included in this new version.

To use this new version you replace the former Patt3Ch.lst.  Do this by unzipping the accompanying Patt3ch.zip file to %appdata%\Afreet\Reference\.  Skimmer will begin using this new version the next time Skimmer starts.

73 - Dick, W3OA
w3oa@roadrunner.com