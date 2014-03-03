GA:*.m
	gcc -o GA *.m -framework Cocoa -framework Foundation
clean:
	rm GA