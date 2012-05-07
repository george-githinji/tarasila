/*
 * fasta.d
 * Copyright (c) 2012 George Githinji
 * A module to parse a fasta file

 */
module fasta;

import std.stdio;
import std.stream;
import std.regex;
import std.array;
import std.algorithm;
import std.string;

class FastaParser{

  /* get a file name to process */
  this(string inputfile){
    this.inputfile = inputfile;
  }

  string[string] makeHash(){
    auto delimeter = regex(r"^>(.*)");
    auto current = appender!(char[]);
    string name;
    string[string] map;
    Stream file = new BufferedFile(inputfile);

    foreach(ulong n,char[] line; file){
      auto entry = match(line,delimeter);
      if(entry){                            // we are in the header line
        if(name){                           // write what was caught
          map[name] = current.data.idup;    // dup coz current.data is reused
        }
        name = entry.hit.idup[1..$].chomp;
        current.clear();
      }else{
        line = removechars(line," ".dup);   // remove spaces
        line = toUpper(line);               // uppercase 
        current.put(line);
      }
    }
    map[name] = current.data.idup;          // remember the last capture
    file.close();
    return map;
  }

  /* default constructor */
  this(){}

  public:
  string inputfile;
}

/* a record represents a single entry in a fasta */
class Record {

  /* get an Record name */
  this(string name){
    this.name = name;
  }

  /* get a sequence */
  this(string seq){
    this.seq = seq.toLower;
  }

  /* read a name*/
  pure string get_name(){
    return name;
  }

  /* read a sequence */
  pure string get_seq(){
    return seq;
  }

  /* return the number of characters foo */
  long count_of(string pattern){
    return countchars(get_seq,pattern);
  }

  /*return the length of the sequence */
  long seq_size(){
    auto size = seq.length;
    return size;
  }

  /*default constructor */
  this(){}

  public:
  string name;
  string seq;
}

/* Records an array*/
alias Record[] Records;

unittest{
  Record ent = new Record();
  ent.name  = "seq1";
  ent.seq   = "cggggatgata";

  assert(ent.get_name() == "seq1");
  assert(ent.get_seq()  == "cggggatgata");
}
