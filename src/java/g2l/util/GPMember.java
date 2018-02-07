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
public class GPMember implements Serializable {
    
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
    
    private String id;
    private String password;
    private String name;
    private String login;
    private String email;
    private String token;
    private String userType;
    private String userStatus;
    private String userLevel;
    private String userSince;
    
    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(String userLevel) {
        this.userLevel = userLevel;
    }

    public String getUserSince() {
        return userSince;
    }

    public void setUserSince(String userSince) {
        this.userSince = userSince;
    }


    
    public GPMember() {
        propertySupport = new PropertyChangeSupport(this);
    }
    
    public String getSampleProperty() {
        return sampleProperty;
    }
    
    public void setSampleProperty(String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        getPropertySupport().firePropertyChange(getPROP_SAMPLE_PROPERTY(), oldValue, sampleProperty);
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
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @return the login
     */
    public String getLogin() {
        return login;
    }

    /**
     * @return the serType
     */
    public String getUserType() {
        return userType;
    }

    /**
     * @param propertySupport the propertySupport to set
     */
    public void setPropertySupport(PropertyChangeSupport propertySupport) {
        this.propertySupport = propertySupport;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * @param serType the serType to set
     */
    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
