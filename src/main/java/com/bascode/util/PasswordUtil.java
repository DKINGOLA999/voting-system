//package com.bascode.util;
//
//import org.mindrot.jbcrypt.BCrypt;
//
//public class PasswordUtil {
//
//    public static String hashPassword(String plainTextPassword) {
//    	
//        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
//    }
//
//    // 2. Verify the password during login
//    public static boolean checkPassword(String plainTextPassword, String storedHash) {
//        return BCrypt.checkpw(plainTextPassword, storedHash);
//    }
//}

package com.bascode.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean checkPassword(String password, String hashed) {
        return BCrypt.checkpw(password, hashed);
    }
}