package com.tcs.ipp.controller;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class IPPControllerTest {

    @Test
    void generateMatchRate() {
       new  IPPController().getMatchedProjects("some skills");
    }
}