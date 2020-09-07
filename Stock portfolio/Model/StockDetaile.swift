//
//  StockDetaile.swift
//  Stock portfolio
//
//  Created by Yoni on 28/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation
struct StockDetaile: Codable {
    //let majorDirectHolders: Holders?
    //let netSharePurchaseActivity: NetSharePurchaseActivity?
    //let financialData: FinancialData?
    //let summaryDetail: SummaryDetail?
    let mktmData: Details?
    //let majorHoldersBreakdown: MajorHoldersBreakdown?
    //let institutionOwnership: Ownership?
    let summaryProfile: SummaryProfile?
    //let insiderHolders: Holders?
    //let defaultKeyStatistics: DefaultKeyStatistics?
    //let quoteType: QuoteType?
    //let fundOwnership: Ownership?
    //let details: Details?
    let symbol: String?
    //let pageViews: PageViews?
    let earnings: StockDetaileEarnings?
    //let quoteData: QuoteData?
    //let esgScores: EsgScores?
    //let insiderTransactions: InsiderTransactions?
    //let calendarEvents: CalendarEvents?
    let price: Price?
    //let recommendationTrend: RecommendationTrend?
   // let upgradeDowngradeHistory: UpgradeDowngradeHistory?
    let financialsTemplate: FinancialsTemplate?
}

// MARK: - CalendarEvents
struct CalendarEvents: Codable {
    let maxAge: Int?
    let earnings: CalendarEventsEarnings?
    let exDividendDate, dividendDate: Details?
}

// MARK: - Details
struct Details: Codable {
}

// MARK: - CalendarEventsEarnings
struct CalendarEventsEarnings: Codable {
    let revenueHigh: EnterpriseValue?
    let earningsAverage: The52_WeekChange?
    let earningsDate: [The52_WeekChange]?
    let earningsHigh: The52_WeekChange?
    let revenueAverage, revenueLow: EnterpriseValue?
    let earningsLow: The52_WeekChange?
}

// MARK: - The52_WeekChange
struct The52_WeekChange: Codable {
    let raw: Double?
    let fmt: String?
}

// MARK: - EnterpriseValue
struct EnterpriseValue: Codable {
    let raw: Int?
    let fmt: String?
    let longFmt: String?
}

// MARK: - DefaultKeyStatistics
struct DefaultKeyStatistics: Codable {
    let lastCapGain: Details?
    let profitMargins, forwardEps: The52_WeekChange?
    let beta3Year: Details?
    let pegRatio: The52_WeekChange?
    let floatShares: EnterpriseValue?
    let sharesShortPreviousMonthDate: The52_WeekChange?
    let category: JSONNull?
    let lastFiscalYearEnd, dateShortInterest: The52_WeekChange?
    let sharesOutstanding: EnterpriseValue?
    let heldPercentInstitutions, priceToBook: The52_WeekChange?
    let priceToSalesTrailing12Months: Details?
    let maxAge: Int?
    let threeYearAverageReturn, totalAssets: Details?
    let sandP52WeekChange: The52_WeekChange?
    let legalType: JSONNull?
    let beta: The52_WeekChange?
    let netIncomeToCommon: EnterpriseValue?
    let nextFiscalYearEnd, trailingEps, shortRatio: The52_WeekChange?
    let ytdReturn: Details?
    let sharesShortPriorMonth: EnterpriseValue?
    let fiveYearAverageReturn: Details?
    let sharesShort: EnterpriseValue?
    let lastSplitDate: The52_WeekChange?
    let annualHoldingsTurnover: Details?
    let sharesPercentSharesOut, bookValue, the52WeekChange: The52_WeekChange?
    let fundInceptionDate: Details?
    let forwardPE: The52_WeekChange?
    let revenueQuarterlyGrowth: Details?
    let heldPercentInsiders, enterpriseToRevenue, enterpriseToEbitda: The52_WeekChange?
    let morningStarRiskRating: Details?
    let earningsQuarterlyGrowth, mostRecentQuarter: The52_WeekChange?
    let priceHint: EnterpriseValue?
    let fundFamily: JSONNull?
    let morningStarOverallRating, yield: Details?
    let enterpriseValue: EnterpriseValue?
    let lastSplitFactor: String?
    let shortPercentOfFloat: The52_WeekChange?
    let lastDividendValue, annualReportExpenseRatio: Details?

    enum CodingKeys: String, CodingKey {
        case lastCapGain, profitMargins, forwardEps, beta3Year, pegRatio, floatShares, sharesShortPreviousMonthDate, category, lastFiscalYearEnd, dateShortInterest, sharesOutstanding, heldPercentInstitutions, priceToBook, priceToSalesTrailing12Months, maxAge, threeYearAverageReturn, totalAssets
        case sandP52WeekChange = "SandP52WeekChange"
        case legalType, beta, netIncomeToCommon, nextFiscalYearEnd, trailingEps, shortRatio, ytdReturn, sharesShortPriorMonth, fiveYearAverageReturn, sharesShort, lastSplitDate, annualHoldingsTurnover, sharesPercentSharesOut, bookValue
        case the52WeekChange = "52WeekChange"
        case fundInceptionDate, forwardPE, revenueQuarterlyGrowth, heldPercentInsiders, enterpriseToRevenue, enterpriseToEbitda, morningStarRiskRating, earningsQuarterlyGrowth, mostRecentQuarter, priceHint, fundFamily, morningStarOverallRating, yield, enterpriseValue, lastSplitFactor, shortPercentOfFloat, lastDividendValue, annualReportExpenseRatio
    }
}

// MARK: - StockDetaileEarnings
struct StockDetaileEarnings: Codable {
    let maxAge: Int?
    let financialsChart: FinancialsChart?
    let earningsChart: EarningsChart?
    let financialCurrency: String?
}

// MARK: - EarningsChart
struct EarningsChart: Codable {
    let currentQuarterEstimateYear: Int?
    let quarterly: [EarningsChartQuarterly]?
    let earningsDate: [The52_WeekChange]?
    let currentQuarterEstimate: The52_WeekChange?
    let currentQuarterEstimateDate: String?
}

// MARK: - EarningsChartQuarterly
struct EarningsChartQuarterly: Codable {
    let date: String?
    let actual, estimate: The52_WeekChange?
}

// MARK: - FinancialsChart
struct FinancialsChart: Codable {
    let quarterly: [FinancialsChartQuarterly]?
    let yearly: [Yearly]?
}

// MARK: - FinancialsChartQuarterly
struct FinancialsChartQuarterly: Codable {
    let date: String?
    let revenue, earnings: EnterpriseValue?
}

// MARK: - Yearly
struct Yearly: Codable {
    let date: Int?
    let revenue, earnings: EnterpriseValue?
}

// MARK: - EsgScores
struct EsgScores: Codable {
    let gmo: Bool?
    let percentile: The52_WeekChange?
    let highestControversy: Int?
    let palmOil: Bool?
    let peerSocialPerformance: PeerPerformance?
    let environmentPercentile: The52_WeekChange?
    let alcoholic, pesticides: Bool?
    let governanceScore, environmentScore: The52_WeekChange?
    let peerGovernancePerformance: PeerPerformance?
    let peerCount: Int?
    let smallArms: Bool?
    let relatedControversy: [String]?
    let animalTesting: Bool?
    let maxAge: Int?
    let controversialWeapons, militaryContract: Bool?
    let peerEsgScorePerformance: PeerPerformance?
    let furLeather, coal: Bool?
    let peerGroup: String?
    let socialScore, socialPercentile, totalEsg: The52_WeekChange?
    let peerEnvironmentPerformance: PeerPerformance?
    let nuclear, gambling: Bool?
    let ratingMonth: Int?
    let catholic, tobacco, adult: Bool?
    let ratingYear: Int?
    let governancePercentile: The52_WeekChange?
    let esgPerformance: String?
    let peerHighestControversyPerformance: PeerPerformance?
}

// MARK: - PeerPerformance
struct PeerPerformance: Codable {
    let min, avg, max: Double?
}

// MARK: - FinancialData
struct FinancialData: Codable {
    let returnOnAssets: The52_WeekChange?
    let numberOfAnalystOpinions: EnterpriseValue?
    let targetMedianPrice: The52_WeekChange?
    let totalRevenue: EnterpriseValue?
    let grossMargins, targetLowPrice: The52_WeekChange?
    let maxAge: Int?
    let currentRatio: The52_WeekChange?
    let operatingCashflow: EnterpriseValue?
    let financialCurrency: String?
    let ebitda: EnterpriseValue?
    let returnOnEquity, targetMeanPrice, revenueGrowth: The52_WeekChange?
    let grossProfits: EnterpriseValue?
    let revenuePerShare: The52_WeekChange?
    let freeCashflow: EnterpriseValue?
    let quickRatio: The52_WeekChange?
    let totalCash, totalDebt: EnterpriseValue?
    let profitMargins: The52_WeekChange?
    let recommendationKey: String?
    let currentPrice, debtToEquity, operatingMargins, targetHighPrice: The52_WeekChange?
    let totalCashPerShare, ebitdaMargins, recommendationMean, earningsGrowth: The52_WeekChange?
}

// MARK: - FinancialsTemplate
struct FinancialsTemplate: Codable {
    let maxAge: Int?
    let code: String?
}

// MARK: - Ownership
struct Ownership: Codable {
    let maxAge: Int?
    let ownershipList: [OwnershipList]?
}

// MARK: - OwnershipList
struct OwnershipList: Codable {
    let maxAge: Int?
    let organization: String?
    let pctHeld: The52_WeekChange?
    let value: EnterpriseValue?
    let reportDate: The52_WeekChange?
    let position: EnterpriseValue?
}

// MARK: - Holders
struct Holders: Codable {
    let holders: [Holder]?
    let maxAge: Int?
}

// MARK: - Holder
struct Holder: Codable {
    let maxAge: Int?
    let transactionDescription: TransactionDescription?
    let positionDirectDate, latestTransDate: The52_WeekChange?
    let positionDirect: EnterpriseValue?
    let relation: Relation?
    let name, url: String?
    let positionIndirect: EnterpriseValue?
    let positionIndirectDate: The52_WeekChange?
}

enum Relation: String, Codable {
    case chiefExecutiveOfficer = "Chief Executive Officer"
    case chiefFinancialOfficer = "Chief Financial Officer"
    case director = "Director"
    case officer = "Officer"
    case officerAndDirector = "Officer and Director"
    case president = "President"
}

enum TransactionDescription: String, Codable {
    case conversionOfExerciseOfDerivativeSecurity = "Conversion of Exercise of derivative security"
    case sale = "Sale"
    case stockGift = "Stock Gift"
}

// MARK: - InsiderTransactions
struct InsiderTransactions: Codable {
    let maxAge: Int?
    let transactions: [Transaction]?
}

// MARK: - Transaction
struct Transaction: Codable {
    let shares: EnterpriseValue?
    let moneyText: String?
    let maxAge: Int?
    let startDate: The52_WeekChange?
    let ownership: OwnershipEnum?
    let filerURL: String?
    let filerName: FilerName?
    let transactionText: String?
    let value: EnterpriseValue?
    let filerRelation: Relation?

    enum CodingKeys: String, CodingKey {
        case shares, moneyText, maxAge, startDate, ownership
        case filerURL = "filerUrl"
        case filerName, transactionText, value, filerRelation
    }
}

enum FilerName: String, Codable {
    case drummondDavidC = "DRUMMOND DAVID C"
    case hennessyJohnL = "HENNESSY JOHN L"
    case oTooleAmieThuener = "O TOOLE AMIE THUENER"
    case pichaiSundar = "PICHAI SUNDAR"
    case poratRuthM = "PORAT RUTH M"
    case schmidtEricE = "SCHMIDT ERIC E"
}

enum OwnershipEnum: String, Codable {
    case d = "D"
    case dI = "D/I"
    case i = "I"
}

// MARK: - MajorHoldersBreakdown
struct MajorHoldersBreakdown: Codable {
    let maxAge: Int?
    let institutionsCount: EnterpriseValue?
    let institutionsPercentHeld, insidersPercentHeld, institutionsFloatPercentHeld: The52_WeekChange?
}

// MARK: - NetSharePurchaseActivity
struct NetSharePurchaseActivity: Codable {
    let period: String?
    let sellInfoShares: EnterpriseValue?
    let maxAge: Int?
    let netPercentInsiderShares: The52_WeekChange?
    let sellInfoCount, totalInsiderShares, buyInfoCount, netInfoShares: EnterpriseValue?
    let buyInfoShares: EnterpriseValue?
    let buyPercentInsiderShares: The52_WeekChange?
    let netInfoCount: EnterpriseValue?
}

// MARK: - PageViews
struct PageViews: Codable {
    let longTermTrend: String?
    let maxAge: Int?
    let midTermTrend, shortTermTrend: String?
}

// MARK: - Price
struct Price: Codable {
    let symbol, currency: String?
    let lastMarket: JSONNull?
    let volume24Hr: Details?
    let preMarketSource: String?
    let regularMarketPreviousClose: The52_WeekChange?
    let postMarketChange: Details?
    let regularMarketPrice: The52_WeekChange?
    let averageDailyVolume3Month: EnterpriseValue?
    let circulatingSupply: Details?
    let preMarketTime, exchangeDataDelayedBy: Int?
    let currencySymbol: String?
    let openInterest: Details?
    let maxAge, regularMarketTime: Int?
    let strikePrice: Details?
    let preMarketChangePercent, regularMarketDayLow: The52_WeekChange?
    let fromCurrency: JSONNull?
    let regularMarketVolume: EnterpriseValue?
    let postMarketPrice: Details?
    let averageDailyVolume10Day: EnterpriseValue?
    let regularMarketOpen: The52_WeekChange?
    let toCurrency: JSONNull?
    let exchange, marketState, longName: String?
    let preMarketChange: The52_WeekChange?
    let underlyingSymbol: JSONNull?
    let regularMarketChangePercent: The52_WeekChange?
    let quoteSourceName: String?
    let regularMarketChange: The52_WeekChange?
    let exchangeName: String?
    let preMarketPrice: The52_WeekChange?
    let shortName, regularMarketSource: String?
    let priceHint: EnterpriseValue?
    let quoteType: String?
    let marketCap: EnterpriseValue?
    let volumeAllCurrencies: Details?
    let regularMarketDayHigh: The52_WeekChange?
}

// MARK: - QuoteData
struct QuoteData: Codable {
    let googl: Googl?

    enum CodingKeys: String, CodingKey {
        case googl = "GOOGL"
    }
}

// MARK: - Googl
struct Googl: Codable {
    let region, symbol, currency: String?
    let fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, regularMarketPreviousClose: The52_WeekChange?
    let invalid: Bool?
    let fiftyTwoWeekHighChange, regularMarketPrice: The52_WeekChange?
    let sharesOutstanding: EnterpriseValue?
    let exchangeTimezoneShortName: String?
    let exchangeDataDelayedBy: Int?
    let uuid: String?
    let fiftyTwoWeekHighChangePercent: The52_WeekChange?
    let firstTradeDateMilliseconds: Int?
    let regularMarketTime: The52_WeekChange?
    let isLoading: Bool?
    let regularMarketDayLow: The52_WeekChange?
    let exchangeTimezoneName: String?
    let regularMarketVolume: EnterpriseValue?
    let fiftyTwoWeekLow: The52_WeekChange?
    let regularMarketDayRange: Range?
    let fullExchangeName: String?
    let regularMarketOpen: The52_WeekChange?
    let exchange, marketState: String?
    let sourceInterval: Int?
    let longName: String?
    let gmtOffSetMilliseconds: Int?
    let triggerable, tradeable: Bool?
    let regularMarketChangePercent: The52_WeekChange?
    let quoteSourceName: String?
    let regularMarketChange: The52_WeekChange?
    let fiftyTwoWeekRange: Range?
    let shortName: String?
    let priceHint: Int?
    let messageBoardID, language, quoteType: String?
    let marketCap: EnterpriseValue?
    let fiftyTwoWeekHigh: The52_WeekChange?
    let market: String?
    let regularMarketDayHigh: The52_WeekChange?

    enum CodingKeys: String, CodingKey {
        case region, symbol, currency, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, regularMarketPreviousClose, invalid, fiftyTwoWeekHighChange, regularMarketPrice, sharesOutstanding, exchangeTimezoneShortName, exchangeDataDelayedBy, uuid, fiftyTwoWeekHighChangePercent, firstTradeDateMilliseconds, regularMarketTime, isLoading, regularMarketDayLow, exchangeTimezoneName, regularMarketVolume, fiftyTwoWeekLow, regularMarketDayRange, fullExchangeName, regularMarketOpen, exchange, marketState, sourceInterval, longName, gmtOffSetMilliseconds, triggerable, tradeable, regularMarketChangePercent, quoteSourceName, regularMarketChange, fiftyTwoWeekRange, shortName, priceHint
        case messageBoardID = "messageBoardId"
        case language, quoteType, marketCap, fiftyTwoWeekHigh, market, regularMarketDayHigh
    }
}

// MARK: - Range
struct Range: Codable {
    let raw, fmt: String?
}

// MARK: - QuoteType
struct QuoteType: Codable {
    let symbol, quoteType, shortName, longName: String?
    let exchange, exchangeTimezoneShortName, messageBoardID, market: String?
    let exchangeTimezoneName: String?
    let isEsgPopulated: Bool?
    let gmtOffSetMilliseconds: String?

    enum CodingKeys: String, CodingKey {
        case symbol, quoteType, shortName, longName, exchange, exchangeTimezoneShortName
        case messageBoardID = "messageBoardId"
        case market, exchangeTimezoneName, isEsgPopulated, gmtOffSetMilliseconds
    }
}

// MARK: - RecommendationTrend
struct RecommendationTrend: Codable {
    let trend: [Trend]?
    let maxAge: Int?
}

// MARK: - Trend
struct Trend: Codable {
    let strongSell, sell, strongBuy: Int?
    let period: String?
    let hold, buy: Int?
}

// MARK: - SummaryDetail
struct SummaryDetail: Codable {
    let forwardPE, regularMarketDayHigh, dayHigh: The52_WeekChange?
    let dividendRate, dividendYield: Details?
    let regularMarketPreviousClose: The52_WeekChange?
    let yield: Details?
    let fiftyTwoWeekLow, trailingPE: The52_WeekChange?
    let trailingAnnualDividendYield: Details?
    let askSize: EnterpriseValue?
    let summaryDetailOpen: The52_WeekChange?
    let regularMarketVolume: EnterpriseValue?
    let beta: The52_WeekChange?
    let currency: String?
    let averageVolume: EnterpriseValue?
    let dayLow: The52_WeekChange?
    let expireDate: Details?
    let volume, priceHint: EnterpriseValue?
    let twoHundredDayAverage: The52_WeekChange?
    let trailingAnnualDividendRate, openInterest: Details?
    let bidSize: EnterpriseValue?
    let fiftyTwoWeekHigh: The52_WeekChange?
    let ytdReturn: Details?
    let fiftyDayAverage, regularMarketDayLow: The52_WeekChange?
    let marketCap: EnterpriseValue?
    let fromCurrency: JSONNull?
    let exDividendDate, fiveYearAvgDividendYield: Details?
    let tradeable: Bool?
    let maxAge: Int?
    let ask, bid, regularMarketOpen: The52_WeekChange?
    let volumeAllCurrencies: Details?
    let priceToSalesTrailing12Months: The52_WeekChange?
    let lastMarket: JSONNull?
    let startDate: Details?
    let averageDailyVolume10Day: EnterpriseValue?
    let volume24Hr: Details?
    let averageVolume10Days: EnterpriseValue?
    let strikePrice: Details?
    let payoutRatio, previousClose: The52_WeekChange?
    let maxSupply, circulatingSupply, navPrice: Details?
    let algorithm: JSONNull?
    let totalAssets: Details?
    let toCurrency: JSONNull?

    enum CodingKeys: String, CodingKey {
        case forwardPE, regularMarketDayHigh, dayHigh, dividendRate, dividendYield, regularMarketPreviousClose, yield, fiftyTwoWeekLow, trailingPE, trailingAnnualDividendYield, askSize
        case summaryDetailOpen = "open"
        case regularMarketVolume, beta, currency, averageVolume, dayLow, expireDate, volume, priceHint, twoHundredDayAverage, trailingAnnualDividendRate, openInterest, bidSize, fiftyTwoWeekHigh, ytdReturn, fiftyDayAverage, regularMarketDayLow, marketCap, fromCurrency, exDividendDate, fiveYearAvgDividendYield, tradeable, maxAge, ask, bid, regularMarketOpen, volumeAllCurrencies, priceToSalesTrailing12Months, lastMarket, startDate, averageDailyVolume10Day, volume24Hr
        case averageVolume10Days = "averageVolume10days"
        case strikePrice, payoutRatio, previousClose, maxSupply, circulatingSupply, navPrice, algorithm, totalAssets, toCurrency
    }
}

// MARK: - SummaryProfile
struct SummaryProfile: Codable {
    let state, industry, zip, phone: String?
    let address1, longBusinessSummary: String?
    let maxAge: Int?
    let city: String?
    let fullTimeEmployees: Int?
    let companyOfficers: [JSONAny]?
    let sector, country: String?
    let website: String?
}

// MARK: - UpgradeDowngradeHistory
struct UpgradeDowngradeHistory: Codable {
    let history: [History]?
    let maxAge: Int?
}

// MARK: - History
struct History: Codable {
    let fromGrade: Grade?
    let action: Action?
    let epochGradeDate: Int?
    let toGrade: Grade?
    let firm: String?
}

enum Action: String, Codable {
    case actionInit = "init"
    case down = "down"
    case main = "main"
    case reit = "reit"
    case up = "up"
}

enum Grade: String, Codable {
    case buy = "Buy"
    case empty = ""
    case hold = "Hold"
    case marketOutperform = "Market Outperform"
    case marketPerform = "Market Perform"
    case neutral = "Neutral"
    case outperform = "Outperform"
    case overweight = "Overweight"
    case underperform = "Underperform"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
