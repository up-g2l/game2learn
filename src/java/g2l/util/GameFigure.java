/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.beans.*;
import java.io.Serializable;

/**
 *
 * @author upendraprasad
 */
public class GameFigure implements Serializable {

    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    private String sampleProperty;
    private PropertyChangeSupport propertySupport;
    private int  figId;
    private String figOrigName;
    private String figKeywords;
    private String figCaption;
    private String figSource;
    private String figSaveName;
    private String figProvider;
    private String status;
    private String figCreationDate;

    public GameFigure() {
        propertySupport = new PropertyChangeSupport(this);
    }

    public String getSampleProperty() {
        return sampleProperty;
    }

    public void setSampleProperty(String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        propertySupport.firePropertyChange(PROP_SAMPLE_PROPERTY, oldValue, sampleProperty);
    }

    public void addPropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.addPropertyChangeListener(listener);
    }

    public void removePropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.removePropertyChangeListener(listener);
    }

    public int getFigId() {
        return figId;
    }

    public void setFigId(int figId) {
        this.figId = figId;
    }

    public String getFigKeywords() {
        return figKeywords;
    }

    public void setFigKeywords(String figKeywords) {
        this.figKeywords = figKeywords;
    }

    public String getFigCaption() {
        return figCaption;
    }

    public void setFigCaption(String figCaption) {
        this.figCaption = figCaption;
    }

    public String getFigSource() {
        return figSource;
    }

    public void setFigSource(String figSource) {
        this.figSource = figSource;
    }

    /**
     * @return the figOrigName
     */
    public String getFigOrigName() {
        return figOrigName;
    }

    /**
     * @return the figSaveName
     */
    public String getFigSaveName() {
        return figSaveName;
    }

    /**
     * @return the figProvider
     */
    public String getFigProvider() {
        return figProvider;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @return the figCreationDate
     */
    public String getFigCreationDate() {
        return figCreationDate;
    }

    /**
     * @param figOrigName the figOrigName to set
     */
    public void setFigOrigName(String figOrigName) {
        this.figOrigName = figOrigName;
    }

    /**
     * @param figSaveName the figSaveName to set
     */
    public void setFigSaveName(String figSaveName) {
        this.figSaveName = figSaveName;
    }

    /**
     * @param figProvider the figProvider to set
     */
    public void setFigProvider(String figProvider) {
        this.figProvider = figProvider;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @param figCreationDate the figCreationDate to set
     */
    public void setFigCreationDate(String figCreationDate) {
        this.figCreationDate = figCreationDate;
    }
}
