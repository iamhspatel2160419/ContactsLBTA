# ContactsLBTA
TVC. fecth contacts and display... learn animation,

 (1) this code is for creating cell UicollectionView Cell  
        
        right accessory view is button view fot set star for like and dislike code
        import UIKit
        class ContactCell: UITableViewCell {
            
            // create refrence of View Controller and pass this whole cell to View Controller
            var link: ViewController?

                override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)

        //        backgroundColor = .red

                // kind of cheat and use a hack
                let starButton = UIButton(type: .system)
                starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
                starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

                starButton.tintColor = .red
                starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)

                accessoryView = starButton
            }

            @objc private func handleMarkAsFavorite() {
        //        print("Marking as favorite")
                link?.someMethodIWantToCall(cell: self)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }

        }
        
(2) when cell is passed to this methods. get particular cell index 

        func someMethodIWantToCall(cell: UITableViewCell) {
        // print("Inside of ViewController now...")
        
        // we're going to figure out which name we're clicking on
        
        // get particular cell index 
        
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        
        let hasFavorited = contact.hasFavorited
        // toggle logic fot like dislike button..
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
        // tableView.reloadRows(at: [indexPathTapped], with: .fade)
        // then change accessory view controller tint color
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
        }

(3) fetch contacts from contact diary using this function 
    
    // first import this framework
    import Contacts
    
    //  private func fetchContacts()
       {
        print("Attempting to fetch contacts today..")
        
        // create object of this class
        let store = CNContactStore()
        
        // then send request 
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access:", err)
                return
            }
            
            // if permission is granted  then below code execute. 
            if granted {
                print("Access granted")
                
                // provide array keys for fetching contacts details.. name, family, phone number
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                
                // make contact request by providing keys
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                    var favoritableContacts = [FavoritableContact]()
                    
                    // get all contacts using this method 
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                        
                        favoritableContacts.append(FavoritableContact(contact: contact, hasFavorited: false))
                        
                    //  favoritableContacts.append(FavoritableContact(name: contact.givenName + " " + contact.familyName, hasFavorited: false))
                    })
                    
                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDimensionalArray = [names]
                    
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                print("Access denied..")
            }
        } 
      }
    
   
    


     
      


