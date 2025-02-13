CXX=g++-9
CXXFLAGS=-Wall -Wextra -pedantic -Werror -std=c++17 -O0 -g
LDFLAGS=$(CXXFLAGS)
OBJ=$(SRC:.cc=.o)

all:  test_bitio test_huffman encoder decoder

test_bitio: bitio.o test_bitio.o
	$(CXX) $(LDFLAGS) -o $@ $^

test_huffman: test_huffman.o huffman.o hforest.o htree.o
	$(CXX) $(LDFLAGS) -o $@ $^

encoder: encoder.o bitio.o huffman.o hforest.o htree.o
	$(CXX) $(LDFLAGS) -o $@ $^

decoder: decoder.o  bitio.o huffman.o hforest.o htree.o
	$(CXX) $(LDFLAGS) -o $@ $^

%.o: %.cc %.hh
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) -c -o $@ $<

clean:
	rm -rf *.o test_bitio test_huffman encoder decoder

test: all 
	./test_huffman
	./test_bitio
