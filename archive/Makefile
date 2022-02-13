

TARGET=archive.md

.PHONY: $(TARGET)

all: $(TARGET)

clean:
	rm -f $(TARGET)

$(TARGET):
	@echo Build $(TARGET)
	@sed  -i '' -e '/wiki links for foam graph/,/end wiki links/d' $(TARGET)
	@echo '% wiki links for foam graph' >> $(TARGET)
	@FILES="$$(find . -type f -mindepth 1 -maxdepth 1 | egrep -v "(\b/(TARGET)\b|Makefile)" | sed -e 's/^\.\///' | sort )"; \
	 for FILE in $$FILES; do \
	  echo "% [[$${FILE%%.md}]]" >> $(TARGET); \
	done;
