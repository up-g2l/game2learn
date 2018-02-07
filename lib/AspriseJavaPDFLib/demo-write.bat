@echo off

echo --- Create a PDF (test.pdf) from two JPG files in 'img' folder ---




java -classpath .;AspriseJavaPDF.jar com.asprise.util.pdf.PDFImageWriter test.pdf img/girl.jpg img/sky.jpg

pause
		