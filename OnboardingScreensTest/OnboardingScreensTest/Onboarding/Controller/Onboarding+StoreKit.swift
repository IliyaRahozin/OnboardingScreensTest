//
//  OnboardingStoreKit.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 18.11.2023.
//

import Foundation
import StoreKit

extension OnboardingCollectionViewController: SKPaymentTransactionObserver, SKProductsRequestDelegate {
    

    func setupPurchase() {
        SKPaymentQueue.default().add(self)
        //fetchProducts()
    }
    
    
    func makePayment() {
        guard SKPaymentQueue.canMakePayments() else {
            print("User unable to make payments")
            return
        }
        guard SKPaymentQueue.default().transactions.last?.transactionState != .purchasing else {
            print("User have unfinished payment (in process)")
            return
        }
        
        let paymentRequest = SKMutablePayment()
        paymentRequest.productIdentifier = Constant.Payment.Product.premMonth.getRawValue()
        SKPaymentQueue.default().add(paymentRequest)
        
        /// by product from SKProduct elements
        //  if let product = viewModel.paymentModel.first {
        //      let paymentRequest = SKPayment(product: product)
        //      SKPaymentQueue.default().add(paymentRequest)
        //  }
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Transaction Successful")
            } else if transaction.transactionState == .failed {
                SKPaymentQueue.default().finishTransaction(transaction)
                showPurchaseRestoredAlert(
                    title: "Purchase Failed",
                    message: transaction.error?.localizedDescription ?? "Payment Error"
                )
                print("Transaction Failed")
            } else if transaction.transactionState == .restored {
                SKPaymentQueue.default().finishTransaction(transaction)
                showPurchaseRestoredAlert(
                    title: "Purchase Restored",
                    message: "Your purchase has been successfully restored."
                )
                print("Transaction restored")
            }
        }
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Constant.Payment.Product.allCases.compactMap({$0.getRawValue()})))
        request.delegate = self
        request.start()
    }
    
    private func showPurchaseRestoredAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        viewModel.setPaymentModel(with:response.products)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }    
    
}
