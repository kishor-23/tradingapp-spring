package com.chainsys.tradingapp.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Nominee {
    private int nomineeId;
    private String nomineeName;
    private String relationship;
    private String phoneno;
    private int userId;
}