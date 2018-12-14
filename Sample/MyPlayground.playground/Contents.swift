import UIKit
import SwiftDate

// RSS1
// dc:date
let pubDateRss11 = "2018-12-13T22:56:19Z".toDate()?.date
let pubDateRss12 = "2000-01-01T12:00+00:00".toDate(DateFormats.autoFormats, region: Region.current)


// RSS2
// DateはRFC 822
let pubDateRSS21 = "Mon, 10 Dec 2018 00:30:50 +0000".toDate(style: StringToDateStyles.rss)?.date
let pubDateRSS22 = "Sat, 07 Sep 2002 0:00:01 GMT".toDate(style: StringToDateStyles.rss)?.date


// ATOM
let pubDateATOM11 = "2018-12-14T10:23:00+09:00".toDate()?.date
let pubDateATOM12 = "2018-11-20T08:00:00.000000000Z".toDate()?.date

