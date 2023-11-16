trigger AccountNumberTrigger on Account (after insert) {
    AccountDomain.getInstance().createRecord(Trigger.new);
}