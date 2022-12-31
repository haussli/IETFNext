*** TODO ***

1. Add RFCs: "https://datatracker.ietf.org/api/v1/doc/docalias/?name__startswith=rfc&document__name__contains=%@&document__type=draft", wg_abbr
2. print pdf version of drafts
3. add local time
4. detail view moving from open slides to try and open drafts gives error
5. In group list view, select, then filter, then select crashes
6. pdf thumbnails
7. Add draft / presentation / charter / agenda date to download list
8. Only gets the first 20 drafts right now
9. in group list view, favoriting session doesn't show up in group list
10. Jump between session and location and back
11. Load basename document to support useractivity


*** Maybe ***

1. Add favorites to Rooms?
2. add spinning circle when loading the sessions for a meeting?
3. Add inactive drafts?
4. Use notes app yellow?
5. Choice of drafts formats
6. Add keyboard shortcuts for iPad


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
