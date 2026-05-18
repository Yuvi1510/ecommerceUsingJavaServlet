package controllers;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.SessionUtil;

import java.io.*;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

//    private static final String IMAGE_DIR =
//            "C:" + File.separator + "fatafat-kin" +
//                    File.separator + "uploads" +
//                    File.separator + "products";


//    private static final String IMAGE_DIR = System.getProperty("user.home") + File.separator + "coursework" + File.separator + "images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String IMAGE_DIR =  request.getServletContext().getRealPath("/") + File.separator + "static" + File.separator + "images" + File.separator + "uploads";
        // remove the msg from session
        SessionUtil.removeAttribute(request, "success");
        SessionUtil.removeAttribute(request,"error");

        // Extract filename from URL
        String pathInfo = request.getPathInfo(); // /abc.jpg

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String fileName = pathInfo.substring(1); // remove "/"

        File file = new File(IMAGE_DIR, fileName);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Set content type (important!)
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        // Stream file to response
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}