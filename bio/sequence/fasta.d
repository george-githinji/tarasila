/*
 * fasta.d
 * Copyright (c) 2012 George Githinji
 * A module to parse entries of a fasta file

 */
module fasta;

import std.stdio;
import std.stream;
import std.regex;
import std.array;
//import std.algorithm;
import std.string;

class entry {

  /* get an entry name */
  this(string name){
    this.name = name;
  }

  /* get a sequence */
  this(string seq){
    this.seq = seq.toLower;
  }

  /* read a name*/
  pure get_name(){
    return name;
  }

  /* read a sequence */
  pure get_seq(){
    return seq;
  }

  /* return the number of characters */
  ulong count(string c){
   auto total = countchars(seq,c.toLower);
   return total;
  }

  /* entries is an array of entry */
  alias entry[] Entries;


  /*default constructor */
  this(){}
  public:
  string name;
  string seq;
}

unittest{
 entry ent = new entry();
 ent.name  = "seq1";
 ent.seq   = "cggggatgata";

 assert(ent.get_name() == "seq1");
 assert(ent.get_seq()  == "cggggatgata");
}

