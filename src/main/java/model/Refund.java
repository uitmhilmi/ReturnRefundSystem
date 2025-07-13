/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Refund {
    private int refundId;
    private int requestId;
    private BigDecimal amount;
    private String method;
    private Timestamp processedAt;
    private int processedBy;
    
    public Refund() {}
    
    public Refund(int requestId, BigDecimal amount, String method, int processedBy) {
        this.requestId = requestId;
        this.amount = amount;
        this.method = method;
        this.processedBy = processedBy;
    }
    
    public int getRefundId() { return refundId; }
    public void setRefundId(int refundId) { this.refundId = refundId; }
    
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    
    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }
    
    public Timestamp getProcessedAt() { return processedAt; }
    public void setProcessedAt(Timestamp processedAt) { this.processedAt = processedAt; }
    
    public int getProcessedBy() { return processedBy; }
    public void setProcessedBy(int processedBy) { this.processedBy = processedBy; }
}