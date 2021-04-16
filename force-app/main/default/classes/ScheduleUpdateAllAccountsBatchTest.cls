/**
 * Class test the schedule of UpdateAllAccountsBatch
 * 
 * @author JohnDWorld
 */
@isTest (seeAllData=false)
private class ScheduleUpdateAllAccountsBatchTest {
    static testMethod void ScheduleUpdateAllAccountsBatchTest(){
        Test.startTest();
        System.schedule('ScheduleUpdateAllAccountsBatch', '0 0 8 ? * 1', new ScheduleUpdateAllAccountsBatch());
        Test.stopTest();
      }
}