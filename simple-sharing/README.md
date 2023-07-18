## Local to sync

I wait until there is a logged in user to use the SwiftUI syntax to access the synced realm.

```
@ObservedResults(Item.self) var syncedItems
```
```
if let localRealm = try? Realm(), let user = app.currentUser {
    let localItems = localRealm.objects(Item.self)
    for item in localItems {
        // local -> synced
        let syncedItem = Item(value: item)
        syncedItem.userId = user.id
        $syncedItems.append(syncedItem)
        // delete local
        try? localRealm.write {
            localRealm.delete(item)
        }
    }
}
```

## Delete account

Don't forget to add a delete trigger.

```
exports = function(authEvent) {
  const mongodb = context.services.get("mongodb-atlas");
  const items = mongodb.db("realm-swift-template").collection("Item");
  
  const userId = authEvent.userId
  items.deleteMany({ userId })
};
```
