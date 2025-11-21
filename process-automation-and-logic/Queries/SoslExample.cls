public class SoslExample {

    // Searches the term across Contact AND Account
    public static List<List<SObject>> searchForName(String searchTerm) {
        List<List<SObject>> results = [
            FIND :searchTerm
            IN ALL FIELDS
            RETURNING 
                Contact(Id, FirstName, LastName),
                Account(Id, Name)
        ];
        return results;
    }
}
