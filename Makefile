__start__: obj interp __plugin__
	export LD_LIBRARY_PATH="./libs"

obj:
	mkdir obj


__lines_for_space__:
	@echo
	@echo
	@echo
	@echo
	@echo


__plugin__:
	cd plugin; make

CPPFLAGS=-Wall -g -pedantic -std=c++17 -iquote  inc
LDFLAGS=-Wall -g




interp: obj/main.o obj/LibInterf.o obj/Scene.o obj/Set4LibInterf.o obj/InterpProgram.o obj/xmlinterp.o obj/Configuration.o obj/sender.o
	g++ ${LDFLAGS} -o interp  obj/main.o obj/LibInterf.o obj/Scene.o obj/Set4LibInterf.o obj/InterpProgram.o obj/xmlinterp.o obj/Configuration.o obj/sender.o -ldl  -lpthread -lxerces-c

obj/main.o: src/main.cpp inc/InterpProgram.hpp inc/xmlinterp.hh inc/sender.hpp
	g++ -c ${CPPFLAGS} -o obj/main.o src/main.cpp

obj/LibInterf.o: src/LibInterf.cpp inc/LibInterf.hpp
	g++ -c ${CPPFLAGS} -o obj/LibInterf.o src/LibInterf.cpp

obj/Set4LibInterf.o: src/Set4LibInterf.cpp inc/Set4LibInterf.hpp
	g++ -c ${CPPFLAGS} -o obj/Set4LibInterf.o src/Set4LibInterf.cpp

obj/InterpProgram.o: src/InterpProgram.cpp inc/InterpProgram.hpp inc/sender.hpp
	g++ -c ${CPPFLAGS} -o obj/InterpProgram.o src/InterpProgram.cpp

obj/Scene.o: src/Scene.cpp inc/Scene.hpp
	g++ -c ${CPPFLAGS} -o obj/Scene.o src/Scene.cpp

obj/xmlinterp.o: src/xmlinterp.cpp inc/xmlinterp.hh
	g++ -c ${CPPFLAGS} -o obj/xmlinterp.o src/xmlinterp.cpp

obj/Configuration.o: src/Configuration.cpp inc/Configuration.hh
	g++ -c ${CPPFLAGS} -o obj/Configuration.o src/Configuration.cpp

obj/sender.o: src/sender.cpp inc/sender.hpp inc/Scene.hpp	inc/AccessControl.hh inc/Port.hh inc/MobileObj.hh
	g++ -c ${CPPFLAGS} -o obj/sender.o src/sender.cpp -lpthread

clean:
	rm -f obj/* interp core*


clean_plugin:
	cd plugin; make clean

cleanall: clean
	cd plugin; make cleanall
	cd dox; make cleanall
	rm -f libs/*
	find . -name \*~ -print -exec rm {} \;

help:
	@echo
	@echo "  Lista podcelow dla polecenia make"
	@echo 
	@echo "        - (wywolanie bez specyfikacji celu) wymusza"
	@echo "          kompilacje i uruchomienie programu."
	@echo "  clean    - usuwa produkty kompilacji oraz program"
	@echo "  clean_plugin - usuwa plugin"
	@echo "  cleanall - wykonuje wszystkie operacje dla podcelu clean oraz clean_plugin"
	@echo "             oprocz tego usuwa wszystkie kopie (pliki, ktorych nazwa "
	@echo "             konczy sie znakiem ~)."
	@echo "  help  - wyswietla niniejszy komunikat"
	@echo
	@echo " Przykladowe wywolania dla poszczegolnych wariantow. "
	@echo "  make           # kompilacja i uruchomienie programu."
	@echo "  make clean     # usuwa produkty kompilacji."
	@echo
 
