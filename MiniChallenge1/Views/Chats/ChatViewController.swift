//
//  ChatViewController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 12/04/22.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String = ""
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "1", displayName: "User")
    let botCat = Sender(senderId: "2", displayName: "Nyan Cat")
    
    var messages = [MessageType]()
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].sender.displayName == messages[indexPath.section - 1].sender.displayName    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messages.count else { return false }
        return messages[indexPath.section].sender.displayName == messages[indexPath.section + 1].sender.displayName
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        var avatar = Avatar(image: UIImage(imageLiteralResourceName: "default-profile"), initials: "NC")
        
        if(message.sender.senderId == "2") {
            avatar = Avatar(image: UIImage(imageLiteralResourceName: "logo"), initials: "NC")
        }
        
        avatarView.set(avatar: avatar)
        avatarView.isHidden = isNextMessageSameSender(at: indexPath)
        avatarView.layer.borderWidth = 2
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        messages.append(Message(sender: botCat,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(0),
                                kind: .text("Halo! I'm Nyan, miaw. First of all, I will help you and be your assistant to help prioritize your budget")
                               ))
        
        messages.append(Message(sender: botCat,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(10),
                                kind: .text("What do you like to be called, miaw?")
                               ))
        
        messages.append(Message(sender: currentUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(11),
                                kind: .text("Isyana Sarasvati")
                               ))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func loadMessages() {
        
    }

}
