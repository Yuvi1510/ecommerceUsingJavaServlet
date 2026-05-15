package util;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

public class Validation {

    //Checks if the image has a valid extension.
    public static boolean isValidImageExtension(String imageName) {
        if (imageName == null || !imageName.contains(".")) return false;
        String extension = imageName.substring(imageName.lastIndexOf(".") + 1).toLowerCase();
        return "jpg".equals(extension) || "jpeg".equals(extension) || "png".equals(extension) || "gif".equals(extension);
    }

    //Standard Email validation using Regex.
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    //Validates Nepal-specific phone numbers (Starts with 98 or 97 and is 10 digits).
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^9[78]\\d{8}$");
    }

    /*Ensures password is at least 8 characters long.*/
    public static boolean isStrongPassword(String password) {
        return password != null && password.length() >= 8;
    }

    //Validates that names (First/Last) contain only alphabets.
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[a-zA-Z\\s]{2,30}$");
    }

    /*
     Validates the Date of Birth.
     Ensures the user is at least 13 years old to use the e-commerce platform.
     */
    public static boolean isValidAge(String dobString) {
        if (dobString == null || dobString.isEmpty()) return false;
        try {
            LocalDate dob = LocalDate.parse(dobString);
            LocalDate now = LocalDate.now();
            return Period.between(dob, now).getYears() >= 13;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    //Validates the address field.
    public static boolean isValidAddress(String address) {
        // Checks if address is not null and has a reasonable length
        return address != null && address.trim().length() >= 5 && address.length() <= 100;
    }
}