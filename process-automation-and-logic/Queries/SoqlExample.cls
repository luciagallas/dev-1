public class SoqlExample {

    // Returns all Accounts whose Industry is 'Energy'
    public static List<Account> getEnergyAccounts() {
        List<Account> accounts = [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Industry = 'Energy'
            ORDER BY Name
        ];
        return accounts;
    }
}
