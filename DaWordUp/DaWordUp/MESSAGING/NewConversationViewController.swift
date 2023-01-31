//
//  NewConversationViewController.swift
//  DaWordUp
//
//  Created by Consultant on 1/30/23.
//

import UIKit
import MessageKit

struct Sender: SenderType{
    
    var senderId: String
    var displayName: String
    
}
struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

class NewConversationViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "Uchiha Clan")
    let otherUser = Sender(senderId: "other", displayName: "Uzumaki Clan")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-864000), kind: .text("Narutooooo!!!")))
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-664000), kind: .text("Sasukeeeee!!!")))
        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-564000), kind: .text("Why don't you let me go? ")))
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-264000), kind: .text("Because you are my best friend!")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-164000), kind: .text("I'll just have to sever that bond.")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        // Do any additional setup after loading the view.
    }
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }

}
