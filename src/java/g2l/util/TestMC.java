/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.beans.*;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author upendraprasad
 */
public class TestMC implements Serializable {

    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    private String sampleProperty;
    private PropertyChangeSupport propertySupport;
    private String testId;
    private String testTitle;
    private String userId;
    private String qIds;
    private String[] qIdList;
    private int testDuration;
    private String testStatus;
    private Date dateFrom;
    private Date dateTo;
    private String description;
    private Date dateCreated;
    
      public String getTestTitle() {
        return testTitle;
    }

    public void setTestTitle(String testTitle) {
        this.testTitle = testTitle;
    }

    public Date getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(Date dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Date getDateTo() {
        return dateTo;
    }

    public void setDateTo(Date dateTo) {
        this.dateTo = dateTo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public TestMC() {
        propertySupport = new PropertyChangeSupport(this);
    }

    public String getSampleProperty() {
        return sampleProperty;
    }

    public void setSampleProperty(String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        getPropertySupport().firePropertyChange(PROP_SAMPLE_PROPERTY, oldValue, sampleProperty);
    }

    public void addPropertyChangeListener(PropertyChangeListener listener) {
        getPropertySupport().addPropertyChangeListener(listener);
    }

    public void removePropertyChangeListener(PropertyChangeListener listener) {
        getPropertySupport().removePropertyChangeListener(listener);
    }

    /**
     * @return the propertySupport
     */
    public PropertyChangeSupport getPropertySupport() {
        return propertySupport;
    }

    /**
     * @return the testId
     */
    public String getTestId() {
        return testId;
    }

    /**
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * @return the qIds
     */
    public String getqIds() {
        return qIds;
    }

    /**
     * @return the qIdList
     */
    public String[] getqIdList() {
        return qIdList;
    }

    /**
     * @return the testDuration
     */
    public int getTestDuration() {
        return testDuration;
    }

    /**
     * @return the testStatus
     */
    public String getTestStatus() {
        return testStatus;
    }

    /**
     * @param propertySupport the propertySupport to set
     */
    public void setPropertySupport(PropertyChangeSupport propertySupport) {
        this.propertySupport = propertySupport;
    }

    /**
     * @param testId the testId to set
     */
    public void setTestId(String testId) {
        this.testId = testId;
    }

    /**
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * @param qIds the qIds to set
     */
    public void setqIds(String qIds) {
        this.qIds = qIds;
    }

    /**
     * @param qIdList the qIdList to set
     */
    public void setqIdList(String[] qIdList) {
        this.qIdList = qIdList;
    }

    /**
     * @param testDuration the testDuration to set
     */
    public void setTestDuration(int testDuration) {
        this.testDuration = testDuration;
    }

    /**
     * @param testStatus the testStatus to set
     */
    public void setTestStatus(String testStatus) {
        this.testStatus = testStatus;
    }
}
