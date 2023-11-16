trigger AccountTypeTrigger on Account (before insert, before update) {
    AccountDomain.getInstance().verifyAccountNumber(Trigger.new);
}