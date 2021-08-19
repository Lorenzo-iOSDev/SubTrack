//
//  AllSubscriptionsViewModel.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 4/07/21.
//

import SwiftUI

final class SubTrackViewModel: ObservableObject {
    
    //Saved Data
    @AppStorage("subscriptions") private var subscriptionsData: Data?
    
    //Subscription Arrays
    @Published var subscriptions: [Subscription] = [] // should be empty array, using mock data to test
    @Published var sortedSubscriptions: [Subscription] = []
    
    //Upcoming Subscriptions Arrays
    @Published var today: [Subscription] = []
    @Published var tomorrow: [Subscription] = []
    @Published var thisWeek: [Subscription] = []
    @Published var thisMonth: [Subscription] = []
    
    //View Dependent bools
    @Published var isShowingAddSubscription = false
    @Published var isShowingDetailView = false
    @Published var isShowingEditView = false
    @Published var isShowingTotalDetailView = false
    
    //AddSubscriptionView & IconPickerView
    @Published var subName = ""
    @Published var subPrice = ""
    @Published var subDate = Date()
    @Published var paymentFreqPicked = 1
    @Published var symbolPicked = 0
    
    //EditSubscriptionView
    @Published var newName = ""
    @Published var newPrice = ""
    @Published var newDate = Date()
    @Published var newPaymentFreq = 1
    @Published var newSymbol = 0
    
    //IconPickerView
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    //SubscriptionDetailView
    @Published var selectedSubscription: Subscription?
    
    //AlertItem
    @Published var alertItem: AlertItem?
    
    var currentDate = Date()
    
    var totalPrice: Double {
        var total = 0.00
        for sub in subscriptions {
            total += sub.price
        }
        
        return total
    }
    
    func filterSubscriptions() {
        today = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Today}
        tomorrow = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Tomorrow}
        thisWeek = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisWeek}
        thisMonth = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisMonth}
    }
    
    func addSubscription() {
        guard let priceDouble = Double(subPrice) else {
            alertItem = AlertContext.invalidDouble
            return
        }
        
        var paymentDate = Date()
        
        switch paymentFreqPicked {
        case 0:
            paymentDate = subDate.nextWeek()
            
        case 1:
            paymentDate = subDate.nextMonth()
        
        case 2:
            paymentDate = subDate.nextQuarter()
            
        case 3:
            paymentDate = subDate.nextHalfYear()
            
        case 4 :
            paymentDate = subDate.nextYear()
            
        default:
            paymentDate = subDate.nextMonth()
        }
        
        let newSub = Subscription(serviceName: subName,
                                  paymentFrequency: PaymentFrequency.allCases[paymentFreqPicked],
                                  serviceSymbol: Symbols.allCases[symbolPicked],
                                  price: priceDouble,
                                  subStartDate: subDate,
                                  paymentDate: paymentDate)
        
        subscriptions.append(newSub)
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        saveSubscriptions()
        resetFormFields()
    }
    
    func resetFormFields() {
        subName = ""
        subPrice = ""
        subDate = Date()
        paymentFreqPicked = 1
        symbolPicked = 0
        
        newName = ""
        newPrice = ""
        newDate = Date()
        newPaymentFreq = 1
        newSymbol = 0
    }
    
    func showAddSubscriptionsView() {
        isShowingAddSubscription = true
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
        
        saveSubscriptions()
        retrieveSubscriptions()
    }
    
    func saveSubscriptions() {
        do {
            let data = try JSONEncoder().encode(subscriptions)
            subscriptionsData = data
        } catch {
            print("Unable to save")
            alertItem = AlertContext.unableToSave
        }
    }
    
    func retrieveSubscriptions() {
        
        guard let subscriptionsData = subscriptionsData else { return } // fail silently as if it is Nil then there was no saved data in the first place
        
        do {
            subscriptions = try JSONDecoder().decode([Subscription].self, from: subscriptionsData)
        } catch {
            alertItem = AlertContext.invalidSavedData
            print("Failed to Load: Invalid Data")
            print(error.localizedDescription)
        }
        
        //check for paymentUpdates
        checkForPaymentDates()
        
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        //Debugging
//        print(Date().startOfWeek())
//        subscriptions.map { printSubscriptionUpcomingClassifiers($0) }
//        subscriptions.map { printPaymentDates($0) }
//        print("\n \n sortedSubscription size: \(sortedSubscriptions.count)")
    }
    
    func checkForPaymentDates() {
        let dueUpdates = subscriptions.filter { $0.paymentIsDue } // this works because since Subscription is a class and not a Struct, it is referenced instead of copied.
        
        if !dueUpdates.isEmpty {
            for update in dueUpdates {
                update.updatePayment()
                saveSubscriptions()
            }
        }
    }
    
    func costSoFar(of subscription: Subscription) -> Double {
        
        switch subscription.paymentFrequency {
        case .Weekly:
            var diffInWeeks = Calendar.current.dateComponents([.weekOfYear], from: subscription.subStartDate, to: subscription.paymentDate)
            if diffInWeeks.weekOfYear == 0 { diffInWeeks.weekOfYear = 1 }
            return subscription.price * Double(diffInWeeks.weekOfYear!)
            
        case .Monthly:
            var diffInMonths = Calendar.current.dateComponents([.month], from: subscription.subStartDate, to: subscription.paymentDate)
            if diffInMonths.month == 0 { diffInMonths.month = 1 }
            return subscription.price * Double(diffInMonths.month!)
            
        case .Quarterly:
            let diffInQuarter = Calendar.current.dateComponents([.month], from: subscription.subStartDate, to: subscription.paymentDate)
            
            var amountOfQuarters: Double
            
            if diffInQuarter.month!.isMultiple(of: 4) {
                amountOfQuarters = Double(diffInQuarter.month!) / 4.0
                return subscription.price * amountOfQuarters
            } else {
                return subscription.price * 1
            }
            
        case .BiAnnually:
            let diffInBiAnnualInMonths = Calendar.current.dateComponents([.month], from: subscription.subStartDate, to: subscription.paymentDate)
            
            var amountOfHalfYears: Double
            
            if diffInBiAnnualInMonths.month!.isMultiple(of: 6) {
                amountOfHalfYears = Double(diffInBiAnnualInMonths.month!) / 6.0
                return subscription.price * amountOfHalfYears
            } else {
                return subscription.price * 1
            }
            
        case .Annually:
            var diffInYears = Calendar.current.dateComponents([.year], from: subscription.subStartDate, to: subscription.paymentDate)
            if diffInYears.year == 0 { diffInYears.weekOfYear = 1}
            return subscription.price * Double(diffInYears.year!)
        }
    }
    
    func fillEditInfo() {
        
        guard let selectedSub = selectedSubscription else {
            print("error unwrapping selected subscription in fillSubInfo()")
            return
        } //alertItem?
        
        newName = selectedSub.serviceName
        newPrice = "\(selectedSub.price)"
        newDate = selectedSub.subStartDate
        
        print("\n \n \(selectedSub.subStartDate) vs \(newDate)")
        
        newPaymentFreq = selectedSub.paymentFrequency.convertToInt()
        newSymbol = selectedSub.serviceSymbol.convertToInt()
    }
    
    func saveEdit() {
        
        guard let selectedSubscription = selectedSubscription else {
            print("error unwrapping selected subscription in saveEdit()")
            return
        } // alertItem?
        
        guard let originalIndex = subscriptions.firstIndex(where: { $0 == selectedSubscription }) else {
            print("Could not find matching subscription")
            return
        }
        
        var newPaymentDate = Date()
        
        switch newPaymentFreq {
        case 0:
            newPaymentDate = newDate.nextWeek()
            
        case 1:
            newPaymentDate = newDate.nextMonth()
        
        case 2:
            newPaymentDate = newDate.nextQuarter()
        case 3:
            newPaymentDate = newDate.nextHalfYear()
            
        case 4 :
            newPaymentDate = newDate.nextYear()
            
        default:
            newPaymentDate = subDate.nextMonth()
        }
        
        guard let priceDouble = Double(newPrice) else {
            alertItem = AlertContext.invalidDouble
            return
        }
        
        let replacementSub = Subscription(serviceName: newName,
                                          paymentFrequency: PaymentFrequency.allCases[newPaymentFreq],
                                          serviceSymbol: Symbols.allCases[newSymbol],
                                          price: priceDouble,
                                          subStartDate: newDate,
                                          paymentDate: newPaymentDate)
        
        subscriptions.insert(replacementSub, at: originalIndex)
        subscriptions.remove(at: originalIndex + 1)
        
        checkForPaymentDates()
        
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        saveSubscriptions()
        resetFormFields()
        
        isShowingDetailView = false
    }
    
    func deleteButtonPressed() {
        
        guard let index = subscriptions.firstIndex(where: { $0 == selectedSubscription }) else {
            print("Could not find matching subscription")
            return
        }
        
        isShowingDetailView = false
        
        subscriptions.remove(at: index)
        saveSubscriptions()
        retrieveSubscriptions()
    }
    
    //Debugging functions
    func printPaymentDates(_ subscription: Subscription) {
        print("payment date for \(subscription.serviceName) is \(subscription.paymentDate)")
    }
    
    func printSubscriptionUpcomingClassifiers(_ subscription: Subscription) {
        print("upcoming classifier for \(subscription.serviceName) is \(String(describing: subscription.upcomingClassifier?.rawValue))")
    }
}
