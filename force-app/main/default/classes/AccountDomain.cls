public with sharing class AccountDomain {
    private static AccountDomain instance = null;
    private static String PARCEIRO = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
    private static String CONSUMIDOR = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();

    public static AccountDomain getInstance() {
      if (instance == null) {
        instance = new AccountDomain();
      }
      return instance;
    }

    public void createRecord(List<Account> accounts){
        List<Opportunity> oportunidades = new List<Opportunity>();
        List<Task> tarefas = new List<Task>();

        for(Account a : accounts){
            if(a.RecordTypeId == PARCEIRO){
                oportunidades.add(new Opportunity(
                    Name = a.Name + ' – opp Parceiro',
                    CloseDate = System.today() + 30,
                    StageName = 'Qualification',
                    AccountId = a.Id));
            }else if(a.RecordTypeId == CONSUMIDOR){
                tarefas.add(new Task(
                    Subject = 'Consumidor Final',
                    WhatId = a.Id,
                    Status = 'Not Started',
                    Priority = 'Normal'
                ));
            }
        }

        insert oportunidades;
        insert tarefas;
    }

    public void verifyAccountNumber(List<Account> accounts){
        for(Account a : accounts){
            if(a.AccountNumber != null){
                if(a.Tipo_da_conta__c == 'CPF' && !Utils.validaCPF(a.AccountNumber)){
                    a.AccountNumber.addError('Número do cliente é inválido');
                }else if(a.Tipo_da_conta__c == 'CNPJ' && !Utils.validaCNPJ(a.AccountNumber)){
                    a.AccountNumber.addError('Número do cliente é inválido');
                }
            }
        }
    }
}