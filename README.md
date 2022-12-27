*** TODO ***

1. Add RFCs: "https://datatracker.ietf.org/api/v1/doc/docalias/?name__startswith=rfc&document__name__contains=%@&document__type=draft", wg_abbr
2. print pdf version of drafts
3. add local time
4. detail view moving from open slides to try and open drafts gives error
5. In group list view, select, then filter, then select crashes
6. pdf previews
7. fallback when no native HTML version of draft
8. Add draft / presentation / charter / agenda date to download list
9. Only gets the first 20 drafts right now
10. Recording tab (2nd) on Oauth doesn't always get activated.
    recording menu item isn't always active (observed object problem?)
11. fix macOS popups and view sizes.
12. Show venue photo on iPhone closes window

*** Maybe ***

1. Add favorites to Rooms?
2. add spinning circle when loading the sessions for a meeting?
3. Find a way to select session favorites from detail view?
4. Add inactive drafts?
5. Add keyboard shortcuts for iPad and maybe macOS


IETF colors:
	gray: 0xc0c0c0
	dark blue: 0x434254, slightly lighter: 1A329D
	gold: 
	bof background: Color(hex: 0xbaffff, alpha: 0.2)
	dark mode links: 3A82F6

Screenshots:
	1284x2778
	1242x2208
share symbol: square.and.arrow.up

look at: .navigationSplitViewStyle(.balanced)

alternate markdown kit:
https://github.com/bmoliveira/MarkdownKit

JSON error:
Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Unable to parse empty data." UserInfo={NSDebugDescription=Unable to parse empty data.}))


crash: PlatformListViewBase has no ViewGraph, version 977faaa doesn't crash on iPad but version eb8343f does crash on iPad 12.9 6th gen simulator but fine on my iPad pro 11 

how to filter out duplicate entries in an array:

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
