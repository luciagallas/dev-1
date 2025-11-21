// This class demonstrates how SOQL injection can occur when user input is concatenated
// directly into a dynamic query, and how to prevent it using escapeSingleQuotes().

public with sharing class SoqlInjectionExample {

    // ❌ Vulnerable method — user input is not sanitized
    public static List<Account> searchAccountsUnsafe(String userInput) {
        String query =
            'SELECT Id, Name FROM Account ' +
            'WHERE Name LIKE \'%' + userInput + '%\'';
        return Database.query(query);
    }

    // ✅ Safe method — user input is sanitized to prevent SOQL injection
    public static List<Account> searchAccountsSafe(String userInput) {
        String safeInput = String.escapeSingleQuotes(userInput);
        String query =
            'SELECT Id, Name FROM Account ' +
            'WHERE Name LIKE \'%' + safeInput + '%\'';
        return Database.query(query);
    }
}
