package util;

import jakarta.servlet.http.Part;

import java.awt.*;

public class Validation {
    public static boolean isValidImageExtension(String imageName){
        String extension = imageName.substring(imageName.lastIndexOf(".") + 1);

        return "jpg".equals(extension) || "jpeg".equals(extension) || "png".equals(extension) || "gif".equals(extension);
    }
}
