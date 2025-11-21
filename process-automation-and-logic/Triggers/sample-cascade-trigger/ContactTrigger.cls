trigger ContactTrigger on Contact (after update) {
    List<Account> accs = new List<Account>();

    for (Contact c : Trigger.new) {
        Account a = [
            SELECT Id, Description 
            FROM Account 
            WHERE Id = :c.AccountId LIMIT 1
        ];
        a.Description = 'Updated from Contact trigger';
        accs.add(a);
    }

    update accs;  //  Esto dispare un segundo trigger
}
