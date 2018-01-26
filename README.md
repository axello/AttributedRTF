# AttributedRTF
I believed there was a unicode bug in the export of AttributedString to RTF. Turns out I was not exporting AttributedString but String.

I created this playground to figure out what I was doing wrong. I figured it out.

## What I did wrong
First of all: I *import* an RTF text into a String, to manipulate certain tags and insert new texts. I do this on a String level, to keep the RTF tags intact. This works for all the tags and ASCII text.

**However**, when I subsequently *export* the string, all the inserted strings with diacritics are not translated into their proper RTF code, because it assumes the string is just a bunch of data.

In my playground you can play with this:

 - localString() : simply export an AttributedString as RTF;
 - templateString() : read an RTF template in a String, do manipulations, and write the RTF. **This is wrong**;
 - templateAttributedString() : read an RTF template into an AttributedString, do manipulations, and export the AttributedString as RTF.

## Solution
In short: I need to *import* not as a String, but as an AttributedString, and insert AttributedStrings, which is slightly more cumbersome. Then I can *export* the AttributedString as an RTF, and the diacritics are properly converted into RTF.

## Caveat
This playground creates several rtf documents in your Documents folder.