//
//  SendPaymentHandler.swift
//  SiriApp
//
//  Created by Vandad on 8/17/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit
import Intents

class SendPaymentHandler: INSendPaymentIntent, INSendPaymentIntentHandling {
  
  private func person(givenName: String,
                      lastName: String,
                      imageName: String,
                      telephone: String) -> INPerson{
    
    let personHandle = INPersonHandle(value: telephone, type: .phoneNumber)
    var nameComponents = PersonNameComponents()
    nameComponents.givenName = givenName
    nameComponents.familyName = lastName
    let displayName = "\(givenName) (\(lastName))"
    let image = INImage(named: imageName)
    return INPerson(personHandle: personHandle,
                    nameComponents: nameComponents,
                    displayName: displayName,
                    image: image,
                    contactIdentifier: nil, customIdentifier: nil)
    
  }
  
  private var anthonyFoo: INPerson{
    return person(givenName: "Anthony",
                  lastName: "Foo",
                  imageName: "Alert",
                  telephone: "111-222-333")
  }
  
  private var anthonyBar: INPerson{
    return person(givenName: "Anthony",
                  lastName: "Bar",
                  imageName: "Burning",
                  telephone: "444-555-666")
  }
  
  var persons: [INPerson]{
    return [anthonyFoo, anthonyBar]
  }
  
  var defaultPerson: INPerson{
    return anthonyFoo
  }
  
  func handle(intent: INSendPaymentIntent,
              completion: @escaping (INSendPaymentIntentResponse) -> Void) {
    
    func report(code: INSendPaymentIntentResponseCode){
      completion(INSendPaymentIntentResponse(code: code, userActivity: nil))
    }
    
    report(code: .ready)
    
    guard let amount = intent.currencyAmount?.amount?.doubleValue else {
      report(code: .failure)
      return
    }
    
    //here you don't have to check the amount again since we have done that
    //already in confirm(sendPayment:completion:)
    
    //send the payment and then report success or failure
    report(code: .success)
    
  }
  
  func confirm(intent: INSendPaymentIntent,
               completion: @escaping (INSendPaymentIntentResponse) -> Void) {
    
    func report(code: INSendPaymentIntentResponseCode){
      completion(INSendPaymentIntentResponse(code: code, userActivity: nil))
    }
    
    report(code: .ready)
    
    guard let amount = intent.currencyAmount?.amount?.doubleValue else {
      report(code: .failure)
      return
    }
    
    let minimumPayment = 5.0
    let maximumPayment = 20.0
    
    if amount < minimumPayment{
      report(code: .failurePaymentsAmountBelowMinimum)
      return
    }
    
    if amount > maximumPayment{
      report(code: .failurePaymentsAmountAboveMaximum)
      return
    }
    
    //do the actual work here
    report(code: .inProgress)
    
    //when done, signal that you have either successfully finished
    //or failed
    report(code: .success) //or .failure
    
  }
  
  //optional
  func resolvePayee(for intent: INSendPaymentIntent,
                    with completion: @escaping (INPersonResolutionResult) -> Void) {
    
    guard let payee = intent.payee else {
      
      let result = INPersonResolutionResult
        .confirmationRequired(with: defaultPerson)
      
      completion(result)
      
      return
    }
    
    //do we have a person with the given display name already?
    if let foundPerson =
      persons.filter({$0.displayName == payee.displayName}).first{
      //we found a person, we can confirm that this person exists and can
      //be used
      let result = INPersonResolutionResult.success(with: foundPerson)
      completion(result)
      return
    }
    
    var foundPersons = [INPerson]()
    for person in persons{
      if person.nameComponents?.givenName?.lowercased() ==
        payee.nameComponents?.givenName?.lowercased(){
        foundPersons.append(person)
      }
    }
    
    let result: INPersonResolutionResult
    switch foundPersons.count{
    case 0:
      //we found nobody that matches the required user
      result = .confirmationRequired(with: defaultPerson)
    case 1:
      //we did find the user
      result = INPersonResolutionResult.success(with: foundPersons[0])
    default:
      //we found more than 1 user
      result = INPersonResolutionResult.disambiguation(with: foundPersons)
    }
    
    completion(result)
    
  }
  
  enum SupportedCurrencies : String{
    case USD
    case SEK
    case GBP
    
    static func allValues() -> [String]{
      let allValues: [SupportedCurrencies] = [.USD, .SEK, .GBP]
      return allValues.map{$0.rawValue}
    }
    
    static var defaultCurrency = SupportedCurrencies.USD
    
  }
  
  func resolveCurrencyAmount(
    for intent: INSendPaymentIntent,
    with completion: @escaping (INCurrencyAmountResolutionResult) -> Void) {
    
    let minimumPayment = 5.0
    let maximumPayment = 20.0
    let defaultCurrencyAmount = INCurrencyAmount(amount: 15,
                                                 currencyCode: "USD")
    
    guard let givenCurrency = intent.currencyAmount,
      let currencyCode = givenCurrency.currencyCode,
      let currencyAmount = givenCurrency.amount else {
        let result = INCurrencyAmountResolutionResult
          .confirmationRequired(with: defaultCurrencyAmount)
        completion(result)
        return
    }
    
    let currencyAmountDoubleValue = currencyAmount.doubleValue
    
    //do we support this currency code?
    let foundCurrencies = SupportedCurrencies.allValues()
      .filter{$0 == currencyCode}
    let foundCurrencyCount = foundCurrencies.count
    
    let result: INCurrencyAmountResolutionResult
    
    switch foundCurrencyCount{
      
    case 0:
      result = INCurrencyAmountResolutionResult
        .confirmationRequired(with: defaultCurrencyAmount)
      
    case 1 where currencyAmountDoubleValue >= minimumPayment &&
      currencyAmountDoubleValue <= maximumPayment:
      result = .success(with: givenCurrency)
      
    case 1:
      //the amount is not acceptable, ask for confirmation
      let amount: NSDecimalNumber = 20
      let newAmount = INCurrencyAmount(amount: amount,
                                       currencyCode: currencyCode)
      result = .confirmationRequired(with: newAmount)
      
    default:
      //the currency code gave more than one result
      
      var amounts = [INCurrencyAmount]()
      for foundCurrency in foundCurrencies{
        let amount = INCurrencyAmount(amount: currencyAmount,
                                      currencyCode: foundCurrency)
        amounts.append(amount)
      }
      
      result = .disambiguation(with: amounts)
    }
    
    completion(result)
    
  }
  
  func resolveNote(
    for intent: INSendPaymentIntent,
    with completion: @escaping (INStringResolutionResult) -> Void) {
    
    
    completion(.success(with: "This is your payment"))
    
  }
  
}
