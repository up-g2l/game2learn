/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

/**
 *
 * @author upendraprasad
 */
public class UserTest {
    
   private String userId;
   private TestMC testMC;
   private String userAnswers;
   private int score;
  // private String timeLeft;
   //private String whenStarted;
   //private String whenFinished;
   private String status;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }


    public String getUserAnswers() {
        return userAnswers;
    }

    public void setUserAnswers(String userAnswers) {
        this.userAnswers = userAnswers;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public TestMC getTestMC() {
        return testMC;
    }

    public void setTestMC(TestMC testMC) {
        this.testMC = testMC;
    }
    
}
