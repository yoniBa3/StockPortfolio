//
//  StockSummaryDetail.swift
//  Stock portfolio
//
//  Created by Yoni on 29/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//
//import Foundation
//
//// MARK: - StockSummryDetail
//struct StockSummryDetail: Codable {
//    let quoteSummary: QuoteSummary?
//
//    enum CodingKeys: String, CodingKey {
//        case quoteSummary = "quoteSummary"
//    }
//}
//
//// MARK: - QuoteSummary
//struct QuoteSummary: Codable {
//    let result: [Result]?
//    let error: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case result = "result"
//        case error = "error"
//    }
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let summaryDetail: SummaryDetail?
//
//    enum CodingKeys: String, CodingKey {
//        case summaryDetail = "summaryDetail"
//    }
//}
//
//// MARK: - SummaryDetail
//struct SummaryDetail: Codable {
//    let forwardPE: Ask?
//    let regularMarketDayHigh: Ask?
//    let dayHigh: Ask?
//    let dividendRate: CirculatingSupply?
//    let dividendYield: CirculatingSupply?
//    let regularMarketPreviousClose: Ask?
//    let yield: CirculatingSupply?
//    let fiftyTwoWeekLow: Ask?
//    let trailingPE: Ask?
//    let askSize: AskSize?
//    let trailingAnnualDividendYield: CirculatingSupply?
//    let summaryDetailOpen: Ask?
//    let regularMarketVolume: AskSize?
//    let beta: Ask?
//    let volume: AskSize?
//    let averageVolume: AskSize?
//    let dayLow: Ask?
//    let expireDate: CirculatingSupply?
//    let currency: String?
//    let priceHint: AskSize?
//    let twoHundredDayAverage: Ask?
//    let trailingAnnualDividendRate: CirculatingSupply?
//    let openInterest: CirculatingSupply?
//    let bidSize: AskSize?
//    let fiftyTwoWeekHigh: Ask?
//    let ytdReturn: CirculatingSupply?
//    let fiftyDayAverage: Ask?
//    let regularMarketDayLow: Ask?
//    let marketCap: AskSize?
//    let fromCurrency: JSONNull?
//    let exDividendDate: CirculatingSupply?
//    let fiveYearAvgDividendYield: CirculatingSupply?
//    let tradeable: Bool?
//    let maxAge: Int?
//    let ask: Ask?
//    let bid: Ask?
//    let regularMarketOpen: Ask?
//    let volumeAllCurrencies: CirculatingSupply?
//    let priceToSalesTrailing12Months: Ask?
//    let lastMarket: JSONNull?
//    let startDate: CirculatingSupply?
//    let averageDailyVolume10Day: AskSize?
//    let volume24Hr: CirculatingSupply?
//    let averageVolume10Days: AskSize?
//    let strikePrice: CirculatingSupply?
//    let payoutRatio: PayoutRatio?
//    let previousClose: Ask?
//    let maxSupply: CirculatingSupply?
//    let circulatingSupply: CirculatingSupply?
//    let navPrice: CirculatingSupply?
//    let algorithm: JSONNull?
//    let totalAssets: CirculatingSupply?
//    let toCurrency: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case forwardPE = "forwardPE"
//        case regularMarketDayHigh = "regularMarketDayHigh"
//        case dayHigh = "dayHigh"
//        case dividendRate = "dividendRate"
//        case dividendYield = "dividendYield"
//        case regularMarketPreviousClose = "regularMarketPreviousClose"
//        case yield = "yield"
//        case fiftyTwoWeekLow = "fiftyTwoWeekLow"
//        case trailingPE = "trailingPE"
//        case askSize = "askSize"
//        case trailingAnnualDividendYield = "trailingAnnualDividendYield"
//        case summaryDetailOpen = "open"
//        case regularMarketVolume = "regularMarketVolume"
//        case beta = "beta"
//        case volume = "volume"
//        case averageVolume = "averageVolume"
//        case dayLow = "dayLow"
//        case expireDate = "expireDate"
//        case currency = "currency"
//        case priceHint = "priceHint"
//        case twoHundredDayAverage = "twoHundredDayAverage"
//        case trailingAnnualDividendRate = "trailingAnnualDividendRate"
//        case openInterest = "openInterest"
//        case bidSize = "bidSize"
//        case fiftyTwoWeekHigh = "fiftyTwoWeekHigh"
//        case ytdReturn = "ytdReturn"
//        case fiftyDayAverage = "fiftyDayAverage"
//        case regularMarketDayLow = "regularMarketDayLow"
//        case marketCap = "marketCap"
//        case fromCurrency = "fromCurrency"
//        case exDividendDate = "exDividendDate"
//        case fiveYearAvgDividendYield = "fiveYearAvgDividendYield"
//        case tradeable = "tradeable"
//        case maxAge = "maxAge"
//        case ask = "ask"
//        case bid = "bid"
//        case regularMarketOpen = "regularMarketOpen"
//        case volumeAllCurrencies = "volumeAllCurrencies"
//        case priceToSalesTrailing12Months = "priceToSalesTrailing12Months"
//        case lastMarket = "lastMarket"
//        case startDate = "startDate"
//        case averageDailyVolume10Day = "averageDailyVolume10Day"
//        case volume24Hr = "volume24Hr"
//        case averageVolume10Days = "averageVolume10days"
//        case strikePrice = "strikePrice"
//        case payoutRatio = "payoutRatio"
//        case previousClose = "previousClose"
//        case maxSupply = "maxSupply"
//        case circulatingSupply = "circulatingSupply"
//        case navPrice = "navPrice"
//        case algorithm = "algorithm"
//        case totalAssets = "totalAssets"
//        case toCurrency = "toCurrency"
//    }
//}
//
//// MARK: - Ask
//struct Ask: Codable {
//    let raw: Double?
//    let fmt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case raw = "raw"
//        case fmt = "fmt"
//    }
//}
//
//// MARK: - AskSize
//struct AskSize: Codable {
//    let raw: Int?
//    let fmt: String?
//    let longFmt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case raw = "raw"
//        case fmt = "fmt"
//        case longFmt = "longFmt"
//    }
//}
//
//// MARK: - CirculatingSupply
//struct CirculatingSupply: Codable {
//}
//
//// MARK: - PayoutRatio
//struct PayoutRatio: Codable {
//    let raw: Int?
//    let fmt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case raw = "raw"
//        case fmt = "fmt"
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
