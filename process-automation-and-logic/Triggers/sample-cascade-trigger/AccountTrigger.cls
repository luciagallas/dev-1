trigger AccountTrigger on Account (after update) {
    List<Opportunity> opps = new List<Opportunity>();

    for (Account a : Trigger.new) {
        Opportunity o = [
            SELECT Id, Description 
            FROM Opportunity 
            WHERE AccountId = :a.Id LIMIT 1
        ];
        o.Description = 'Updated from Account trigger';
        opps.add(o);
    }

    update opps; // 🔥 Esto sigue la cascada
}
