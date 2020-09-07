package com.ctrip.framework.apollo.portal.spi.springsecurity;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class BCrypPassword {

    @Test
    public void testPassword(){
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = encoder.encode("admin");
    }
}
