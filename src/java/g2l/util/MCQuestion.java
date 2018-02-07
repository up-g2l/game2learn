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
public class MCQuestion implements Serializable {

    private static String PROP_SAMPLE_PROPERTY = "sampleProperty";

    /**
     * @return the PROP_SAMPLE_PROPERTY
     */
    public static String getPROP_SAMPLE_PROPERTY() {
        return PROP_SAMPLE_PROPERTY;
    }

    /**
     * @param aPROP_SAMPLE_PROPERTY the PROP_SAMPLE_PROPERTY to set
     */
    public static void setPROP_SAMPLE_PROPERTY(String aPROP_SAMPLE_PROPERTY) {
        PROP_SAMPLE_PROPERTY = aPROP_SAMPLE_PROPERTY;
    }
    private String sampleProperty;
    private PropertyChangeSupport propertySupport;
    private String qId;
    private String qText;
    private String qType;
    private String ansA;
    private String ansB;
    private String ansC;
    private String ansD;
    private String ansE;
    private String ansCorrect;
    private String helpLink;
    private String tags;
    private String explanation;
    private String source;
    private String provider;
    private String qStatus;
    private String simQid;
    private String figId;
    private boolean checked;

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
    private GameFigure figure;

    public GameFigure getFigure() {
        return figure;
    }

    public void setFigure(GameFigure figure) {
        this.figure = figure;
    }

    /**
     * @return the sampleProperty
     */
    public String getSampleProperty() {
        return sampleProperty;
    }

    /**
     * @return the propertySupport
     */
    public PropertyChangeSupport getPropertySupport() {
        return propertySupport;
    }

    /**
     * @return the qId
     */
    public String getqId() {
        return qId;
    }

    /**
     * @return the qText
     */
    public String getqText() {
        return qText;
    }

    /**
     * @return the qType
     */
    public String getqType() {
        return qType;
    }

    /**
     * @return the ansA
     */
    public String getAnsA() {
        return ansA;
    }

    /**
     * @return the ansB
     */
    public String getAnsB() {
        return ansB;
    }

    /**
     * @return the ansC
     */
    public String getAnsC() {
        return ansC;
    }

    /**
     * @return the ansD
     */
    public String getAnsD() {
        return ansD;
    }

    /**
     * @return the ansE
     */
    public String getAnsE() {
        return ansE;
    }

    /**
     * @return the ansCorrect
     */
    public String getAnsCorrect() {
        return ansCorrect;
    }

    /**
     * @return the helpLink
     */
    public String getHelpLink() {
        return helpLink;
    }

    /**
     * @return the tags
     */
    public String getTags() {
        return tags;
    }

    /**
     * @return the explanation
     */
    public String getExplanation() {
        return explanation;
    }

    /**
     * @param sampleProperty the sampleProperty to set
     */
    public void setSampleProperty(String sampleProperty) {
        this.sampleProperty = sampleProperty;
    }

    /**
     * @param propertySupport the propertySupport to set
     */
    public void setPropertySupport(PropertyChangeSupport propertySupport) {
        this.propertySupport = propertySupport;
    }

    /**
     * @param qId the qId to set
     */
    public void setqId(String qId) {
        this.qId = qId;
    }

    /**
     * @param qText the qText to set
     */
    public void setqText(String qText) {
        this.qText = qText;
    }

    /**
     * @param qType the qType to set
     */
    public void setqType(String qType) {
        this.qType = qType;
    }

    /**
     * @param ansA the ansA to set
     */
    public void setAnsA(String ansA) {
        this.ansA = ansA;
    }

    /**
     * @param ansB the ansB to set
     */
    public void setAnsB(String ansB) {
        this.ansB = ansB;
    }

    /**
     * @param ansC the ansC to set
     */
    public void setAnsC(String ansC) {
        this.ansC = ansC;
    }

    /**
     * @param ansD the ansD to set
     */
    public void setAnsD(String ansD) {
        this.ansD = ansD;
    }

    /**
     * @param ansE the ansE to set
     */
    public void setAnsE(String ansE) {
        this.ansE = ansE;
    }

    /**
     * @param ansCorrect the ansCorrect to set
     */
    public void setAnsCorrect(String ansCorrect) {
        this.ansCorrect = ansCorrect;
    }

    /**
     * @param helpLink the helpLink to set
     */
    public void setHelpLink(String helpLink) {
        this.helpLink = helpLink;
    }

    /**
     * @param tags the tags to set
     */
    public void setTags(String tags) {
        this.tags = tags;
    }

    /**
     * @param explanation the explanation to set
     */
    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    /**
     * @return the source
     */
    public String getSource() {
        return source;
    }

    /**
     * @return the provider
     */
    public String getProvider() {
        return provider;
    }

    /**
     * @return the qStatus
     */
    public String getqStatus() {
        return qStatus;
    }

    /**
     * @param source the source to set
     */
    public void setSource(String source) {
        this.source = source;
    }

    /**
     * @param provider the provider to set
     */
    public void setProvider(String provider) {
        this.provider = provider;
    }

    /**
     * @param qStatus the qStatus to set
     */
    public void setqStatus(String qStatus) {
        this.qStatus = qStatus;
    }

    public String getSimQid() {
        return simQid;
    }

    public String getFigId() {
        return figId;
    }

    public void setSimQid(String simQid) {
        this.simQid = simQid;
    }

    public void setFigId(String figId) {
        this.figId = figId;
    }
}
