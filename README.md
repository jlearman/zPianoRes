# zPianoRes

zPianoRes is an audio plugin that adds damper resonance to sampled pianos.
It is designed to enhance the realism of sampled pianos by simulating the
sympathetic vibrations that occur when the sustain (damper) pedal is pressed.
It is compiled for Raspberry Pi, to run on the [Zynthian](https://zynthian.org)
platform.

The code is based on [zconvo.lv2](https://github.com/x42/zconvo.lv2) written
by Robin Gareus; my thanks to him for his code and his help!

For a simpiler plugin for Windows, see [PianoRes](https://github.com/jlearman/PianoRes).
That plugin was written using [JUCE](https://juce.org) which supports a number
of platforms and plugin formats.  It wasn't efficient enough to run well on
Zynthian.

## INSTALLATION

Get the plugin, example IR files, and README by clicking the Release
link at the right of the github Code page.  These are in a zip file.
Follow the instructions in the README file.

## USAGE

Plug in zPianoRes to process the audio output your piano sample player
(sfizz, Sforzando, etc.) Unfortunately, neither sfizz doesn't pass
MIDI through, so you will need to do some audio routing on Zynthian
chains.

PianoRes will work best with sampled pianos that do not already have damper
resonance samples.  Most of these have controls to adjust the amount of
damper resonance, which you can set to zero.  If your piano does have
damper resonance samples and you can't easily disable them, you can still
use zPianoRes. [Note: editing the sfz file you can remove the resonance
sample groups.]

zPianoRes has been tested on RPi5 only.  Good luck on RPi4.

## Zynthian Chain setup

Load the zPianoRes plugin on its own Audio+MIDI chain.
Go to the plugin settings and select the zPianoRes.flac file.
[TODO: have the plugin do this automatically!]
Load the piano (Ideally, Salamander Grand, but any piano should be OK) on another
chain, and in the Mixer for that chain, set the audio output to the zPianoRes chain.  Disable the chain's
output going to the mixer.

## CONTROLS

The plugin has a file chooser to select the impulse response (IR) file,
which is made from summing all the notes of a piano, ideally at low velocity.
An impulse file for AccurateSalamanderGrand 6.2beta2 is included by default.
The plugin also has gain controls for the dry signal (the original piano sound)
and the wet signal (the damper resonance effect).
The IR file should be a stereo audio file (e.g., WAV, AIF, OGG, or FLAC.)

The longer the IR file, the more realistic the damper resonance will sound,
but it will also use more CPU resources.  I find that longer than two
seconds doesn't affect the results much.

Several IR files are included with the plugin, and you can create your
own by recording all notes on a piano and summing them together in a DAW,
and normalizint it

[TODO] The plugin has [will have] a release time control, which adjusts how quickly the
damper resonance fades out as the sustain pedal is released.

## CREATING YOUR OWN IR FILE

While the supplied IR file should sound reasonable for most grand pianos,
you can create a custom IR file for your favorite sampled piano in a DAW.

Simply sample all the notes from A0 (lowest piano note) through the highest
undamped note on your sampled piano and sum them all.  To make it a bit
easier, you can make a number of MIDI tracks where each plays a set of notes,
and render the audio.  Adjust the volume so that the result is nearly
normalized (that is, above say -3dBFS but not clipping.)
e sure to do a fade out at the end.

WAV and FLAC formats are supported for the IR file.
Any sample rate and bit depth is fine, but I suggest
16 bits at 48 KHz.  Higher bit depths won't make audible differences,
and 48 KHz is a commonly used sample rate.
