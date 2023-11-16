@isTest
public with sharing class AccountTriggerTest {
    @isTest
    static void insetAccount(){
        List<Account> contas = new List<Account>();

        contas.add(new Account(
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId(),
            Name = 'Teste',
            Tipo_da_conta__c = 'CNPJ',
            AccountNumber = '21421645000178'
        ));

        contas.add(new Account(
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId(),
            Name = 'Teste',
            Tipo_da_conta__c = 'CPF',
            AccountNumber = '95171157090'
        ));

        Test.startTest();
        insert contas;
        List<Account> result = [SELECT Id FROM ACCOUNT];
        System.assertEquals(2, result.size());
        Test.stopTest();
    }

    @isTest
    static void insetErrorAccount(){
        List<Account> contas = new List<Account>();

        contas.add(new Account(
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId(),
            Name = 'Teste',
            Tipo_da_conta__c = 'CNPJ',
            AccountNumber = '214216450001'
        ));

        contas.add(new Account(
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId(),
            Name = 'Teste',
            Tipo_da_conta__c = 'CPF',
            AccountNumber = '951711570'
        ));

        Test.startTest();
        try {
            insert contas;
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Número do cliente é inválido'));
        }
        Test.stopTest();
    }
}