global class AccountSchedule implements Schedulable{

    public static String sched = '0 0 0,6,12,18 ? * MON-FRI';  //Every Day at Midnight 

    global static String scheduleMe() {
        AccountSchedule SC = new AccountSchedule(); 
        return System.schedule('Inativar contas', sched, SC);
    }

    global void execute(SchedulableContext sc) {

        AccountBatch b1 = new AccountBatch();
        Database.executeBatch(b1,50);           
    }
}