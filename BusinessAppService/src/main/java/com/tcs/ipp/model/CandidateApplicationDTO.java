package com.tcs.ipp.model;

public class CandidateApplicationDTO {

    private final Employee employee;

    private boolean isMatched;

    private boolean isApplied;

    private boolean isConfirmed;

    public CandidateApplicationDTO(Employee employee, boolean isMatched, boolean isApplied, boolean isConfirmed) {
        this.employee = employee;
        this.isMatched = isMatched;
        this.isApplied = isApplied;
        this.isConfirmed = isConfirmed;
    }

    public Employee getEmployee() {
        return employee;
    }

    public boolean isMatched() {
        return isMatched;
    }

    public void setMatched(boolean matched) {
        isMatched = matched;
    }

    public boolean isApplied() {
        return isApplied;
    }

    public void setApplied(boolean applied) {
        isApplied = applied;
    }

    public boolean isConfirmed() {
        return isConfirmed;
    }

    public void setConfirmed(boolean confirmed) {
        isConfirmed = confirmed;
    }
}
