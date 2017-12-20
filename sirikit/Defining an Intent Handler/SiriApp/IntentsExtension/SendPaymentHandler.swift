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
  
  func confirm(intent: INSendPaymentIntent,
               completion: @escaping (INSendPaymentIntentResponse) -> Void) {
    
  }
  
  func handle(intent: INSendPaymentIntent,
              completion: @escaping (INSendPaymentIntentResponse) -> Void) {
    
    
  }
  
  //optional
  func resolvePayee(for intent: INSendPaymentIntent,
                    with completion: @escaping (INPersonResolutionResult) -> Void) {
    
  }
  
  //optional
  func resolveCurrencyAmount(
    for intent: INSendPaymentIntent,
    with completion: @escaping (INCurrencyAmountResolutionResult) -> Void) {
    
  }
  
  func resolveNote(for intent: INSendPaymentIntent,
                   with completion: @escaping (INStringResolutionResult) -> Void) {
    
  }
  
}
