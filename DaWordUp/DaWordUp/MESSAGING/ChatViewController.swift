//
//  ChatViewController.swift
//  DaWordUp
//
//  Created by Consultant on 2/1/23.
//

import UIKit
import MessageKit


struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
struct Sender: SenderType{
    var photoURL: String
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    private var messages = [Message]()
    private let selfSender = Sender(photoURL: "", senderId: "1", displayName: "Sasuke Uchiha")
    private let otherSender = Sender(photoURL: "", senderId: "2", displayName: "Naruto Uzumaki")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date().addingTimeInterval(-864000), kind: .text("Narutooooo!!!")))
        messages.append(Message(sender: otherSender, messageId: "2", sentDate: Date().addingTimeInterval(-664000), kind: .text("Sasukeeeee!!!")))
        messages.append(Message(sender: selfSender, messageId: "3", sentDate: Date().addingTimeInterval(-564000), kind: .text("Why don't you let me go? ")))
        messages.append(Message(sender: otherSender, messageId: "4", sentDate: Date().addingTimeInterval(-264000), kind: .text("Because you are my best friend!")))
        messages.append(Message(sender: selfSender, messageId: "5", sentDate: Date().addingTimeInterval(-164000), kind: .text("I'll just have to sever that bond.")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

        assignbackground()
    }
    
    func assignbackground(){
        let background = UIImage(named: "Wallpaper2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
