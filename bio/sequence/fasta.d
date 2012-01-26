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

class entry {

  /* get an entry name */
  this(string name){
    this.name = name;
  }

  /* get a sequence */
  this(string seq){
    this.seq = seq;
  }

  /* read a name*/
  pure get_name(){
    return name;
  }

  /* read a sequence */
  pure get_seq(){
    return seq;
  }


  /* entries is an array of entry */
  alias entry[] entries;


 /*default constructor */
  this(){}
  private:
  string name;
  string seq;
};


