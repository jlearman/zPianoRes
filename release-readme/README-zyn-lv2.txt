PianoRes installation:

Copy zPianoRes-zyn-lv2.zip/zPianoRes.lv2 folder into zynthian lv2 plugin
folder, which is usually /zynthian/zynthian-plugins/lv2 .
Using Webconf, go to SOFTWARE -> Engines and click "Scan for Presets."
Then restart Zynthian.

Alternatively, go to SOFTWARE -> Engines and click "Install Plugin."

In either case, copy the IR file fromto where Zynthian UI will find it:

cp /zynthian/zynthian-my-data/presets/lv2/zPianoRes.lv2/presets/IRs/PianoRes.flac /zynthian/zynthian-my-data/files/IRs/

When you load the plugin, use its controls to load this file as the Impulse Response.

Version history:

v0.0.1 - alpha
