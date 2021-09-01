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
    @Published var nextMonthBeyond: [Subscription] = []
    
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
    
    //NotificationManager
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    //Computed property used in TotalCard
    //To show how much is left to pay within the month
    var costThisMonth: Double {
        let calendar = Calendar.autoupdatingCurrent
        let currentDate = Date()
        
        var total = 0.00
        
        for sub in subscriptions {
            let currentDateComponent = calendar.dateComponents([Calendar.Component.month], from: currentDate)
            let subscriptionDateComponent = calendar.dateComponents([Calendar.Component.month], from: sub.paymentDate)
            
            if subscriptionDateComponent.month == currentDateComponent.month {
                switch sub.paymentFrequency {
                case .Weekly:
                    total += sub.price * 4
                case .Monthly:
                    total += sub.price
                case .Quarterly:
                    total += sub.price / 4
                case .BiAnnually:
                    total += sub.price / 6
                case .Annually:
                    total += sub.price / 12
                }
            }
        }
        
        return total
    }
    
    //Computed property used in TotalCostDetailView
    //Calculates the average cost per day over a year
    var costPerDay: Double {
        var total = 0.00
        
        for sub in subscriptions {
            switch sub.paymentFrequency {
            case .Weekly:
                total += sub.price * 52.17857
            case .Monthly:
                total += sub.price * 12
            case .Quarterly:
                total += sub.price * 4
            case .BiAnnually:
                total += sub.price * 2
            case .Annually:
                total += sub.price
            }
        }
        
        return total / 365
    }
    
    //Computed property used in TotalCostDetailView
    //Calculates the average cost per day over a year
    var costPerYear: Double{
        var total = 0.00
        
        for sub in subscriptions {
            switch sub.paymentFrequency {
            case .Weekly:
                total += sub.price * 52.17857
            case .Monthly:
                total += sub.price * 12
            case .Quarterly:
                total += sub.price * 4
            case .BiAnnually:
                total += sub.price * 2
            case .Annually:
                total += sub.price
            }
        }
        
        return total
    }
    
    //Computed property used in TotalCostDetailView
    //Calculates the average cost per day over a year
    var costPerHalfYear: Double{
        var total = 0.00
        
        for sub in subscriptions {
            switch sub.paymentFrequency {
            case .Weekly:
                total += sub.price * 52.17857
            case .Monthly:
                total += sub.price * 12
            case .Quarterly:
                total += sub.price * 4
            case .BiAnnually:
                total += sub.price * 2
            case .Annually:
                total += sub.price
            }
        }
        
        return total / 2
    }
    
    //Function used in UpcomingSubscriptionsView
    //Filters subscriptions into an arrays that classify them as either due Today, Tomorrow, This Week or This Month
    func filterSubscriptions() {
        today = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Today}
        tomorrow = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.Tomorrow}
        thisWeek = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisWeek}
        thisMonth = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.ThisMonth}
        nextMonthBeyond = sortedSubscriptions.filter { $0.upcomingClassifier == Upcoming.SubsequentMonths}
    }
    
    //Function used in AddSubscriptionView modal
    //Takes data from the form and creates a new subscription item and adds it into subscription array
    //Also re-does sortedSubscription array and filters subscriptions into classified arrays as well.
    //Also adds notification call
    func addSubscription() {
        if subName.isEmptyIncWhiteSpace() {
            alertItem = AlertContext.invalidForm
            return
        }
        
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
        
        newSub.updatePayment()
        
        subscriptions.append(newSub)
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        let date = Date()
        print("\n\n \(newSub.paymentDate)")
        notificationManager.sendNotification(id: newSub.id.uuidString,
                                             title: newSub.serviceName,
                                             subtitle: nil,
                                             body: "Payment for \(newSub.serviceName) is due",
                                             sendIn: newSub.paymentDate.timeIntervalSince(date))
        
        saveSubscriptions()
        resetFormFields()
        
        isShowingAddSubscription = false
    }
    
    //Resets all variables used for AddSubscriptionView and Edit SubscriptionView
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
    
    //Deletes subscription at a certain index, used for swipe to delete in AllSubscriptionsView
    func deleteSubscription(at offsets: IndexSet) {
        
        notificationManager.removeNotification(id: subscriptions[offsets.first!].id.uuidString)
        
        subscriptions.remove(atOffsets: offsets)
        
        saveSubscriptions()
        retrieveSubscriptions()
    }
    
    //Saves subscriptions by encoding subscriptions into subscriptionData JSON
    func saveSubscriptions() {
        do {
            let data = try JSONEncoder().encode(subscriptions)
            subscriptionsData = data
        } catch {
            print("Unable to save")
            alertItem = AlertContext.unableToSave
        }
    }
    
    //Loads and decodes saved data JSON back into subscription array
    //Also checks for payment dates, sorts and filters subscriptions
    //Used to refresh views
    func retrieveSubscriptions() {
        guard let subscriptionsData = subscriptionsData else { return } // fail silently as if it is Nil then there was no saved data in the first place
        
        do {
            subscriptions = try JSONDecoder().decode([Subscription].self, from: subscriptionsData)
        } catch {
            alertItem = AlertContext.invalidSavedData
            print("Failed to Load: Invalid Data")
            print(error.localizedDescription)
        }
        
        checkForPaymentDates()
        
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
    }
    
    //Function to check if any payments are due and to update the payment date using Subscription Models updatePayment() function
    //Also adds a new notification call for next payment due date
    func checkForPaymentDates() {
        let date = Date()
        let dueUpdates = subscriptions.filter { $0.paymentIsDue } // this works because since Subscription is a class and not a Struct, it is referenced instead of copied.
        
        if !dueUpdates.isEmpty {
            for update in dueUpdates {
                update.updatePayment()
                saveSubscriptions()
                
                notificationManager.removeNotification(id: update.id.uuidString)
                notificationManager.sendNotification(id: update.id.uuidString,
                                                     title: update.serviceName,
                                                     subtitle: nil,
                                                     body: "Payment for \(update.serviceName) is due today",
                                                     sendIn: update.paymentDate.timeIntervalSince(date))
            }
        }
    }
    
    //Function to find out the cost of a subscription so far, meaning from the time the user has signed up to said subscription
    //Does this by switching based on Payment Frequency of subscription and comparing the subscriptions start date to the next payment date
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
                return subscription.price
            }
            
        case .BiAnnually:
            let diffInBiAnnualInMonths = Calendar.current.dateComponents([.month], from: subscription.subStartDate, to: subscription.paymentDate)
            
            var amountOfHalfYears: Double
            
            if diffInBiAnnualInMonths.month!.isMultiple(of: 6) {
                amountOfHalfYears = Double(diffInBiAnnualInMonths.month!) / 6.0
                return subscription.price * amountOfHalfYears
            } else {
                return subscription.price
            }
            
        case .Annually:
            var diffInYears = Calendar.current.dateComponents([.year], from: subscription.subStartDate, to: subscription.paymentDate)
            if diffInYears.year == 0 { diffInYears.weekOfYear = 1}
            return subscription.price * Double(diffInYears.year!)
        }
    }
    
    //Function to fill EditSubscriptionView info with selected subscriptions information
    func fillEditInfo() {
        
        guard let selectedSub = selectedSubscription else {
            print("error unwrapping selected subscription in fillSubInfo()")
            alertItem = AlertContext.unableToReadSelectedSub
            return
        }
        
        newName = selectedSub.serviceName
        newPrice = "\(selectedSub.price)"
        newDate = selectedSub.subStartDate
        
        newPaymentFreq = selectedSub.paymentFrequency.convertToInt()
        newSymbol = selectedSub.serviceSymbol.convertToInt()
    }
    
    //Function to save edited subscription
    //Does this by taking new data and creating a new subscription object, finding the selected subscriptions index
    //then inserting the new subscription into the place of the old one then deleting the index of original+1
    //Also adds notification call
    func saveEdit() {
        
        if newName.isEmptyIncWhiteSpace() {
            alertItem = AlertContext.invalidForm
            return
        }
        
        guard let selectedSubscription = selectedSubscription else {
            print("error unwrapping selected subscription in saveEdit()")
            alertItem = AlertContext.unableToReadSelectedSub
            return
        }
        
        guard let originalIndex = subscriptions.firstIndex(where: { $0 == selectedSubscription }) else {
            print("Could not find matching subscription")
            alertItem = AlertContext.unableToFindMatch
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
        
        replacementSub.updatePayment()
        
        let date = Date()
        notificationManager.removeNotification(id: selectedSubscription.id.uuidString)
        notificationManager.sendNotification(id: replacementSub.id.uuidString,
                                             title: replacementSub.serviceName,
                                             subtitle: nil,
                                             body: "Payment for \(replacementSub.serviceName) is due today",
                                             sendIn: replacementSub.paymentDate.timeIntervalSince(date))
        
        sortedSubscriptions = subscriptions.filter { $0.upcomingClassifier != nil }
        sortedSubscriptions.sort(by: { $0.sortPriority < $1.sortPriority })
        filterSubscriptions()
        
        saveSubscriptions()
        resetFormFields()
        
        isShowingEditView = false
        isShowingDetailView = false
    }
    
    //Function used in SubscriptionDetailView to Delete chosen subscription
    //Works by finding the index of the selected subscription and deleted that index
    //Then refreshing arrays by saving and retrieving
    func deleteButtonPressed() {
        
        guard let selectedSubscription = selectedSubscription else {
            print("error unwrapping selected subscription in deleteButtonPressed()")
            alertItem = AlertContext.unableToReadSelectedSub
            return
        }
        
        notificationManager.removeNotification(id: selectedSubscription.id.uuidString)
        
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
    //Functions used when debugging
    func printPaymentDates(_ subscription: Subscription) {
        print("payment date for \(subscription.serviceName) is \(subscription.paymentDate)")
    }
    
    func printSubscriptionUpcomingClassifiers(_ subscription: Subscription) {
        print("upcoming classifier for \(subscription.serviceName) is \(String(describing: subscription.upcomingClassifier?.rawValue))")
    }
}
