FLAGS = -m32 -g -c

# Togli regola per debug

all: bin/telemetry

bin/telemetry: obj/telemetry.o obj/main.o
	gcc -m32 obj/telemetry.o obj/main.o -o bin/telemetry
obj/telemetry.o: src/telemetry.s
	gcc ${FLAGS} src/telemetry.s -o obj/telemetry.o
obj/main.o: src/main.c
	gcc ${FLAGS} src/main.c -o obj/main.o

clean:
	rm -f obj/*
	rm -f bin/*			