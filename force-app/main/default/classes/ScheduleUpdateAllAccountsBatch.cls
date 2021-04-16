/**
 * Class to schedule UpdateAllAccountsBatch
 * use this class with this method: System.schedule()
 * 
 * @author JohnDWorld
 */
global class ScheduleUpdateAllAccountsBatch implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new UpdateAllAccountsBatch());
    }
}