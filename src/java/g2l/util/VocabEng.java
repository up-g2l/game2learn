/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author upendraprasad
 */
@Entity
@Table(name = "vocab_eng", catalog = "g2ldb_dev", schema = "", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"word_id"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VocabEng.findAll", query = "SELECT v FROM VocabEng v"),
    @NamedQuery(name = "VocabEng.findByWordId", query = "SELECT v FROM VocabEng v WHERE v.wordId = :wordId"),
    @NamedQuery(name = "VocabEng.findByWord", query = "SELECT v FROM VocabEng v WHERE v.word = :word"),
    @NamedQuery(name = "VocabEng.findByPos", query = "SELECT v FROM VocabEng v WHERE v.pos = :pos"),
    @NamedQuery(name = "VocabEng.findByMeaning", query = "SELECT v FROM VocabEng v WHERE v.meaning = :meaning"),
    @NamedQuery(name = "VocabEng.findByExample", query = "SELECT v FROM VocabEng v WHERE v.example = :example"),
    @NamedQuery(name = "VocabEng.findByProvider", query = "SELECT v FROM VocabEng v WHERE v.provider = :provider"),
    @NamedQuery(name = "VocabEng.findByDateChange", query = "SELECT v FROM VocabEng v WHERE v.dateChange = :dateChange")})
public class VocabEng implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "word_id", nullable = false)
    private Integer wordId;
    @Basic(optional = false)
    @Column(nullable = false, length = 20)
    private String word;
    @Column(length = 10)
    private String pos;
    @Column(length = 100)
    private String meaning;
    @Column(length = 200)
    private String example;
    @Basic(optional = false)
    @Column(nullable = false)
    private int provider;
    @Basic(optional = false)
    @Column(name = "date_change", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateChange;

    public VocabEng() {
    }

    public VocabEng(Integer wordId) {
        this.wordId = wordId;
    }

    public VocabEng(Integer wordId, String word, int provider, Date dateChange) {
        this.wordId = wordId;
        this.word = word;
        this.provider = provider;
        this.dateChange = dateChange;
    }

    public Integer getWordId() {
        return wordId;
    }

    public void setWordId(Integer wordId) {
        this.wordId = wordId;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getPos() {
        return pos;
    }

    public void setPos(String pos) {
        this.pos = pos;
    }

    public String getMeaning() {
        return meaning;
    }

    public void setMeaning(String meaning) {
        this.meaning = meaning;
    }

    public String getExample() {
        return example;
    }

    public void setExample(String example) {
        this.example = example;
    }

    public int getProvider() {
        return provider;
    }

    public void setProvider(int provider) {
        this.provider = provider;
    }

    public Date getDateChange() {
        return dateChange;
    }

    public void setDateChange(Date dateChange) {
        this.dateChange = dateChange;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (wordId != null ? wordId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VocabEng)) {
            return false;
        }
        VocabEng other = (VocabEng) object;
        if ((this.wordId == null && other.wordId != null) || (this.wordId != null && !this.wordId.equals(other.wordId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "g2l.util.VocabEng[ wordId=" + wordId + " ]";
    }
    
}
