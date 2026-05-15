package util;

public class Validation {

    // Existing image check
    public static boolean isValidImageExtension(String imageName){
        if (imageName == null) return false;
        String extension = imageName.substring(imageName.lastIndexOf(".") + 1).toLowerCase();
        return "jpg".equals(extension) || "jpeg".equals(extension) || "png".equals(extension) || "gif".equals(extension);
    }

    //Email format validation
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    // Phone number validation
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^9[78]\\d{8}$");
    }

    // NEW: Strong password check
    public static boolean isStrongPassword(String password) {
        return password != null && password.length() >= 8;
    }
}