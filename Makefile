#brew install wget
#brew install tesseract
#brew install imagemagick

images/moses1.jpg:
	wget -nd -r -l 1 -P images -A jpeg,jpg http://www.bridgeandtunnelclub.com/detritus/moses/response.htm
	touch images/moses1.jpg

images/resized_moses%: images/moses%
	convert $< -resample 300x300 $@

images/cleaned_moses%: images/resized_moses%
	#https://code.google.com/p/tesseract-ocr/wiki/ImproveQuality
	#http://www.fmwconcepts.com/imagemagick/textcleaner/index.php
	sh scripts/textcleaner.sh -g -f 20 -o 5 -s 1  -e normalize $< $@

text/moses%: images/cleaned_moses%.jpg
	mkdir -p text
	tesseract $< $@

# tesseract adds an extra '.txt' howeer if i remove it in the rule make no longer
# recognizes the rule
alltext: text/moses1 text/moses2 text/moses3 text/moses4 \
	       text/moses5 text/moses6 text/moses7 text/moses8 \
	       text/moses9 text/moses10 text/moses11 text/moses12 \
	       text/moses13 text/moses14 text/moses15 text/moses16 \
	       text/moses17 text/moses18 text/moses19 text/moses20 \
	       text/moses21 text/moses22 text/moses23
	python scripts/concat_text.py
  
.SECONDARY:

clean:
	rm -rf images/resized_*
	rm -rf images/cleaned_*
